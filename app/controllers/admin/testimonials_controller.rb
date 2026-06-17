class Admin::TestimonialsController < AuthenticatedController
	layout 'admin'
	before_action :testimonial_id, only: [:edit, :update, :destroy]
	def index
		@testimonials = Testimonial.all
	end

	def new
		@testimonial = Testimonial.new
	end

	def create
		@testimonial = Testimonial.new(testimonial_params)
		if @testimonial.save
			flash[:notice] = "Testimonial created successfully."
			redirect_to testimonials_path
		else
			render :new
		end
	end

	def edit

	end

	def update
		if @testimonial.update_attributes(testimonial_params)
			flash[:notice] = "Testimonial updated successfully."
			redirect_to testimonials_path
		else
			render :edit
		end
	end

	def destroy
		@testimonial.destroy
		flash[:notice] = "Testimonial destroyed successfully."
		redirect_to testimonials_path
	end

	private

	def testimonial_id
		@testimonial = Testimonial.find(params[:id])
	end

	def testimonial_params
		params.require(:testimonial).permit(:name, :designation, :content, :avatar, :status, :app_name)
	end

end