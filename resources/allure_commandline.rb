resource_name :allure_commandline
default_action :create

property :version, String, required: false
property :path, String, required: false
property :links, [String, Array], name_property: true
property :url, String, required: false
property :github_api_token, String, required: false

action_class do
  def discover_url(version, token = nil)
    api = Chef::HTTP.new('https://api.github.com/repos/allure-framework/allure1')
    path = "/releases/tags/allure-core-#{version}"
    data = JSON.parse(api.get(path, token_headers(token)))
    url = data['assets'].reduce(nil) do |carrier, candidate|
      return carrier if carrier
      return candidate['browser_download_url'] if candidate['name'] == 'allure-commandline.tar.gz'
    end
    raise "Failed to find Allure commandline release url for version #{version}" unless url
    url
  end

  def token_headers(token = nil)
    (token and not token.empty?) ? {'Authorization': "token #{token}"}: {}
  end
end

action :create do
  version = (new_resource.version or node['allure_commandline']['version'])
  access_token = new_resource.github_api_token
  url = (new_resource.url or discover_url(version, access_token))
  path = (new_resource.path or "/usr/share/allure/allure-commandline/#{version}")
  links = (new_resource.links or ['/usr/bin/allure'])
  links = [links] unless links.is_a? Array

  directory path do
    recursive true
  end

  tar_extract url do
    target_dir path
    creates "#{path}/bin/allure"
  end

  links.each do |symlink|
    directory ::File.dirname(symlink) do
      recursive true
    end
    link symlink do
      to "#{path}/bin/allure"
      mode '0755'
    end
  end
end

action :delete do
  version = (new_resource.version or node['allure_commandline']['version'])
  path = (new_resource.path or "/usr/share/allure/allure-commandline/#{version}")
  links = (new_resource.links or [node['allure_commandline']['default_binary_location']])
  links = [links] unless links.is_a? Array
  links.each do |symlink|
    link symlink do
      to "#{path}/bin/allure"
      action :delete
    end
  end

  directory path do
    recursive true
    action :delete
  end
end
