class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.integer :send_user_id, null: false
      t.integer :notified_user_id, null: false
      t.boolean :checked, default: false, null: false
      t.references :notificable, polymorphic: true

      t.timestamps
    end
  end
end
