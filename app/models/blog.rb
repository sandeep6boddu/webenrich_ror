class Blog
	include Mongoid::Document
	include Mongoid::Timestamps
	include Mongoid::Paranoia
	include Mongoid::Paperclip
	include Mongoid::Search
	include	Mongoid::Slug

	field :title, type: String
	field :content, type: String
	field :visits, type: Integer, default: 0
	field :featured, type: String
	field :meta_title, type: String
	field :meta_description, type: String
	field :meta_keywords, type: String
	slug :title
	has_mongoid_attached_file :banner,
	 :styles => {
      :original => ['1180x500#', :jpg],
      :thumb    => ['70x48#',   :jpg],
      :small	=> ['330x209#', :jpg],
      :medium   => ['370x238#',    :jpg],
      :large    => ['381x490#',   :jpg],
    },
	:convert_options => { :all => '-background white -flatten +matte' }
    validates_attachment_content_type :banner, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

	belongs_to :user, class_name: 'User', inverse_of: 'blog'
	has_and_belongs_to_many :categories, :inverse_of => 'blogs'

	search_in :title, :content
	scope :featured, -> { where(featured: 'yes') }
	validates_presence_of :title, :content, :featured, :meta_keywords, :meta_description, :meta_title
end