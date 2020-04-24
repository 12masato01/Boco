class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question
  has_many :comments, as: :commentable, dependent: :destroy
  mount_uploader :image, ImageUploader
  validates :question_id, presence: true
  validates :user_id, presence: true
  validates :content, presence: true  
  validate  :image_size

  private

    def image_size
      if image.size > 10.megabytes
        errors.add(:image, "10MB以上は添付できません")
      end
    end
end
