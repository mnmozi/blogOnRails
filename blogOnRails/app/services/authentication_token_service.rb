class AuthenticationTokenService
    def self.call(user_id)
        payload = {user_id: user_id}
        JWT.encode payload, ENV['JWTSECRET'], ENV['JWTALGO']
    end

    def self.decode(token)
      decoded_token = JWT.decode token, ENV['JWTSECRET'], true, {algorithm: ENV['JWTALGO']}
        decoded_token[0]['user_id']
    end
end