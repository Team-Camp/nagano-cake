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

#管理者用(namespace使用,adminフォルダからcutmoersコントローラへ移動)
namespace :admin do
  resources:customers, only: [:index, :show, :edit, :update]
end

  scope module: :public do
    get 'customers/mypage' => 'customers#show', as: 'mypage'
    get 'customers/information/edit' => 'customers#edit', as: 'information_edit'
    get 'unsubscribe' => 'customers#unsubscribe', as: 'unsubscribe'
    patch 'customers/information' => 'customers#update'
    patch 'withdraw' => 'customers#withdraw', as: 'withdraw'
  end

  namespace :public do
    resources :items, only: [:index, :show]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
get '/top' => 'public/homes#top'
get '/about' => 'public/homes#about'

 namespace :admin do
  resources :genres, only: [:index,:create,:edit,:update]
  resources :items, only: [:index,:new,:create,:show,:edit,:update] # 商品一覧・・・等の記述
 end
#get '/admin/genres' => 'admin/genres#index'
#post '/admin/genres' => 'admin/genres#create'
#get '/admin/genres/:id/edit' => 'admin/genres#edit'
#patch '/admin/genres/:id' => 'admin/genres#update'

end
