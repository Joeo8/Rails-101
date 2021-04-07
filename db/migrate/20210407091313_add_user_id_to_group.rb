class AddUserIdToGroup < ActiveRecord::Migration[5.0]
  def change
    # 新增user_id到group的table里
    add_column :groups, :user_id, :integer
  end
end
