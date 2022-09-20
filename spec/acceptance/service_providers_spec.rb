require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "ServiceProviders" do
  let!(:service_provider) {User.create!(email: "c@gmail.com",contact_number:1234567890, password: 123456, password_confirmation: 123456)}
  let!(:user) {User.create!(email: "m@gmail.com",contact_number:1234567891, password: 123456, password_confirmation: 123456)}
  let!(:appointment){Appointment.create(service_id: service.id, user_id: user.id, date: DateTime.now+ 100)}
  let!(:service){Service.create(name: "x",area: "y",charge: 123,user_id: service_provider.id)}
  get "/service_providers" do
    before do
      auth_headers = service_provider.create_new_auth_token
      # p auth_headers
      header "access-token", auth_headers["access-token"]
      header "client", auth_headers["client"]
      header "uid", auth_headers["uid"]
    end
    context "200" do
      example "List posted services" do
        do_request
        expect(response_status).to eq 200
      end
    end
  end

  patch '/service_providers/:id'do
    context "200" do
      let(:id) {appointment.id}
      before do
        auth_headers = service_provider.create_new_auth_token
        # p auth_headers
        header "access-token", auth_headers["access-token"]
        header "client", auth_headers["client"]
        header "uid", auth_headers["uid"]
      end
      example "Accept appointment" do
        request = {
          status: true
        }
        do_request(request)
        expect(status).to eq(200)
        expect(response_body).to eq("true")
      end
      example "Reject appointment" do
        request = {
          status: false
        }
        do_request(request)
        expect(status).to eq(200)
        expect(response_body).to eq("false")
      end
    end

    context "401" do
      let(:id) {appointment.id}
      before do
        auth_headers = user.create_new_auth_token
        header "access-token", auth_headers["access-token"]
        header "client", auth_headers["client"]
        header "uid", auth_headers["uid"]
      end
      example "Unauthenticated user request" do
        request = {
          status: true
        }
        do_request(request)
        expect(status).to eq(401)
        expect(response_body).to eq('{"message":"User not authenticated!"}')
      end
    end
    context "404" do
      let!(:id) {0}
      before do
        auth_headers = service_provider.create_new_auth_token
        # p auth_headers
        header "access-token", auth_headers["access-token"]
        header "client", auth_headers["client"]
        header "uid", auth_headers["uid"]
      end
      example "Non existing appointment" do
        request = {
          status: true
        }
        do_request(request)
        expect(status).to eq(404)
        expect(response_body).to eq('{"message":"No such appointment!"}')
      end
    end
  end
end