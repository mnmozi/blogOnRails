class ApplicationController < ActionController::API
    include ActionController::HttpAuthentication::Token
    rescue_from ActiveRecord::RecordNotDestroyed, with: :not_destroyed
    rescue_from ActiveRecord::RecordNotFound, with: :not_found
    rescue_from ActionController::ParameterMissing, with: :parameter_missing
    rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
    
    class AuthenticationError < StandardError ; end
    rescue_from AuthenticationError, with: :handle_unauthenticated

    class AuthorizationError < StandardError ; end
    rescue_from AuthorizationError, with: :handle_unauthorized

    
    
    before_action :authenticate_user
    private 

    def not_destroyed(err)
        render json: { errors: err.record.errors }, status: :unprocessable_entity
    end

    def not_found(err)
        render json: { errors: err }, status: :not_found
    end
 

    def handle_unauthenticated
        head :unauthorized
    end
    def parameter_missing(err)
        render json: { message: "please provide the right parameter", error: err }, status: :forbidden
    end


    def handle_unauthorized
        render json: { errors: "You don't have the permisions do that aciton" }, status: :forbidden
    end

    def record_invalid(err)
        render json: { message: "Validation failed",error: err }, status: :forbidden
    end
    
    def authenticate_user
        token, _options = token_and_options(request)

        if token
            user_id = AuthenticationTokenService.decode(token)
            @user = User.find(user_id)
        else 
            @user = nil
        end
    end

end
