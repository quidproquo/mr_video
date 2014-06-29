MrVideo::Engine.routes.draw do

  root to: 'cassettes#index'

  resources :cassettes, only: [:index, :show, :destroy] do
    resources :episodes, only: [:show, :destroy]
  end

end