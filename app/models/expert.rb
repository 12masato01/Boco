class Expert < ApplicationRecord
  has_many :answers, dependent: :destroy
  belongs_to :question, dependent: :destroy
  validates :expert_id, presence: true
  validates :title, presence: true
  validates :content, presence: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, #:registerable,
         :recoverable, :rememberable, :validatable
end
