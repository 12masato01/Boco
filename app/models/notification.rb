class Notification < ApplicationRecord
  belongs_to :send_user, class_name: 'User', foreign_key: 'send_user_id'
  belongs_to :notified_user, class_name: 'User', foreign_key: 'notified_user_id'
  belongs_to :notificable, polymorphic: true
  validates :send_user_id, presence: true
  validates :notified_user_id, presence: true
end
