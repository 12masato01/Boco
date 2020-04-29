class Question < ApplicationRecord
  belongs_to :user
  has_many :answers, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :notifications, as: :notificable, dependent: :destroy
  default_scope -> { order(created_at: :desc) }
  mount_uploader :image, ImageUploader
  validates :user_id, presence: true
  validates :title, presence: true
  validates :content, presence: true
  validate  :image_size

  def favorite_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def create_notification_comment!(current_user, comment_id)
    temp_ids = Comment.select(:user_id).where(question_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user, comment_id, temp_id['user_id'])
    end
    save_notification_comment!(current_user, comment_id, user_id) if temp_ids.blank?
  end 


  def save_notification_comment!(current_user, comment_id, notified_user_id)
    notification = current_user.active_notifications.new(
      question_id: id,
      comment_id: comment_id,
      notified_user_id: notified_user_id,
      action: 'comment'
    )

    if notification.send_user_id == notification.notified_user_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end

  private

    def image_size
      if image.size > 10.megabytes
        errors.add(:image, "10MB以上は添付できません")
      end
    end
end
