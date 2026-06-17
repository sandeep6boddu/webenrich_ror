class Career
	include Mongoid::Document
	include Mongoid::Timestamps
	include SimpleEnum::Mongoid
	include Mongoid::Paranoia
	include Mongoid::Document::Taggable
	include	Mongoid::Slug
	include Mongoid::SweeperUpdater

	field	:code,	type: String
	field	:title,	type: String
	field	:experience,	type: String
	field	:location,	type: String
	field	:description,	type: String
	field	:education,	type: String
	field	:desired_profile,	type: String
	field	:meta_title, 	type: String
	field	:meta_description, 	type: String
	field	:meta_keywords, 	type: String
	as_enum :job_status, [:public, :pending], map: :string
	slug 	:title

	validates :experience, :numericality => true, :length => { :minimum => 0, :maximum => 10 }
	validates_presence_of :code, :title, :location, :description, :education, :desired_profile, :meta_title, :meta_description, :meta_keywords, :job_status, :tag_list
	has_many :applicants
	belongs_to :user, :class_name => 'User', :inverse_of => 'careers'
 end
