class Admin::ClientsController < AuthenticatedController
	layout 'admin'
	def index
		@clients = Client.order(:position => "asc")
	end

	def new
		@client = Client.new
	end

	def create
		@uploads = Client.create(client_params)
	end

	def edit
		@client = Client.find(params[:id])
	end

	def update
		@client = Client.find(params[:id])
		if @client.update_attributes(client_params)
			flash.now[:notice] = "Client image updated successfully."
			redirect_to clients_path
		else
			render :edit
		end
	end

	def destroy
		@client = Client.find(params[:id])
		@client.destroy
			flash[:notice] = "Client image deleted successfully."
		redirect_to clients_path
	end

	def sort
		params[:client].each_with_index do |id, index|
			Client.where(id: id).update_all(position: index+1)
		end
		render nothing: true
	end
	private 

	def client_params
		params.require(:client).permit(:logo)
	end
end