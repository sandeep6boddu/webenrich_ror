class Testimonial
	include Mongoid::Document
	include	Mongoid::Slug
	include Mongoid::Paranoia
	include Mongoid::Paperclip
	include SimpleEnum::Mongoid
	include Mongoid::Document::Taggable
	include Mongoid::Timestamps
	include Mongoid::SweeperUpdater

	field	:name, type: String
	field	:designation, type: String
	field	:app_name, type: String
	field	:content, type: String
	as_enum :status, [:public, :pending], map: :string
	slug :name
	has_mongoid_attached_file :avatar,
	:styles => {
		thumb: '75x75#',
		original: '106x106#'
	}, :default_url => "/images/testi-default-img.png"
	validates_attachment	:avatar, :presence => true,
							:content_type => { :content_type => /^image\/(png|gif|jpeg)/ }
	validates_presence_of :name, :designation, :content
	belongs_to :user, :class_name => 'User', :inverse_of => 'testimonials'
end