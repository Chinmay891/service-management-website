class AppointmentsController < ApplicationController
    before_action :authenticate_user!

		def index
			user = get_current_user
			appointments = Appointment.where(user_id: user.id)
			render json:{appointments: appointments}
		end

    def create
			user = get_current_user
			appointment = Appointment.new(
				{
					service_id: params[:servce_id],
					user_id: user.id,
					date: appointment_params[:date]
				}
			)

			if appointment.save
				render json: appointment
			else
				render json:{message: "Unable to create appointment"}
			end
    end

		

		private
		def appointment_params
			params.permit(:date)
		end
end
