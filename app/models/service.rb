class Service < ApplicationRecord
    belongs_to :user
    has_many :appointments
    validates :name, :area, :charge, presence: true, null: false
     
end
