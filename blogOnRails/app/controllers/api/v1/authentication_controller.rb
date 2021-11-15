module Api
    module V1
      class AuthenticationController < ApplicationController
        
        class AuthenticationError < StandardError ; end
        rescue_from ActionController::ParameterMissing, with: :parameter_missing
        rescue_from AuthenticationError, with: :handle_unauthenticated
        
        def create
          if user == nil 
            render json:{message: "Email can't be found"}, status: :unprocessable_entity
          else
            raise AuthenticationError unless @user.authenticate(params.require(:password))
            token = AuthenticationTokenService.call(@user.id)
            render json:{token: "Bearer "+token}, status: :created
          end
        end

        private 
        def user
            @user ||= User.find_by(email: params.require(:email))
        end

        def parameter_missing(e)
          render json: {error: e.message }, status: :unprocessable_entity
        end

        def handle_unauthenticated
            head :unauthorized
        end
      end
    end
end