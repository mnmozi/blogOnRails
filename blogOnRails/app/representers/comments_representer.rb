class CommentsRepresenter
    def initialize(comments)
        @comments = comments
    end

    def as_json
        comments.map do |comment|
            {
                id: comment.id,
                content: comment.content,
                user_name: comment.user.name,
                post: comment.post.id
            }

        end
    end
    private
    
    attr_reader :comments
end