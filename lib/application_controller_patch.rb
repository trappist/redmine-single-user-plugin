require_dependency 'application'
module ApplicationControllerPatch

	def self.included(base)
		base.send(:include,InstanceMethods)
		base.class_eval { alias_method_chain :require_login, :single_user }
	end

	module InstanceMethods

		def require_login_with_single_user
			if require_login_without_single_user
				if User.current.projects.size == 1 && Setting.plugin_redmine_single_user['projects'].include?(User.current.projects.first.id.to_s)
					@project = User.current.projects.first
					Redmine::MenuManager.map :top_menu do |menu|
						menu.delete :projects
						menu.delete :my_page
					end
				end
				return true
			else
				return false
			end
		end

	end

end

ApplicationController.send(:include, ApplicationControllerPatch)
