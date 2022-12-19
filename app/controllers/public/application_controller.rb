class Public::ApplicationController < ApplicationController
  
  # ログイン後の遷移先ページはトップページ（ルートパス）
  def after_sign_in_path_for(resource)
    root_path
  end
  
  # 新規登録後の遷移先ページ
  # def after_sign_up_path_for(resource)
  #   customers_mypage_path
  # end
end
