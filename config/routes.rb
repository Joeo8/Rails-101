Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # 将 / 根地址指向welcome下的index页面渲染
  resources :groups
  root 'welcome#index'
end
