Rails.application.routes.draw do
  match "/", to: "home#index", via: :get
  match "/login", to: "login#index", via: :get
  match "/login", to: "login#login", via: :post
  match "/register", to: "register#index", via: :get
  match "/register", to: "register#register", via: :post
  match "/search", to: "search#index", via: :get
  match "/admin", to: "admin#index", via: :get
  match "/admin/book", to: "admin#book", via: :get
  match "/admin/book", to: "admin#saveBook", via: :post
  match '*path', to: redirect('/404.html'), via: :all
end
