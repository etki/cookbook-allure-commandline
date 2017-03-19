defaults = attribute('allure_commandline', default: {})
{
    version: '1.5.2',
    install_location: '/usr/share/allure-commandline/allure',
    binary_location: '/usr/share/allure-commandline/allure'
}.each do |k, v|
  defaults[k] = defaults.has_key?(k.to_s) ? defaults[k.to_s] : v
end

control 'allure-recipe-installation' do
  describe allure_commandline(defaults[:install_location]) do
    it { should be_working }
    it { should be_accessible_via defaults[:binary_location] }
    its('version') { should eq defaults[:version] }
  end
end
