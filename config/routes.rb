Rails.application.routes.draw do
  root "products#index"
  resources :products do
    resources :feedbacks, only: [ :new, :create ]
  end

  resources :feedbacks do
    collection do
      post :upload_csv
    end
  end
end
