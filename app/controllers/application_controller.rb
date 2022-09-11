class ApplicationController < ActionController::API
        include DeviseTokenAuth::Concerns::SetUserByToken
				def get_current_user
					if user_signed_in?
            return current_user
          end
				end
end
