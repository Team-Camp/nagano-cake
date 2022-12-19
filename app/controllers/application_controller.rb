class ApplicationController < ActionController::Base
  # ログインしていない状態でアクセスを許可するページの記述です。ログイン画面、商品一覧画面、商品詳細情報画面だけ許可します。
  # before_action :authenticate_user!, except: [:top]
  # email＆パスワード意外のデータを、deviseにて受け取れるようにする記述です
  before_action :configure_permitted_parameters, if: :devise_controller? #devise利用の機能（ユーザ登録、ログイン認証など）が使われる前にconfigure_permitted_parametersメソッドが実行

  #devise機能でサインアップ後、サインイン後、ログアウト後にどこに遷移するかを記述
  # def after_sign_up_path_for(resource)
  #   root_path #ふのき「マイページのパスに変更が必要」
  # end

  # def after_sign_in_path_for(resource)
    #root_path #ふのき「トップページのパスに変更が必要」
  # end

  # def after_sign_out_path_for(resource)
  #   root_path #ふのき「トップページのパスに変更が必要」
  # end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number, :is_deleted])
  end

end
