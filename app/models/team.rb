class Team
	include Mongoid::Document
	include Mongoid::Timestamps
	include Mongoid::Paperclip
	include Mongoid::Orderable
	include Mongoid::SweeperUpdater

	orderable

	field :name, type: String
	field :designation, type: String
	has_mongoid_attached_file :team_img,
	:styles => {
		thumb: '75x75#',
		original: '200x200#'
	}, :default_url => "/images/testi-default-img.png"
	validates_attachment :team_img, :presence => true, :content_type => { :content_type => /^image\/(png|gif|jpeg)/ },
	:size => { :in => 0..5.megabytes }
end