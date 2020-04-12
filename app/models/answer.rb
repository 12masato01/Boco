class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question
  has_many :comments, as: :commentable, dependent: :destroy
  validates :question_id, presence: true
  validates :user_id, presence: true
  validates :content, presence: true
end
