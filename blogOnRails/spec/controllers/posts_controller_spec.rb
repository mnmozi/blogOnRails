require "rails_helper"

RSpec.describe Api::V1::PostsController, type: :controller do
    it 'has a max limit of 100' do
        expect(Post).to receive(:limit).with(100).and_call_original
       
        get :index, params:{limit: 999}
    end
end