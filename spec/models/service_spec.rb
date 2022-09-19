require 'rails_helper'

RSpec.describe Service, type: :model do
  let(:service) {create(:service,description: "Best service")}

  describe 'validations' do
    context 'when name area and charge contains data' do
      before do
        @userObj = Service.create!(:user,name:'Plumber',area:'Balewadi',charge:1000)
      end
      it 'should validate data with no errors' do
        @userObj.save
        expect(@userObj.errors.full_messages).to be_empty
      end
    end

    context 'when name area and charge does not contains data' do
      before do
        @userObj = Service.create!(:user,name:'',area:'',charge:)
      end
      it 'should validate data with errors' do
        @userObj.save
        expect(@userObj.errors.full_messages).to eq(["Name can't be blank"])
      end
    end

  end
end
