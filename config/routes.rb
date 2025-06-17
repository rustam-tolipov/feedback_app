Rails.application.routes.draw do
  root "products#index"
  resources :products do 
    resources :feedbacks, only: [:create]
  end

  resources :feedbacks do
    collection do
      get :upload_csv_form
      post :upload_csv
    end
  end
end
