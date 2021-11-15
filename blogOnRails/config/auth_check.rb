class AuthCheck

    def initialize(app)

        @app = app
    end

    def call(env)
         
        Rails.logger.debug "middleware has been hit!"
        Rails.logger.debug "hello1"

        
        status, headers, response = @app.call(env)

        [status, headers, response]
    end
end