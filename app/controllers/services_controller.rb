class ServicesController < ApplicationController
	before_action :authenticate_user! 

	def index
		user = get_current_user
		@services = Service.where('user_id != ?', user.id)
		render json: @services, status: 200
	end
	
	def create
		user = get_current_user
		service = Service.new(
			{
				user_id: user.id,
				name: service_parameters[:name],
				area: service_parameters[:area],
				description: service_parameters[:description],
				charge: service_parameters[:charge]
			}
		)

		if service.save
			render json: service, status: 200
		else
			render json:{message: "Unable to create service"}, status: 400
		end
	end

	private
	def service_parameters
		params.permit(:name,:area,:description,:charge)
	end

end
