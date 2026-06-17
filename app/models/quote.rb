class Quote
	include Mongoid::Document
	include Mongoid::Timestamps
	include Mongoid::Paranoia
	include SimpleEnum::Mongoid

	field	:full_name, type: String
	field	:email_address, type: String
	field	:phone,	type: String
	field	:company_name,	type: String
	field	:website_url, type: String
	field	:project_details, type: String
	field	:competitors, type: String
	field 	:target_audience, type: String
	field 	:anything_else, type: String
	field 	:interested_in, type: Array, default: []
	field 	:also_interested_in, type: Array, default: []
	field	:step,	type: Boolean, default: false
	as_enum :budget, dollars_0_25k: 1, dollars_25k_50k: 2 , dollars_50k_1lakh: 3, not_sure: 4
	as_enum :start_date, immediately: 1, this_month: 2 , near_future: 3, this_year: 4
	validates :phone,   :presence => {:message => 'Please enter a valid mobile number!'}, :numericality => true, :length => { :minimum => 10, :maximum => 12 }
	validates_presence_of :full_name, :email_address, :phone, :company_name, :project_details, :interested_in, :also_interested_in, :budget, :start_date

end