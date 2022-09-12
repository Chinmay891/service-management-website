class ServiceProvidersController < ApplicationController
  before_action :authenticate_user!
  def index
    user = get_current_user
    service = Service.where(user_id: user.id)
    service.each do |s|
      service_provider_appointments = Appointment.where(service_id: s.id)
      render json: {
        my_appointments: service_provider_appointments
      }, status: 200
    end
  end

  def update
    user = get_current_user
    appointment = Appointment.find(params[:id])
    if(Service.find(appointment.service_id).user_id != user.id)
      render json: {message: "No appointment found!"}, status: 400
    else
      appointment.update!(service_provider_params)
      render json: appointment, status: 200
    end
  end

  private
  def service_provider_params
    params.permit(:status)
  end
end
