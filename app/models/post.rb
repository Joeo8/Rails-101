class Post < ApplicationRecord
  belongs_to :user
  belongs_to :group

  validates :content , presence: true


  # 利用Rails内建的API scope实现排序功能 （维护上更可观）
  scope :recent , ->  {order("created_at DESC")}
end
