class Admin::BlogsController < AuthenticatedController

	layout 'admin'

	def index
		@blogs = Blog.all
	end

	def new
		@blog = Blog.new
	end

	def create
		@blog = Blog.new(blog_params)
		@blog.user = current_user
		if params[:categories].present?
			@blog.category_ids = params[:categories]
		end
		if @blog.save
			redirect_to blogs_path,  :notice => "Your Blog is successfully created"
		else
			render "new"
		end
	end

	def show
		@blog = Blog.find(params[:id])
	end

	def edit
		@blog = Blog.find(params[:id])
	end

	def update
		@blog = Blog.find(params[:id])
		if params[:categories].present?
			@blog.category_ids = params[:categories]
		end
		@blog.update_attributes(blog_params)
		redirect_to blogs_path
	end

	def destroy
		@blog = Blog.find(params[:id])
		@blog.destroy
		redirect_to blogs_path
	end

	def blog_params
		params.require(:blog).permit(:title, :content, :banner, :featured, :meta_title, :meta_description, :meta_keywords)
	end
end