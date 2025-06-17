Rails.application.routes.draw do
  root "products#index"
  resources :products

  resources :feedbacks do
    collection do
      get :upload_csv_form
      post :upload_csv
    end
  end
end
