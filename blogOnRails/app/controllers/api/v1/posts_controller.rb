module Api
    module V1
      class PostsController < ApplicationController 
        
        MAX_PAGINATION_LIMIT=5


        before_action :checkAuthentication
        before_action :checkAuthorization, only: [:destroy, :update]

        def index
            posts = Post.limit(limit).offset(params[:offset])
            render json: PostsRepresenter.new(posts).as_json
        end

        def create   
            post = Post.new(post_params)
            post.update(user: @user) 
            
            tags = Tag.where(name: tags_params[:tags])
            Rails.logger.debug tags
            Rails.logger.debug "hereeee"
            post.tags = tags

            if post.save
                HardWorker.perform_in(15.minutes, post.id)
                render json:{Post: PostRepresenter.new(post).as_json}, status: :created
            else 
                
                render json: {error: post.errors}, status: :unprocessable_entity
            end
        end


        def destroy
            if Post.find(params[:id]).destroy!
                render json:{Data: "Post Deleted"}, status: :ok
            else 
                render json:{Data: "Error while deleting"}, status: :not_found
            end
        end


        def update
            removedTags = @post.tags.where(name: update_tags_params[:removedTags])
            addedTags = Tag.where(name: update_tags_params[:addedTags]).ids

            Rails.logger.debug addedTags
            @post.transaction do
                @post.tags.delete(removedTags)
                @post.tags << (addedTags - @post.tags.all.ids)
                if @post.update!(post_params) 
                    render json:{Data: "Post updated", post:  PostRepresenter.new(@post).as_json}, status: :ok
                    else 
                    render json:{Data: "Error while updating",err: @post.errors.messages}, status: :not_found
                end
            end
            

        end


        private 

        def limit 
            [
                params.fetch(:limit,MAX_PAGINATION_LIMIT).to_i,
                MAX_PAGINATION_LIMIT
            ].min
        end

        def update_tags_params
            params.require(:post).permit(:addedTags =>[], :removedTags => [])
        end
        def tags_params
            params.require(:post).permit(:tags => []) 
        end
        def post_params
            params.require(:post).permit(:title, :body) 
        end

        def checkAuthentication
            if @user == nil
                raise AuthenticationError
            end
        end

        def checkAuthorization
            @post = Post.find(params[:id])
            if @post.user != @user
                 raise AuthorizationError
            end

        end

      end 
    end
end