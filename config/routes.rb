Rails.application.routes.draw do
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end
  post "/graphql", to: "graphql#execute"
  root :to => "application#index"
  match "/confirm_email", to: "application#index", via: [:get, :post], as: :confirm_email
  match "*path", to: "application#index", format: false, via: :get
end
