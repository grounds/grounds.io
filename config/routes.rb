Rails.application.routes.draw do
  root 'grounds#show'

  match 'grounds', to: 'grounds#show', as: 'ground_show', via: :get
  match 's/:id', to: 'grounds#shared', as: 'ground_shared', via: :get
  match 'grounds/share', to: 'grounds#share', as: 'ground_share', via: :post
  match 'grounds/switch_option', to: 'grounds#switch_option', as: 'ground_switch_option', via: :put
end
