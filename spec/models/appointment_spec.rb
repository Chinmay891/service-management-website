require 'rails_helper'

RSpec.describe Appointment, type: :model do
  let!(:user) {User.create(name: 'c',email:'c@gmail.com',password:123456,password_confirmation: 123456,contact_number: 9876543210)}
  let!(:service){Service.create(name: "x",area: "y",charge: 123,user_id: user.id)}

  describe 'validations' do
    context 'for a valid appointment' do
      before do
        @userObj = Appointment.create(service_id: service.id,user_id: user.id,date: DateTime.now+100)
      end
      it 'should validate data with no errors for booking appointment' do
        @userObj.save
        expect(@userObj.errors.full_messages).to be_empty
      end
    end

    context 'for an invalid service' do
      before do
        @userObj = Appointment.create(service_id: service.id,user_id: user.id,date: nil)
      end
      it 'should validate data with errors for presence of date' do
        @userObj.save
        expect(@userObj.errors.full_messages).to eq(["Date can't be blank"])
      end
    end
  end
end
