class Admin::TeamsController < AuthenticatedController
	layout 'admin'

	before_action	:team_id, only: [:edit, :update, :destroy]

	def index
		@team = Team.order(:position => "asc")
	end

	def new
		@team = Team.new
	end

	def create
		@team = Team.new(team_params)
		if @team.save
			flash[:notice] = "Team member added successfully."
			redirect_to teams_path
		else
			render new
		end
	end

	def show

	end

	def edit

	end

	def update
		@team.update(team_params)
			flash[:notice] = "Team member updated successfully."
			redirect_to teams_path
	end

	def destroy
		@team.destroy
		flash[:notice] = "Team member deleted successfully."
		redirect_to teams_path
	end

	def sort
		params[:team].each_with_index do |id, index|
			Team.where(id: id).update_all(position: index+1)
		end
		render nothing: true
	end

	def team_id
		@team = Team.find(params[:id])
	end

	def team_params
		params.require(:team).permit(:team_img, :name, :designation)
	end
end