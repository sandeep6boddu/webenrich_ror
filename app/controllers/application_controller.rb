class ApplicationController < ActionController::Base
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception

	helper :all
		before_filter :prepare_for_mobile, :client_logos


	private
	def mobile_device?
		if session[:mobile_param]
			session[:mobile_param] == "1"
		else
			request.user_agent =~ /Mobile|webOS/
		end
	end
	helper_method :mobile_device?

	def prepare_for_mobile
	session[:mobile_param] = params[:mobile] if params[:mobile]
	request.format = :mobile if mobile_device?
	end

	def client_logos
		@clients = Client.all
		@testimonials = Testimonial.where(status_cd: 'public')
	end
end
