class Admin::UsersController < ApplicationController
	layout 'admin'

	def index
		@users = User.all
	end
	def new
		@user = User.new
	end
	def create
		@user = User.invite!(user_params)
		@user.save
		redirect_to users_path
	end

	def show
		@user = User.find(params[:id])
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		@user.update(user_params)
		redirect_to users_path
	end

	def destroy
		@user = User.find(params[:id])
		@user.destroy
		redirect_to users_path
	end

	def user_params
		params.require(:user).permit(:firstname, :lastname, :email)
	end
end
