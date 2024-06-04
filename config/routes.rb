Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace 'api' do
    namespace 'v1' do
      get 'posts/search', to: 'posts#search'
      resources :posts, only: [:index, :create, :show]
      patch 'posts/:id/update', to: 'posts#update'
      delete 'posts/:id/delete', to: 'posts#delete'

      resources :tags
      resources :categories
      get 'categories/:id/posts', to: 'categories#posts'

    end
  end
end
