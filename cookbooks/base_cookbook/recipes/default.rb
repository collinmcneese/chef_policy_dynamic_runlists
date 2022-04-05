#
# Cookbook:: base_cookbook
# Recipe:: default
#

log "Running cookbook #{cookbook_name}"

file "/tmp/#{cookbook_name}"

include_recipe 'newapp_cookbook' if tagged?('newapp_cookbook_run')
