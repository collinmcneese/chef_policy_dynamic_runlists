# chef_policy_dynamic_runlists

[![cookbook_tests](https://github.com/collinmcneese/chef_policy_dynamic_runlists/actions/workflows/validation.yml/badge.svg)](https://github.com/collinmcneese/chef_policy_dynamic_runlists/actions/workflows/validation.yml)

The purpose of this repository is to show specific examples of using a more dynamic run_list with Chef Infra Policy to allow for targeted run-time decisions by Chef Infra Client on nodes for actions which do not span entire Policy Groups.

## Reference

- [Chef Workstation](https://docs.chef.io/workstation/)
- [Test Kitchen](https://docs.chef.io/workstation/kitchen/)
- [Chef Infra Policy](https://docs.chef.io/policyfile/)
- [Chef Infra Node Tags](https://docs.chef.io/infra_language/node_tags/)
  - [Knife `tag`](https://docs.chef.io/workstation/knife_tag/)

## Contents

- `kitchen.yml`:  This is a Test Kitchen configuration file that can be used from the top-level of this repository to run through different scenarios:
  - `base`: Run the base Policy with default options
  - `newapp-tag`: Populate the tag `newapp-tag` which will trigger behavior to include the `newapp_cookbook`.  Uses test suite `newapp_test`.
  - `newapp2-tag`: Populate the tag `newapp2-tag` which will trigger behavior to include the `newapp2_cookbook`.  Uses test suite `newapp2_test`.
- `cookbooks/base_cookbook`: This is the base cookbook repository which has a Policyfile defined.  The Policyfile from this directory is what is applied to Chef Infra Clients.  The base Policy contains dependency configurations for other cookbooks which are used during the build of the Policy and runtime.
- `cookbooks/app_cookbook`:  This is an example application cookbook that is a part of every run of the base policy.  It is included as an `include_policy` from the `Policyfile.rb` of `base_cookbook`, directly importing the `run_list`.
- `cookbooks/newapp_cookbook`:  This is an example application cookbook for a new app which is being tested for deployment.  For test purposes, administrators might want to limit the number of systems running the updated cookbook logic to specific systems within the organization.  Rather than creating a new policy_group for this purpose, this cookbook instead is included as a `cookbook` in the **base Policy** from `base_cookbook`.  This presents the cookbook as available to clients but does not directly include them in the `run_list`.  In this example, `newapp_cookbook` is instead called as an `include_recipe` from `base_cookbook` only in the presence of a tag.  Testing for this is in the `newapp-tag` Test Kitchen suite.
- `cookbooks/newapp2_cookbook`:  This is an example application cookbook for a new app which is being tested for deployment.  It is included as an `include_policy` from the `Policyfile.rb` of `base_cookbook`, directly importing the `run_list`.  For test purposes, administrators might want to limit the number of systems running the updated cookbook logic to specific systems within the organization.  The `newapp2_cookbook` cookbook contains logic in the default recipe to only include other recipes of the cookbook in the presence of a tag.  Testing for this is in the `newapp2-tag` Test Kitchen suite.

## Usage

With Chef Workstation installed, the contents of this repository can be validated with Test Kitchen by running `kitchen test`.  Provided `kitchen.yml` is configured for Vagrant/Virtualbox (can be switched to a different driver).

```plain
kitchen list
Instance                 Driver   Provisioner  Verifier  Transport  Last Action  Last Error
base-ubuntu-2004         Vagrant  ChefInfra    Inspec    Ssh        Verified     <None>
newapp-tag-ubuntu-2004   Vagrant  ChefInfra    Inspec    Ssh        Verified     <None>
newapp2-tag-ubuntu-2004  Vagrant  ChefInfra    Inspec    Ssh        Verified     <None>
```
