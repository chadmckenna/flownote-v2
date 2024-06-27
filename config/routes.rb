Rails.application.routes.draw do
  root to: "notes#index"

  devise_for :users, path: 'auth', path_names: { sign_in: 'login', sign_out: 'logout' }

  resources :notes do
    collection do
      get 'by_tag/*names', to: 'notes#by_tag', as: 'by_tag'
      get :export, to: 'notes#export'
    end
    member do
      post :make_public, to: 'notes#make_public'
      post :make_private, to: 'notes#make_private'
      get :history, to: 'notes#history'
    end
  end

  resources :folders do
    member do
      delete '/files/:file_id', to: 'folders#destroy_file', as: 'destroy_file_in'
      put '/files/:file_id/rename', to: 'folders#rename_file', as: 'rename_file_in'
    end
  end

  get '/links', to: 'links#index', as: 'links'

  get '~:user', to: 'shares#index', as: 'shares'
  get '~:user/n/:slug', to: 'shares#show', as: 'share'
  get '~:user/t/*names', to: 'shares#by_tag', as: 'shares_by_tag'

  get '/', to: 'notes#index', as: 'user'
  get '/', to: 'notes#index', as: 'users'

  get '/search', to: 'searches#search', as: 'search'
end
