class WelcomeController < ApplicationController
  def index
    # 配合Bootstrap内建的特效，制作Rails的提示信息
    flash[:notice] = " 下午好 ！ 您好 ！"
    # flash[:alert] = " 夜深了 ！ 该睡觉了 ！"
    # flash[:warning] = "操作不合规范，警告一次！"
  end
end
