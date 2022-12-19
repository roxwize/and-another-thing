Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root to: "pages#index"

  get "dashboard", to: "user#dashboard"
  get "explore", to: "pages#explore"

  get "/blog/create", to: "user#makeblog"
  post"/blog/create", to: "user#finalisemakeblog"

  get "/blog/edit", to: "user#editblog"
  patch "/blog/edit", to: "user#finaliseeditblog"

  get "/blog/editpost", to: "user#editpost"
  patch"/blog/editpost", to: "user#finaliseeditpost"

  get "/blog/createpost", to: "user#makepost"
  post"/blog/createpost", to: "user#finalisemakepost"

  get "/blog/createcomment", to: "user#makecomment"
  post"/blog/createcomment", to: "user#finalisemakecomment"

  get "/blog/view", to: "pages#viewblog"
  get "/blog/post", to: "pages#viewpost"
  get "/blog/upvote", to: "user#upvoteblog"
end
