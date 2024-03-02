Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace 'api' do
    namespace 'v1' do
      resources :posts, only: [:index, :create, :show, :update]
      resources :tags
      resources :categories

      get 'posts/search', to: 'posts#search'
    end
  end
end
