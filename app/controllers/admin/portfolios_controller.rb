class Admin::PortfoliosController < AuthenticatedController
	layout 'admin'
	before_action	:portfolio_id, only: [:edit, :update, :destroy]

	def index
		@portfolios = Portfolio.order(:position => "asc")
	end

	def new
		@portfolio = Portfolio.new
	end

	def create
		@portfolio = Portfolio.new(portfolio_params)
		@portfolio.user = current_user
		slides_validation = (params["portfolio"]["slides"].present?) && (params["portfolio"]["slides"].count == 3)
		if slides_validation
			params["portfolio"]["slides"].each do |slide|
				@portfolio.slides << Slide.new(:slide => slide)
			end
		end
		if params[:categories].present?
			@portfolio.category_ids = params[:categories]
		end
		if params[:technologies].present?
			@portfolio.technologies = params[:technologies]
		end
		if  slides_validation && @portfolio.save
			if @portfolio.slides.present?
				@portfolio.slides.each do |slide| 
					slide.save
				end
			end
			flash[:notice] = "Portfolio created successfully."
			redirect_to portfolios_path
		else
			@portfolio.errors[:slides] << "please upload only 3 images." 
			render :new
		end
	end

	def show

	end

	def edit
	end

	def update
		if params[:categories].present?
			@portfolio.category_ids = params[:categories]
		end
		if params[:technologies].present?
			@portfolio.technologies = params[:technologies]
		end
		if @portfolio.update_attributes(portfolio_params)
			flash[:notice] = "Portfolio updated successfully."
			redirect_to portfolios_path
		else
			@portfolio.errors[:slides] << "please upload only 3 images."
			render :edit
		end
	end

	def destroy
		@portfolio.destroy
		flash[:notice] = "Portfolio Destroyed successfully."
		redirect_to portfolios_path
	end

	def sort
		params[:portfolio].each_with_index do |id, index|
			Portfolio.where(id: id).update_all(position: index+1)
		end
		render nothing: true
	end

	private

	def portfolio_id
		@portfolio = Portfolio.find(params[:id])
	end

	def portfolio_params
		params.require(:portfolio).permit(:thumb, :title, :description, :team_size, :duration, :conclusion, :link, :meta_title, :meta_description, :meta_keywords, :calender, :status, technologies: [])
	end
end