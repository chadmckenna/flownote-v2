Rails.application.routes.draw do
  root "notes#index"

  resources :notes do
    collection do
      get 'by_tag/:name', to: 'notes#by_tag', as: 'by_tag'
    end
  end
end
