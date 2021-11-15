require 'rails_helper'

describe 'Users API', type: :request do

    describe 'POST /user' do
        it 'create a valid user' do
            expect{
            post '/api/v1/users' ,params: {
                user:{
                email:"test@test.com",
                password:"123",
                password_confirmation:"123",
                name:"test" }
                }
            }.to change { User.count }.from(0).to(1)
                expect(response).to have_http_status(:created)

        end
    end
end