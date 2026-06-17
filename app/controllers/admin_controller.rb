class AdminController < AuthenticatedController
	layout "admin"
	def dashboard
	end

	def clear_cache
		Rails.cache.clear
		flash[:success] = 'Cache Cleared Successfully'
		redirect_to admin_path
	end
end