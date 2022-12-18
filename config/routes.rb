Rails.application.routes.draw do
  #devise_for :admins
  # devise_for :customers
# 顧客用
# URL /customers/sign_in ...
  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
 sessions: "admin/sessions"
}
  #devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
get '/top' => 'public/homes#top'
get '/about' => 'public/homes#about'

 namespace :admin do
  resources :genres, only: [:index,:create,:edit,:update]
 end
#get '/admin/genres' => 'admin/genres#index'
#post '/admin/genres' => 'admin/genres#create'
#get '/admin/genres/:id/edit' => 'admin/genres#edit'
#patch '/admin/genres/:id' => 'admin/genres#update'

end
