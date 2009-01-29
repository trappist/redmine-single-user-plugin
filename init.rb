require 'redmine'
require 'application_helper_patch'
require 'application_controller_patch'
require 'welcome_controller_patch'
require 'projects_controller_patch'

Redmine::Plugin.register :redmine_single_user do
  name 'Single User'
  author 'Rocco Stanzione'
  description "Optionally, don't expose the presence of other projects to users with only one project"
  version '0.0.1'
	settings :default => {'projects' => []}, :partial => 'settings/single_user_settings'
end

