require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "Appointments" do
  let!(:service_provider) {User.create!(email: "c@gmail.com",contact_number:1234567890, password: 123456, password_confirmation: 123456)}
  let!(:user) {User.create!(email: "m@gmail.com",contact_number:1234567891, password: 123456, password_confirmation: 123456)}
  let!(:service){Service.create(name: "x",area: "y",charge: 123,user_id: service_provider.id)}
  let!(:appointment){Appointment.create(service_id: service.id, user_id: user.id, date: DateTime.now + 100)}
  get '/appointments' do
    before do
      auth_headers = service_provider.create_new_auth_token
      header "access-token", auth_headers["access-token"]
      header "client", auth_headers["client"]
      header "uid", auth_headers["uid"]
    end
    context "200" do
      example "List appointments for user" do
        do_request
        expect(response_status).to eq(200)
      end
    end
  end

  post '/appointments' do
    parameter :date, "Date of appointment", required: true
    before do
      auth_headers = user.create_new_auth_token
      header "access-token", auth_headers["access-token"]
      header "client", auth_headers["client"]
      header "uid", auth_headers["uid"]
    end
    # let(:id) {service.id}
    context "200" do
      example "Schedule appointment for user" do
        request = {
          service_id: appointment.service_id,
          user_id: user.id,
          date: appointment.date.strftime('%Y-%m-%d %H:%M:%S')
        }
        do_request(request)
        expect(response_status).to eq(200)
      end
    end

    context "400" do
      example "Unspecified date by user" do
        request = {
        }
        do_request(request)
        expect(response_status).to eq(400)
      end
    end
  end
end