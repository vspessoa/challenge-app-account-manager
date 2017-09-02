Rails.application.routes.draw do
  root 'transactions#index'
  
  resources :transactions
  post '/transactions/:id/reversal', to: 'transactions#reversal', as: 'transaction_reversal'

  scope '/api', defaults: { format: :json } do
    resources :transactions
    post '/transactions/:id/reversal', to: 'transactions#reversal', as: 'api_transaction_reversal'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
