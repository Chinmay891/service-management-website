# frozen_string_literal: true

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  extend Devise::Models
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

  has_one :service
  has_one :appointment
  validates :contact_number, presence: true, null: false, uniqueness: true, format: {with: /\A[1-9][0-9]{9}\z/}
end
