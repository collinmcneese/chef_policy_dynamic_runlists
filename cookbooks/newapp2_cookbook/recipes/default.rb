#
# Cookbook:: newapp2_cookbook
# Recipe:: default
#

# Only run this cookbook logic in the presence of a specific tag
if tagged?('newapp2_cookbook_run')
  log "Running cookbook #{cookbook_name}"
  include_recipe 'newapp2_cookbook::application'
end
