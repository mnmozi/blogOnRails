class PostRepresenter


    def initialize (post)
        @post = post
    end

    def as_json 
        {
            id: post.id,
            title: post.title,
            body: post.body,
            tags: post.tags,
            auther_name: post.user.name,
            auther_email: post.user.email
        }
    end
    private 

    attr_reader :post


    
end