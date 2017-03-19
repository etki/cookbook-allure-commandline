#
# Cookbook Name:: allure-commandline
# Recipe:: default
#
# Copyright 2017, Etki
#
# All rights reserved - Do Not Redistribute
#

allure_commandline node['allure_commandline']['binary_location'] do
  path node['allure_commandline']['install_location']
  github_api_token (node['allure_commandline']['github_api_token'] or '')
end
