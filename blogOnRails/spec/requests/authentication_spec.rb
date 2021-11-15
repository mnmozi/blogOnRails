require 'rails_helper'

describe 'Authentication', type: :request do

    describe 'POST /authentication' do

        let(:user) {FactoryBot.create(:user,id:1, email: "test@test.com",name: "test",password: "password1" )}
        it 'authenticate the client' do
            post '/api/v1/authenticate', params: {email:user.email, password: "password1"}
            
            expect(response).to have_http_status(:created)
            expect(JSON.parse(response.body)).to eq({
                    'token' => 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.J_RIIkoOLNXtd5IZcEwaBDGKGA3VnnYmuXnmhsmDEOs'
                }
            )
        end

        it'returns error when username is missing' do
            post '/api/v1/authenticate', params: {password: "1234"}
            expect(response).to have_http_status(:unprocessable_entity)
            # expect(JSON.parse(response.body)).to eq({
            #     'error' => 'param is missing or the value is empty: email'
            # })
            
        end

        it'returns error when password is missing'do
        post '/api/v1/authenticate', params: {email:user.email}
        expect(response).to have_http_status(:unprocessable_entity)
        # expect(JSON.parse(response.body)).to eq({
        #     'error' => 'param is missing or the value is empty: password'
        # })
        end
        
        it 'returns error when password is incorrect' do
            post '/api/v1/authenticate', params: {email:user.email,password: "incorrect"}
            expect(response).to have_http_status(:unauthorized)
        end
    end


end