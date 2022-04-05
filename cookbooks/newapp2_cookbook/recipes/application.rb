#
# Cookbook:: newapp2_cookbook
# Recipe:: default
#

# Exit this recipe if the specified tag does not exist.  This
#  is an additional safeguard in case the recipe is called directly.
return unless tagged?('newapp2_cookbook_run')

file "/tmp/#{cookbook_name}"
