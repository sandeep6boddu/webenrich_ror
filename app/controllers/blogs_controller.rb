class BlogsController < ApplicationController

	def index
		@blogs = Blog.all.page(params[:page]).per(4)
		@featured_blogs = Blog.featured.limit(2)
	end

	def show
		@blog = Blog.find(params[:slug])
		@blog.visits = @blog.visits + 1
		@blog.save
		@popular_blogs = Blog.order(:visits => 'desc').limit(4)
	end

	def search
		@blogs = Blog.full_text_search(params[:text]).page(params[:page]).per(2)
	end

	def category
		@category = Category.find(params[:category])
		@featured_blogs = Blog.featured.limit(2)
		@blogs = @category.blogs.page(params[:page]).per(2)
		render 'index'
	end
end