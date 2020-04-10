class ChangeColumnToAnswers < ActiveRecord::Migration[5.2]
  def change
    add_reference :Answers, :user, foreign_key: true
  end
end
