module Api
    module V1
      class TagsController < ApplicationController
        before_action :checkAuthentication

        def create   
            tag = Tag.new(tag_params)
            if tag.save
                
                render json:{tag: TagRepresenter.new(tag).as_json}, status: :created
            else 
                render json: {error: tag.errors}, status: :unprocessable_entity
            end
        end

        private 

        def tag_params
            params.require(:tag).permit(:name, :description) 
        end

        def checkAuthentication
            if @user == nil
                raise AuthenticationError
            end
        end


      end 
    end
end
