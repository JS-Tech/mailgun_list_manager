MailgunListManager::Engine.routes.draw do

  root to: "lists#index"

  resources :lists do
    resources :members
  end

  mount Adeia::Engine => "/adeia"

end
