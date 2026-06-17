class SessionsController < Devise::SessionsController
	layout 'admin'
	def create
		super
	end

	def new
		super
	end

	def destroy
		signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
	    set_flash_message :notice, :signed_out if signed_out && is_flashing_format?
	    redirect_to admin_path
	end
end