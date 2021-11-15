module Api
    module V1
        module Posts
            class CommentsController < ApplicationController 

                before_action :set_post
                before_action :checkAuthentication
                before_action :checkAuthorization, only: [:destroy, :update]
                MAX_PAGINATION_LIMIT=100

                def create
                    comment = @post.comments.new(create_params.merge(user: @user))
                    # comment.update(user: @user) 

                    if comment.save  
                        render json:{comment: CommentRepresenter.new(comment).as_json}, status: :created
                    else 
                        
                        render json: {error: comment.errors}, status: :unprocessable_entity
                    end
                end

                def index
                    # fix the method to get the comment using post @post
                    comments = @post.comments.limit(limit).offset(params[:offset])
                    render json: CommentsRepresenter.new(comments).as_json
                end

                def update
                    if @comment
                        updateResult = @comment.update(create_params)
                        if updateResult
                            render json:{Data: "comment updated", post: @comment}, status: :ok
                            else 
                            render json:{Data: "Error while updating",err: @comment.errors.messages}, status: :not_found
                        end
                    else
                        render json:{Data: "Error while updating",err: @comment.errors.messages}, status: :not_found
                    end
                end

                private
                
                def set_post
                    @post = Post.find(params[:post_id])
                end

                def create_params
                    params.require(:comment).permit(:content)
                end


                def limit 
                    [
                        params.fetch(:limit,MAX_PAGINATION_LIMIT).to_i,
                        MAX_PAGINATION_LIMIT
                    ].min
                end

                def checkAuthentication
                    if @user == nil
                        raise AuthenticationError
                    end
                end

                def checkAuthorization
                    @comment = @user.comments.find(params[:id])
                    # if @comment.user != @user
                    #     raise AuthorizationError
                    # end

                end
            end
        end
    end
end      