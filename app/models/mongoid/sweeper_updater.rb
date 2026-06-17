module Mongoid
	module SweeperUpdater

		def self.include base
			base.extend ClassMethods
		end

		extend ActiveSupport::Concern
		included do
			after_create :update_sweeper_id
			after_update :update_sweeper_id
			after_destroy :update_sweeper_id
		end

		def update_sweeper_id
			Sweeper.update_id(self)
		end

		module ClassMethods
			def get_sweep_id
				@sweep_id ||= Sweeper.get_update_id(self)
			end
		end
	end
end