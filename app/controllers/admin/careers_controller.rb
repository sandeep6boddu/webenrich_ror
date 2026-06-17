class Admin::CareersController < AuthenticatedController
	layout "admin"
	# before_filter	:set_params, only: [:new, :show, :edit, :update, :destroy, :applicant]
	def index
		@jobs = Career.all
	end

	def new
		@job = Career.new
	end

	def create
		@job = Career.new(career_params)
		if @job.save
			flash[:notice] = "Job created successfully."
			redirect_to careers_path
		else
			render :new
		end
	end

	def show
		@job = Career.find(params[:id])
		@applicant = Applicant.new
	end

	def edit
		@job = Career.find(params[:id])
	end

	def update
		@job = Career.find(params[:id])
		if @job.update(career_params)
			flash[:notice] = "Updated Job #{@job.title} Succesfully"
			redirect_to careers_path
		else
			@jobs = @job.errors.full_messages
			render :edit
		end
	end

	def destroy
		@job = Career.find(params[:id])
		@job.destroy
		flash[:notice] = 'Job was successfully destroyed.'
		redirect_to careers_path
	end

	private

	def career_params
		params.require(:career).permit(:code, :title, :experience, :location, :description, :education, :desired_profile, :meta_title, :meta_description, :meta_keywords, :job_status, :tag_list)
	end
end