class Service < ApplicationRecord
    belongs_to :user
    has_many :appointments
end