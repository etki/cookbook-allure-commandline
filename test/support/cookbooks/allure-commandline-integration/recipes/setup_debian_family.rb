#
# Cookbook Name:: allure-commandline-integration
# Recipe:: setup_debian_family
#
# Copyright 2017, Etki
#

node.override['java']['jdk_version'] = 8 if node['platform'] == 'ubuntu' and node['platform_version'].to_f > 16
