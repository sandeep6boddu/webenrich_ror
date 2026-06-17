class HomeController < ApplicationController
	def index
		@clients = Client.order_by(position: 'acs')
		@testimonials = Testimonial.where(status_cd: 'public')
	end

	def about_us
		@testimonials = Testimonial.where(status_cd: 'public')
	end
	def about_us_process
		@testimonials = Testimonial.where(status_cd: 'public')
	end
	def about_our_team

	end

	def clients
		@clients = Client.order_by(position: 'acs')
		@contact = Contact.new
		@testimonials = Testimonial.where(status_cd: 'public')
	end

	def clients_partial
		render 'layouts/widgets/_our_clients', layout: false
	end

	def quick_contact_form
		@contact = Contact.new(contact_params)
		recaptcha_valid = Net::HTTP.get(URI("https://www.google.com/recaptcha/api/siteverify?secret=#{ENV['RECAPTCHA_SECRET_KEY']}&response=#{params['g-recaptcha-response']}"))
if JSON.parse(recaptcha_valid)["success"] && @contact.save
			@name = @contact.full_name
			@email = @contact.email_address
			@phone = @contact.phone
			@company = @contact.company_name
			@url = @contact.website_url
			@message = @contact.message
			@from_page = (params[:from_page].include?("clients") ? 'Clients' : (params[:from_page].include?('testimonials') ? "Testimonials" : (params[:from_page].include?('partner-with-us') ? "Partner With Us" : "Contact")))
			ContactMailer.sendmail(@name, @email, @phone, @company, @url, @message, @from_page).deliver_now
			flash[:alert] = "Details submited successfully"
			redirect_to root_path
		else
			@contact.errors["g-recaptcha-response"] << "The reCAPTCHA wasn't entered correctly. Please try it again."
			@from_page = (params[:from_page].include?("clients") ? 'Clients' : (params[:from_page].include?('testimonials') ? "Testimonials" : (params[:from_page].include?('partner-with-us') ? "Partner With Us" : "Contact")))
			render :action => "#{@from_page.downcase}"
		end
	end

	def careers
		@jobs = Career.where(job_status_cd: 'public')
		@clients = Client.order_by(position: 'acs')
	end

	def careers_details
		@career = Career.find(params[:title])
		if @career.job_status_cd == 'public'
			@job = Career.find(params[:title])
		else
			redirect_to career_home_path
		end
		@applicant = Applicant.new
		@clients = Client.order_by(position: 'acs')
	end

	def testimonials
		@testimonials = Testimonial.where(status_cd: 'public')
		@contact = Contact.new
		@clients = Client.order_by(position: 'acs')
	end

	def portfolio
		@portfolios = Portfolio.where(:status_cd => 'public').all
		@portfolios = Portfolio.order(:position => "asc")
		@clients = Client.order_by(position: 'acs')
	end

	def portfolio_single
		@portfolio = Portfolio.find(params[:title])
		@clients = Client.order_by(position: 'asc')
	end

	def portfolio_details
		@cat = params[:category]
		if params[:category] != 'mix'
			@portfolios = Category.where(:_slugs => params[:category]).first.portfolios.pluck(:id)
		else
			@portfolios = Portfolio.all.pluck(:id)
		end
		@portfolio = Portfolio.find(params[:title])
		begin
			@next_portfolio = Portfolio.find(@portfolios[Hash[@portfolios.map.with_index.to_a][@portfolio.id]+1])
		rescue
		end
		begin
			@previous_portfolio = Portfolio.find(@portfolios[Hash[@portfolios.map.with_index.to_a][@portfolio.id]-1])
		rescue
		end
		@clients = Client.order_by(position: 'asc')
	end

	def about_our_team
		# @team = Team.where(:status_cd => 'public').all
		@team = Team.order_by(position: 'asc').all
		# @contact = Contact.new
		# @testimonials = Testimonial.where(status_cd: 'public')
	end

	def request_quote
		@quote = Quote.new
		@clients = Client.order_by(position: 'acs')
		@testimonials = Testimonial.where(status_cd: 'public')
	end

	def quote
		@clients = Client.order_by(position: 'acs')
		@quote = Quote.new(quote_params)
		@quote.interested_in = @quote.interested_in.reject { |item| item.empty? }
		@quote.also_interested_in = @quote.also_interested_in.reject { |item| item.empty? }
		recaptcha_valid = Net::HTTP.get(URI("https://www.google.com/recaptcha/api/siteverify?secret=#{ENV['RECAPTCHA_SECRET_KEY']}&response=#{params['g-recaptcha-response']}"))
