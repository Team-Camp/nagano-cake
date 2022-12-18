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


  scope module: :public do
    get 'customers/mypage' => 'customers#show', as: 'mypage'
    get 'customers/information/edit' => 'customers#edit', as: 'information_edit'
    get 'unsubscribe' => 'customers#unsubscribe', as: 'unsubscribe'
    patch 'customers/information' => 'customers#update'
    patch 'withdraw' => 'customers#withdraw', as: 'withdraw'
  end


  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
get '/top' => 'public/homes#top'
get '/about' => 'public/homes#about'
end
