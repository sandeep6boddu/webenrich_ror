class Author
	include Mongoid::Document
  has_many :quotes
  def name_with_initial
    "#{first_name.first}. #{last_name}"
  end
end