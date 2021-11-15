class PostsRepresenter
    def initialize(posts)
        @posts = posts
    end

    def as_json
        posts.map do |post|
            {
                id: post.id,
                title: post.title,
                body: post.body,
                auther_first_name: post.user.name,
                auther_email: post.user.email
            }

        end
    end
    private
    
    attr_reader :posts
end