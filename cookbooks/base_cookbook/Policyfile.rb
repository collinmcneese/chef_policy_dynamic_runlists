# Policyfile.rb - Describe how you want Chef Infra Client to build your system.
# Base Policy which is applied to all systems

name 'base_cookbook'

# Where to find external cookbooks:
default_source :supermarket

# Base run_list for this policy, includes the local cookbook contents
run_list 'base_cookbook::default'

cookbook 'base_cookbook', path: '.'
# Specify where newapp_cookbook can be found.  This will allow for the cookbook to be included in the policy
#  and made available to call with `include_recipe`, but will not automatically add it to the run_list of any
#  node consuming this policy
cookbook 'newapp_cookbook', path: '../newapp_cookbook'

# The `run_list` items defined in these included policies will be applied to the run_list of a node consuming this
#  base policy
include_policy 'app_cookbook', path: '../app_cookbook/Policyfile.lock.json'
include_policy 'newapp2_cookbook', path: '../newapp2_cookbook/Policyfile.lock.json'
