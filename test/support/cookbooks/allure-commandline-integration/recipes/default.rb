#
# Cookbook Name:: allure-commandline-integration
# Recipe:: default
#
# Copyright 2017, Etki
#

include_recipe '::setup'

attributes = node['allure_commandline_integration']
suites = attributes['suite']
access_token = attributes['github_api_token'] ? attributes['github_api_token'] : ''

include_recipe 'allure-commandline'

allure_commandline suites['default']['binary']
allure_commandline suites['with-version']['binary'] do
  version suites['with-version']['version']
  github_api_token access_token
end

allure_commandline suites['with-path']['binary'] do
  path suites['with-path']['path']
  github_api_token access_token
end

allure_commandline suites['with-multiple-links']['binary'] do
  links suites['with-multiple-links']['links']
  github_api_token access_token
end

allure_commandline suites['deleted-with-path']['binary'] do
  path suites['deleted-with-path']['path']
  github_api_token access_token
  action [:create, :delete]
end

allure_commandline suites['deleted-with-version']['binary'] do
  version suites['deleted-with-version']['version']
  github_api_token access_token
  action [:create, :delete]
end

allure_commandline suites['deleted-with-multiple-links']['binary'] do
  path suites['deleted-with-multiple-links']['path']
  links suites['deleted-with-multiple-links']['links']
  github_api_token access_token
  action [:create, :delete]
end

suites['acceptance']['versions'].each do |allure_version|
  binary = sprintf(suites['acceptance']['binary_location_format'], allure_version)
  path = sprintf(suites['acceptance']['path_format'], allure_version)
  allure_commandline binary do
    version(allure_version)
    path path
    github_api_token access_token
  end
end
