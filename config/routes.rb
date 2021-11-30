Rails.application.routes.draw do
  root :to => "application#index"
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end
  match "/", to: "application#index", via: :get, as: :home
  match "/graphql", to: "graphql#execute", via: [:get, :post], as: :graphql
  match "/confirm_email", to: "application#index", via: [:get, :post], as: :confirm_email
  match "*path", to: "application#index", format: false, via: :get
end
