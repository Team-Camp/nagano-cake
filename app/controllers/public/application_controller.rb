class Public::ApplicationController < ApplicationController
  

  # サインイン後の遷移先ページ
  #def after_sign_in_path_for(resource)
    #root_path
  #end
  
  # ログイン後の遷移先ページ
  def after_sign_up_path_for(resource)
    customers_mypage_path
  end
end
