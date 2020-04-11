class Answer < ApplicationRecord  
  belongs_to :user
  belongs_to :question
  has_many :comments, as: :commentable
  validates :question_id, presence: true
  validates :user_id, presence: true
  validates :content, presence: true
end
