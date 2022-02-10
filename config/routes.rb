Rails.application.routes.draw do
  devise_for :users, path: 'auth', path_names: { sign_in: 'login', sign_out: 'logout' }

  resources :notes do
    collection do
      get 'by_tag/:name', to: 'notes#by_tag', as: 'by_tag'
    end
  end

  root to: "notes#index"
end
