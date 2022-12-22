class ApplicationController < ActionController::Base
  # ログインしていない状態でアクセスを許可するページの記述です。ログイン画面、商品一覧画面、商品詳細情報画面だけ許可します。
  # before_action :authenticate_user!, except: [:top]
  # email＆パスワード意外のデータを、deviseにて受け取れるようにする記述です
  before_action :configure_permitted_parameters, if: :devise_controller? #devise利用の機能（ユーザ登録、ログイン認証など）が使われる前にconfigure_permitted_parametersメソッドが実行

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number, :is_deleted])
  end

end
