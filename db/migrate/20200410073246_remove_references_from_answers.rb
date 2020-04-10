class RemoveReferencesFromAnswers < ActiveRecord::Migration[5.2]
  def change
    remove_reference :answers, :expert
  end
end
