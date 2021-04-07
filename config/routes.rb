Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :groups
  # 将 / 根地址指向welcome下的index页面渲染
  # root 'welcome#index'
  # 将跟地址指向讨论组列表页渲染
  root 'groups#index'
end
