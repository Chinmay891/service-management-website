require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "Services" do
  let!(:service_provider) {User.create!(email: "c@gmail.com",contact_number:1234567890, password: 123456, password_confirmation: 123456)}
  let!(:service){Service.create(name: "x",area: "y",charge: 123,user_id: service_provider.id)}
  get '/services' do
    context "200" do
      before do
        auth_headers = service_provider.create_new_auth_token
        header "access-token", auth_headers["access-token"]
        header "client", auth_headers["client"]
        header "uid", auth_headers["uid"]
      end
      example "Listing all services" do
        do_request
        expect(response_status).to eq(200)
      end
    end
  end

  post '/services' do
    parameter :name, "Service name", required: true
    parameter :area, "Area of service", required: true
    parameter :description, "Description of the service"
    parameter :charge, "Charges for the service", required: true
    before do
      auth_headers = service_provider.create_new_auth_token
      header "access-token", auth_headers["access-token"]
      header "client", auth_headers["client"]
      header "uid", auth_headers["uid"]
    end
    context "200" do
      example "Create new service" do
        request = {
          name: service.name,
          area: service.area,
          description: service.description,
          charge: service.charge
        }
        do_request(request)
        expect(response_status).to eq(200)
      end
    end

    context "400" do
      example "No data specified for creating service" do
        request = {
          name: "",
          area: "",
          description: service.description,
          charge: ""
        }
        do_request(request)
        expect(response_status).to eq(400)
      end
    end
  end
end