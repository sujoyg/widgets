Rails.application.routes.draw do
  resources :widgets, only: [] do
    member do
      get :remove
      get :replace
      get :show, constraints: {id: /.+/} # Widget names are path names and can have slashes in them.
    end
  end
end