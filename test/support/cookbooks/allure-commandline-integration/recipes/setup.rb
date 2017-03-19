#
# Cookbook Name:: allure-commandline-integration
# Recipe:: setup
#
# Copyright 2017, Etki
#

case node['platform']
  when /ubuntu/, /debian/
    include_recipe '::setup_debian_family'
  when /fedora/
    include_recipe '::setup_fedora'
end

include_recipe 'java'
package 'tar'
package 'gzip'