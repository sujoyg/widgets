Rails.application.routes.draw do
  # Widget names are path names and can have slashes in them.
  resources :widgets, only: [:show], constraints: {id: /.+/}
end