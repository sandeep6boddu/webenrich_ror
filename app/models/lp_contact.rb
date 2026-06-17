class LpContact
	include Mongoid::Document
	include Mongoid::Timestamps
	include Mongoid::Paranoia

	field	:full_name, type: String
	field	:email_address, type: String
	field	:phone,	type: String
	field	:company_name,	type: String
	field	:message, type: String
	field	:budget, type: String
	validates :phone,   :presence => {:message => 'Please enter a valid mobile number!'}, :numericality => true, :length => { :minimum => 10, :maximum => 12 }
	validates_presence_of :full_name, :email_address, :phone, :message, :budget
end