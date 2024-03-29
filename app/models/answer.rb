class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :notifications, as: :notificable, dependent: :destroy
  mount_uploader :image, ImageUploader
  validates :question_id, presence: true
  validates :user_id, presence: true
  validates :content, presence: true
  validate  :image_size

  def create_notification_comment!(current_user, comment_id)
    temp_ids = Comment.select(:user_id).where(answer_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user, comment_id, temp_id['user_id'])
    end
    save_notification_comment!(current_user, comment_id, user_id) if temp_ids.blank?
  end

  def save_notification_comment!(current_user, comment_id, notified_user_id)
    notification = current_user.active_notifications.new(
      answer_id: id,
      comment_id: comment_id,
      notified_user_id: notified_user_id,
      action: 'comment'
    )

    notification.checked = true if notification.send_user_id == notification.notified_user_id
    notification.save if notification.valid?
  end

  private

  def image_size
    errors.add(:image, '10MB以上は添付できません') if image.size > 10.megabytes
  end
end
