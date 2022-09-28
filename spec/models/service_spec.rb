require 'rails_helper'

RSpec.describe Service, type: :model do
  let!(:user) {User.create!(name: 'c',email:'c@gmail.com',password:123456,password_confirmation: 123456,contact_number: 9876543210)}

  describe 'validations' do
    context 'for a valid service' do
      before do
        @userObj = Service.create!(name:'Plumber',area:'Balewadi',charge:1000,user_id:user.id)
      end
      it 'should validate data with no errors for creating service' do
        @userObj.save
        expect(@userObj.errors.full_messages).to be_empty
      end
    end

    context 'for an invalid service' do
      before do
        @userObj = Service.create(description:'Best service',user_id:user.id)
      end
      it 'should validate data with errors for presence of name' do
        @userObj.save
        expect(@userObj.errors.full_messages).to eq(["Name can't be blank","Area can't be blank", "Charge can't be blank"])
      end
    end
  end
end
