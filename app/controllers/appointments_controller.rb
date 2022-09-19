class AppointmentsController < ApplicationController
	before_action :authenticate_user!

	def index
		user = get_current_user
		appointments = Appointment.where(user_id: user.id)
		if appointments.empty?
			render json: {message: "No appointments scheduled!"}
		else
			render json:{appointments: appointments},status: 200
		end
	end

	def create
		user = get_current_user
		appointment = Appointment.new(
			{
				service_id: appointment_params[:service_id],
				user_id: user.id,
				date: appointment_params[:date]
			}
		)

		if appointment.save
			render json:{
				service_id: appointment.service_id,
				user_id: user.id,
				date: appointment.date.strftime('%Y-%m-%d %H:%M:%S')
			},status: 200
		else
			render json:{message: "Unable to create appointment"},status: 400
		end
  end

	private
	def appointment_params
		params.permit(:date,:service_id)
	end
end
