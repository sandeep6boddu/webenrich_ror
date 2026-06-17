class Applicant
	include Mongoid::Document
	include Mongoid::Timestamps
	include Mongoid::Paranoia
	include Mongoid::Paperclip

	field	:name, type: String
	field	:email, type: String
	field	:mobile_no,	type: Integer
	field	:location,	type: String
	field	:experience,	type: Integer
	has_mongoid_attached_file :resume, :default_url => "/images/:style/missing.png"
	validates_attachment_content_type :resume, content_type: ["application/pdf", 'application/msword','applicationvnd.ms-word','applicaiton/vnd.openxmlformats-officedocument.wordprocessingm1.document', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document', 'text/plain'], :message => 'Invalid format uploaded.'
	validates_attachment_size  :resume, :less_than => 5.megabytes, :message => 'Must be less than 5MB.'
	validates_attachment_presence :resume, :presence => true
    validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
	validates :mobile_no,   :presence => {:message => 'Please enter a valid mobile number!'}, :numericality => true, :length => { :minimum => 10, :maximum => 12 }
	validates :experience,   :presence => true, :numericality => { :less_than_or_equal_to => 15 }
	validates_presence_of :name, :location
	belongs_to	:career
end