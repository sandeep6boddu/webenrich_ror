class Admin::CategoriesController < AuthenticatedController
	layout 'admin'
	before_action :category_id, only: [:edit, :show, :update, :destroy]
	def index
		@categories = Category.order(:position => "asc")
	end

	def new
		@category = Category.new
	end

	def create
		@category = Category.new(category_params)
		if @category.save
			flash[:notice] = "Category created successfully."
			redirect_to categories_path
		else
			render :new
		end
	end

	def show

	end

	def sub
		@category = Category.find(params[:category])
		@sub_category = @category.children.create(name: params[:name])
		if @sub_category.save!
			redirect_to category_path(@category)
		else
			render :show
		end
	end

	def edit

	end

	def update
		if @category.update_attributes(category_params)
			flash[:notice] = "Category updated successfully."
			redirect_to categories_path
		else
			render :edit
		end
	end

	def destroy
		if @category.destroy
			flash[:notice] = "Category deleted successfully."
			redirect_to categories_path
		end
	end

	def sort
		params[:category].each_with_index do |id, index|
			Category.where(id: id).update_all(position: index+1)
		end
		render nothing: true
	end


	private
	def category_id
		@category = Category.find(params[:id])
	end

	def category_params
		params.require(:category).permit(:name)
	end
end