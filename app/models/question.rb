class Question < ApplicationRecord
  belongs_to :user
  has_many :answers, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :favorites, dependent: :destroy
  default_scope -> { order(created_at: :desc) }
  mount_uploader :image, ImageUploader
  validates :user_id, presence: true
  validates :title, presence: true
  validates :content, presence: true
  validate  :image_size

  def favorite_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  private

    def image_size
      if image.size > 5.megabytes
        errors.add(:picture, "5MB以上は添付できません")
      end
    end
end
