require 'rails_helper'

describe AuthenticationTokenService do
    describe '.call' do
        it 'returns an authentication token' do

            token = described_class.call(1)
            decoded_token = JWT.decode token, ENV['JWTSECRET'], true, {algorithm: ENV['JWTALGO']}
            expect(decoded_token).to eq([
                {"user_id"=>1},
                {"alg"=>"HS256","typ"=>"JWT"}
                
            ])
        end
    end
end