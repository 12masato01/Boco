class Answer < ApplicationRecord
  belongs_to :expert
  belongs_to :question
  validates :expert_id, presence: true
  validates :title, presence: true
  validates :content, presence: true
end
