class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :posts
  has_many :groups

  has_many :group_relationships
  has_many :participated_groups, :through => :group_relationships ,:source => :group


  # 在群组里面判断是否为群组成员
  def is_member_of?(group)
    participated_groups.include?(group)
  end

  # 加入群组和退出群组操作
  def join!(group)
    participated_groups << group
  end

  def quit!(group)
    participated_groups.delete(group)
  end

end