if JSON.parse(recaptcha_valid)["success"] && @quote.save
			@name = @quote.full_name
			@email = @quote.email_address
			@phone = @quote.phone
			@company = @quote.company_name
			@url = @quote.website_url
			@interested_in = @quote.interested_in.join(',')
			@also_interested_in = @quote.also_interested_in.join(',')
			if !@quote.budget.present?
				@budget = ""
			elsif @quote.budget == :dollars_0_25k
				@budget = "$5 - $10k"
			elsif @quote.budget == :dollars_25k_50k
				@budget = "$10k - $25k"
			elsif @quote.budget == :dollars_50k_1lakh
				@budget = "$25k - $50k"
			else
				@budget = "$50k and more"
			end
			# @start_date = @quote.start_date
			if !@quote.start_date.present?
				@start_date = ""
			elsif @quote.start_date ==  :immediately
				@start_date = "Immediately"
			elsif @quote.start_date == :this_month
				@start_date = "This Month"
			elsif @quote.start_date == :near_future
				@start_date = "Near Feature"
			else @quote.start_date == :this_year
				@start_date = "This Year"
			end
			@project_details = @quote.project_details
			@competitors = @quote.competitors
			@target_audience = @quote.target_audience
			@anything_else = @quote.anything_else
			ContactMailer.request_a_quote(@name, @email, @phone, @company, @url, @interested_in, @also_interested_in, @budget, @start_date, @project_details, @competitors, @target_audience, @anything_else).deliver_now
			# flash[:alert] = "Details submited successfully"
			redirect_to thankyou_path
		else
			@quote.errors["g-recaptcha-response"] << "The reCAPTCHA wasn't entered correctly. Please try it again."
			render :request_quote
		end
	end

	def partner_with_us
		@contact = Contact.new
	end

	def privacy_policy
		@clients = Client.order_by(position: 'acs')
	end

	def google_partner
		@clients = Client.order_by(position: 'acs')
	end

	def thankyou
		@clients = Client.order_by(position: 'acs')
	end

	def contact
		@testimonials = Testimonial.where(status_cd: 'public')
		@contact = Contact.new
	end

	def contact_details
		@clients = Client.order_by(position: 'acs')
		@contact = Contact.new(contact_params)
		recaptcha_valid = Net::HTTP.get(URI("https://www.google.com/recaptcha/api/siteverify?secret=#{ENV['RECAPTCHA_SECRET_KEY']}&response=#{params['g-recaptcha-response']}"))
if JSON.parse(recaptcha_valid)["success"] && @contact.save
			@name = @contact.full_name
			@email = @contact.email_address
			@phone = @contact.phone
			@company = @contact.company_name
			@url = @contact.website_url
			@message = @contact.message
			# @best_time = @contact.best_time
			# @preferred_time = @contact.preferred_time
			@from_page = (params[:from_page].nil? ? 'Contact' : (params[:from_page].include?("clients") ? 'Clients' : (params[:from_page].include?('testimonials') ? "Testimonials" : (params[:from_page].include?('partner-with-us') ? "Partner With Us" : "Contact"))))
			ContactMailer.sendmail(@name, @email, @phone, @company, @url, @message, @from_page).deliver_now
			# flash[:alert] = "Details submited successfully"
			redirect_to thankyou_path
		else
			@contact.errors["g-recaptcha-response"] << "The reCAPTCHA wasn't entered correctly. Please try it again."
			render :contact
		end
	end

	def lp_contact_details
		@clients = Client.order_by(position: 'acs')
		@contact = LpContact.new(lp_contact_params)
		recaptcha_valid = Net::HTTP.get(URI("https://www.google.com/recaptcha/api/siteverify?secret=#{ENV['RECAPTCHA_SECRET_KEY']}&response=#{params['g-recaptcha-response']}"))
if JSON.parse(recaptcha_valid)["success"] && @contact.valid?
			@name = @contact.full_name
			@email = @contact.email_address
			@phone = @contact.phone
			@company = @contact.company_name
			@message = @contact.message
			@budget = @contact.budget
			if params[:from_page] == 'ror'
				@from_page = 'LP ROR'
			elsif params[:from_page] == 'ecommerce'
				@from_page = 'LP Ecommerce'
			else
				@from_page = 'LP Mobile-Apps'
			end
			begin
			ContactMailer.lp_sendmail(@name, @email, @phone, @company, @message, @from_page, @budget).deliver_now
			rescue Exception => e
			end
			redirect_to lp_thankyou_path
		else
			@contact.errors["g-recaptcha-response"] << "The reCAPTCHA wasn't entered correctly. Please try it again."
			redirect_to '/lp/ror#contact-form', :flash => { :error => @contact.errors }
		end
	end

	def applicant
		@clients = Client.order_by(position: 'acs')
		@job = Career.find(params[:job_id])
		@applicant = Applicant.new(applicant_params)
		@applicant.career_id = params[:job_id]
		if @applicant.save
			@status = false
			@filename = @applicant.resume.original_filename.split('.')
			@filename = @filename[0].to_s + "-" + DateTime.now.to_s + "." + @filename[1].to_s
			directory = "#{Rails.root}/public/resumes"
			path = File.join(directory, @filename)
			File.open(path, "wb") { |f| f.write(params[:applicant][:resume].read) }
			@job_title = @applicant.career.title
			@job_slug = @applicant.career.slug
			@applicant_name = @applicant.name
			@applicant_email = @applicant.email
			@applicant_mobile = @applicant.mobile_no
			@applicant_location = @applicant.location
			@applicant_experience = @applicant.experience
			ContactMailer.job_recipient(@job_title, @job_slug, @applicant_name, @applicant_email, @applicant_mobile, @applicant_location, @applicant_experience, @filename).deliver
			flash[:alert] = "Job Applied successfully"
			redirect_to careers_details_path(@job)
		else
			@status = true
			@applicant_errors = @applicant.errors.full_messages
			render :careers_details
		end

	end

	private

	def applicant_params
		params.require(:applicant).permit(:name, :email, :mobile_no, :location, :experience, :resume)
	end

	def contact_params
		params.require(:contact).permit(:full_name, :email_address, :phone, :company_name,:website_url, :message)
	end

	def lp_contact_params
		params.require(:lp_contact).permit(:full_name, :email_address, :phone, :company_name,:website_url, :message, :budget)
	end

	def quote_params
		params.require(:quote).permit(:full_name, :email_address, :phone, :company_name, :website_url, :project_details, :competitors, :target_audience, :anything_else, :budget, :start_date, interested_in: [], also_interested_in: [])
	end

end
