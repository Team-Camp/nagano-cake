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


  #devise_for :users


# 顧客のマイページ、編集画面、退会画面
  scope module: :public do
    get 'customers/mypage' => 'customers#show', as: 'mypage'
    get 'customers/information/edit' => 'customers#edit', as: 'information_edit'
    get 'unsubscribe' => 'customers#unsubscribe', as: 'unsubscribe'
    patch 'customers/information' => 'customers#update'
    patch 'withdraw' => 'customers#withdraw', as: 'withdraw'
    resources :addresses, only: [:index,:edit,:create,:update,:destroy]
  end





# 商品一覧
  namespace :public do
    resources :items, only: [:index, :show]
    resources :cart_items, only:[:index, :update, :destroy, :create] #カート内商品等の記載（濱岡）
    delete 'cart_items' => 'cart_items#destroy_all', as: 'destroy_all'
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
root to: 'public/homes#top'
get '/about' => 'public/homes#about'

 namespace :admin do
  resources :genres, only: [:index,:create,:edit,:update]
  resources :items, only: [:index,:new,:create,:show,:edit,:update] # 商品一覧・・・等の記述
 end




#get '/admin/genres' => 'admin/genres#index'
#post '/admin/genres' => 'admin/genres#create'
#get '/admin/genres/:id/edit' => 'admin/genres#edit'
#patch '/admin/genres/:id' => 'admin/genres#update'

 namespace :public do
   resources :orders, only: [:new,:index,:create,:show] do
     collection do
      post 'confirm'
      get 'complete'
     end
   end
 end



end
