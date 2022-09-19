class Appointment < ApplicationRecord
	belongs_to :user
	belongs_to :service
	validates :date, presence: true, null: false
	validate :valid_date?

	private
	def valid_date?
		if date != nil
			if date < DateTime.now
				self.errors.add :date, "Please select a valid time"
			end
		end
	end
end
