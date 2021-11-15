module Api
    module V1
      class UsersController < ApplicationController 


         before_action :checkAuthentication, only: [:update]
         before_action :checkAuthorization, only: [:destroy, :update]


         def index
            user = User.order('created_at DESC');
            render json:{status: 'SUCCESS', message:'Loaded user', data:user}, status: :ok
         end

         def show 
            user = User.find(params[:id]);
            Rails.logger.debug "user"
            Rails.logger.debug user
            userResult =  UserRepresenter.new(user).as_json .merge("image": url_for(user.image)) 
            render json:{status: 'SUCCESS', message:'Loaded user', data: userResult}, status: :ok
         end

         def create 
            user = User.new(create_user_params)
            Rails.logger.debug user
            if user.save   
               render json:{user: UserRepresenter.new(user).as_json}, status: :created
           else 
               render json: {error: user.errors}, status: :unprocessable_entity
           end
         end

         def update
            updateResult = @user.update(user_params)            
            if updateResult
            render json:{Data: "User updated", post:@user}, status: :accepted
            else 
            render json:{Data: "Error while updating User",err: @user.errors.messages}, status: :not_found
            end
         end
         private

         def user_params
            params.require(:user).permit(:email,:name)
         end

         def create_user_params
            Rails.logger.debug params.require(:user)
            params.require(:user).permit(:email, :password, :password_confirmation, :name, :image)
         end



         def checkAuthentication
            if @user == nil
                raise AuthenticationError
            end
        end

         def checkAuthorization
            if (@user.id).eql?(params[:id])
                 raise AuthorizationError
            end

        end

      end 
    end
end