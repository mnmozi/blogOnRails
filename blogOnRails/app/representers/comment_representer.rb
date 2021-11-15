class CommentRepresenter


    def initialize (comment)
        @comment = comment
    end

    def as_json 
        {
            id: comment.id,
            content: comment.content,
            post_id: comment.post.id,
            user_name: comment.user.name,
            user_email: comment.user.email,

        }
    end
    private 

    attr_reader :comment


    
end