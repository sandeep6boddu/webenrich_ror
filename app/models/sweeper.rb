class Sweeper
	include Mongoid::Document

	field :model_name, type: String
	field :update_id,  type: BSON::ObjectId

	def self.update_id model
		class_name = model.class.name
		inst = Sweeper.where(model_name: class_name).first_or_create!
		ActionController::Base.new.expire_fragment %r{#{model}}
		ActionController::Base.new.expire_fragment %r{#{inst.update_id}}
		inst.update_id = BSON::ObjectId.new
		inst.save
	end

	def self.get_update_id model
		class_name = model.name
		inst = Sweeper.where(model_name: class_name).first
		inst.present? ? inst.update_id : nil
	end
end