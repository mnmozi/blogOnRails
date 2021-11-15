require 'rails_helper'

describe 'Posts API', type: :request do
    describe 'GET /posts' do
        
            let(:first_user) {FactoryBot.create(:user, email: "test@test.com",name: "test",password_digest: "1234" )}
            before do
            FactoryBot.create(:post, user: first_user, title: "hello", body: "hello baby it's me slim shady")
            FactoryBot.create(:post, user: first_user, title: "hello2", body: "hello baby it's me slim2 shady2")
        end
        it 'return all posts' do
                get '/api/v1/posts'

                expect(response).to have_http_status(:success)
                expect(JSON.parse(response.body).size).to eq(2)
            end
        
        it 'returns a subset of books based on limit' do
            get '/api/v1/posts', params:{limit: 1}
            expect(response).to have_http_status(:success)
            expect(JSON.parse(response.body).size).to eq(1)


        end
        it 'returns a subset of posts based on limit' do
            get '/api/v1/posts', params:{limit: 1, offset: 1}
            expect(response).to have_http_status(:success)
            expect(JSON.parse(response.body).size).to eq(1)


        end

    end

    describe 'POST /posts' do
        
        let(:user) {FactoryBot.create(:user, id:1, email: "test@test.com",name: "test",password: "password1" )}
        let(:token){ AuthenticationTokenService.call(1) }
        it 'create a new posts' do
            expect{
                post '/api/v1/posts', params: {
                    post: {user: user.id, title: "Slim shady" , body: "Hi kids do you like violence!"}
                },headers: {"Authorization" => "Bearer "+token}
            }.to change { Post.count }.from(0).to(1)

            expect(response).to have_http_status(:created)
        end

    end


    
end