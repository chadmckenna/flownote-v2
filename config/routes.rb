Rails.application.routes.draw do
  root to: "notes#index"

  devise_for :users, path: 'auth', path_names: { sign_in: 'login', sign_out: 'logout' }

  resources :notes do
    collection do
      get 'by_tag/*names', to: 'notes#by_tag', as: 'by_tag'
    end
    member do
      post :make_public, to: 'notes#make_public'
      post :make_private, to: 'notes#make_private'
    end
  end

  get '~:user', to: 'shares#index', as: 'shares'
  get '~:user/:slug', to: 'shares#show', as: 'share'
  get '~:user/by_tag/*names', to: 'shares#by_tag', as: 'shares_by_tag'

  get '/', to: 'notes#index', as: 'user'
  get '/', to: 'notes#index', as: 'users'

  get '/search', to: 'searches#search', as: 'search'
end
