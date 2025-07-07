class AddColumnsToUsers < ActiveRecord::Migration[6.1]
  def change
    # ユーザー名（必須）
    add_column :users, :name, :string, null:false
    # ゲストユーザーかどうか（デフォルトはfalse）
    add_column :users, :is_guest, :boolean, null: false, default: false
     # 利用可能状態（論理削除対応、デフォルトtrue）
    add_column :users, :is_active, :boolean, null: false, default: true
  end
end
