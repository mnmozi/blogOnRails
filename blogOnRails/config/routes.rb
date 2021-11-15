Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      resources :posts, only: [:index, :create, :destroy, :update] do
        scope module: :posts do
          resources :comments, only: [ :index,:create, :destroy, :update]
        end
      end
      resources :tags, only: [ :create, :destroy]

      resources :users, only: [:update,:show]
      # get 'comments/:postId', to: 'comments#getComments'
      post 'signup', to: 'users#create'
      post 'login', to: 'authentication#create'
    end
  end
end
