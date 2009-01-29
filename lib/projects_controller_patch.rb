require_dependency 'projects_controller'
module ProjectsControllerPatch

	def self.included(base)
		base.send(:include,InstanceMethods)
		base.class_eval { alias_method_chain :find_project, :single_user }
	end

	module InstanceMethods

		def find_project_with_single_user
			if User.current.projects.size == 1 && Setting.plugin_redmine_single_user['projects'].include?(User.current.projects.first.id.to_s)
				@project = User.current.projects.first
			elsif	params[:action] == "show" && params[:id].nil?
				redirect_to :controller => :my, :action => :page
			else
				find_project_without_single_user
			end
		end

	end

end

ProjectsController.send(:include, ProjectsControllerPatch)
