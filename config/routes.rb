Rails.application.routes.draw do
  root 'grounds#show'

  match 'grounds', to: 'grounds#show', as: 'ground_show', via: :get
  match 's/:id', to: 'grounds#shared', as: 'ground_shared', via: :get
  match 'grounds/share', to: 'grounds#share', as: 'ground_share', via: :post
  match 'grounds/switch_option', to: 'grounds#switch_option', as: 'ground_switch_option', via: :put
  post "oauth/callback" => "oauths#callback"
  get "oauth/callback" => "oauths#callback"
  get "oauth/:provider" => "oauths#oauth", :as => :auth_at_provider
  delete "oauth/:provider" => "oauths#destroy", :as => :delete_oauth
end
