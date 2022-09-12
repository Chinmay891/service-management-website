class Appointment < ApplicationRecord
    belongs_to :user
    belongs_to :service
    validates :date, presence: true, null: false
end
