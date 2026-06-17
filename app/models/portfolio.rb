class Portfolio
	include Mongoid::Document
	include	Mongoid::Timestamps
	include SimpleEnum::Mongoid
	include Mongoid::Paranoia
	include Mongoid::Document::Taggable
	include Mongoid::Slug
	include Mongoid::Paperclip
	include Mongoid::Orderable
	include Mongoid::SweeperUpdater

	orderable

	field	:title, type: String
	field	:description, type: String
	field	:team_size, type: Integer
	field	:duration, type: Integer
	field	:conclusion, type: String
	field	:link, type: String
	field	:meta_title, type: String
	field	:meta_description, type: String
	field	:meta_keywords, type: String
	as_enum	:calender, [:months, :years], map: :string
	field	:technologies, type: Array, default: []
	as_enum :status, [:public, :pending], map: :string
	slug 	:title
	has_mongoid_attached_file	:thumb,
	:styles => {
		original: '335x194>'
	}, :default_url => "/images/missing.png"

	validates_attachment	:thumb,	:content_type => { :content_type => /^image\/(png|gif|jpeg)/ }
	validates_presence_of	:thumb, :title, :description, :team_size, :technologies, :duration, :meta_title, :meta_description, :meta_keywords, :status
	validates_presence_of	:calender, :if => :duration?
	 validates_numericality_of :duration, :greater_than => 0

	belongs_to :user, :class_name => 'User', :inverse_of => 'portfolios'
	has_and_belongs_to_many :categories, :inverse_of => 'portfolios'
	has_many :slides

	def previous_item id
		self.where(:id.lt => id).sort({:_id=>-1}).limit(1).first
	end

	def next_item id
		self.where(:id.gt => id).sort({:_id=>1}).limit(1).first
	end
end