class PasswordsController < Devise::PasswordsController
	layout 'admin'
	def new
		super
	end
end