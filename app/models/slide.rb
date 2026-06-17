class Slide
	include Mongoid::Document
	include	Mongoid::Timestamps
	include Mongoid::Paperclip
	include Mongoid::SweeperUpdater

	has_mongoid_attached_file	:slide,
	:styles => {
		original: '800x400#'
	}, :default_url => "/images/missing.png"
	validates_attachment	:slide, :presence => true,
							:content_type => { :content_type => /^image\/(png|gif|jpeg)/ }

	belongs_to	:portfolio
end