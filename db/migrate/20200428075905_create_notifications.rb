class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.references :send_user_id, foreign_key:{ to_table: :users }, null: false
      t.references :notified_user_id, foreign_key:{ to_table: :users }, null: false
      t.references :notificable, polymorphic: true
      t.string :action, null: false
      t.boolean :checked, default: false, null: false

      t.timestamps
    end
  end
end
