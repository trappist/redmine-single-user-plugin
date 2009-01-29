require_dependency 'welcome_controller'
module WelcomeControllerPatch

	def self.included(base)
		base.send(:include, InstanceMethods)
		base.class_eval { alias_method_chain :index, :single_user }
	end

	module InstanceMethods

		def index_with_single_user
			@news = News.latest(User.current)
			if User.current.projects.size == 1 && Setting.plugin_redmine_single_user['projects'].include?(User.current.projects.first.id.to_s)
				@projects = []
			else
				@projects = Project.latest(User.current)
			end
		end
	
	end

end

WelcomeController.send(:include, WelcomeControllerPatch)
