class ContactMailer < ActionMailer::Base
	#default from: 'info@webenrich.com'
	def sendmail(name, email, phone, companyname, url, message, from_page)
		@name = name
		@email = email
		@phone = phone
		@company = companyname
		@url = url
		@message = message
		# @best_time = best_time
		# @preferred_time = preferred_time
		@from_page = from_page
		mail(
  to: 'info@webenrich.com',
  from: 'info@webenrich.com',
  reply_to: @email,
  subject: "Request from #{@name}."
)
	end
	def lp_sendmail(name, email, phone, companyname, message, from_page, budget)
		@name = name
		@email = email
		@phone = phone
		@company = companyname
		@message = message
		@budget = budget
		@from_page = from_page
		mail(
  to: 'info@webenrich.com',
  from: 'info@webenrich.com',
  reply_to: @email,
  subject: "Request from #{@name}."
)
	end
	def job_recipient(job_title, job_slug, applicant_name, applicant_email, applicant_mobile, applicant_location, applicant_experience, filename)
		@job_title = job_title
		@job_url = job_slug
		@applicant_name  = applicant_name
		@from_email = applicant_email
		@mobile = applicant_mobile
		@location = applicant_location
		@experience = @applicant_experience
		attachments[filename] = File.read("#{Rails.root}/public/resumes/"+filename)
		mail(
  to: 'info@webenrich.com',
  from: 'info@webenrich.com',
  reply_to: @from_email,
  subject: "Application for #{@job_title}"
) 
	end

	def request_a_quote(name, email, phone, company, url, interested_in, also_interested_in, budget, start_date, project_details, competitors, target_audience, anything_else)
		@name = name
		@email = email
		@phone = phone
		@company = company
		@url = url
		@interested_in = interested_in
		@also_interested_in = also_interested_in
		@budget = budget
		@start_date = start_date
		@project_details = project_details
		@competitors = competitors
		@target_audience = target_audience
		@anything_else = anything_else
		mail(
  to: 'info@webenrich.com',
  from: 'info@webenrich.com',
  reply_to: @email,
  subject: "Request a quote from #{name}"
)
	end
end
