class Category
	include Mongoid::Document
	include Mongoid::Timestamps
	include SimpleEnum::Mongoid
	include Mongoid::Paranoia
	include	Mongoid::Slug
	include Mongoid::Ancestry
	include Mongoid::Orderable
	include Mongoid::SweeperUpdater

	orderable

	has_ancestry
	field	:name,	type: String
	slug :name

	has_and_belongs_to_many :portfolios, :inverse_of => 'categories'
	has_and_belongs_to_many :blogs, :inverse_of => 'categories'
end
