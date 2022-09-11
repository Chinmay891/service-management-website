class ServicesController < ApplicationController
    before_action :authenticate_user! 

    def index
        @services = Service.all
        render json: @services
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
            render json: service
        else
            render json:{message: "Unable to create service"}
        end
    end

    private
    def service_parameters
        params.permit(:name,:area,:description,:charge)
    end

end
