Rails.application.routes.draw do
  root to: 'tickets#index'

  devise_for :users
  resources :tickets, except: :create do
    collection do
      post :submit
      get :import_csv
    end
    resources :comments, except: %i[index show]
  end
end
