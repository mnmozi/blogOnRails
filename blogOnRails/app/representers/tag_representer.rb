class TagRepresenter


    def initialize (tag)
        @tag = tag
    end

    def as_json 
        {
            id: tag.id,
            content: tag.name,
            post_id: tag.description

        }
    end
    private 

    attr_reader :tag


    
end