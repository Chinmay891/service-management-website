class ServiceProvidersController < ApplicationController
  before_action :authenticate_user!
  def index
    user = get_current_user
    service = Service.where(user_id: user.id)
    service.each do |s|
      service_provider_appointments = Appointment.where(service_id: s.id)
      render json: {
        my_appointments: service_provider_appointments
      }
    end
  end
end
