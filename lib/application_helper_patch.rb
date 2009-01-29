require_dependency 'application_helper'
module ApplicationHelperPatch

	def self.included(base)
		base.send(:include, InstanceMethods)
		base.class_eval { alias_method_chain :render_project_jump_box, :single_user }
	end

	module InstanceMethods

		def render_project_jump_box_with_single_user
			if User.current.projects.size == 1 && Setting.plugin_redmine_single_user['projects'].include?(User.current.projects.first.id.to_s)
				""
			else
				render_project_jump_box_without_single_user
			end
		end
	
	end

end

ApplicationHelper.send(:include, ApplicationHelperPatch)
