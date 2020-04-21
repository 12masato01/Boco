require 'rails_helper'

RSpec.describe Favorite, type: :model do
  let(:favorite) { create(:favorite) }

  describe "バリデーション" do
    context "user_idとquestion_idがある時" do
      it "お気に入りできる" do
        expect(favorite).to be_valid
      end
    end

    context "user_idがない時" do
      it "お気に入りできない" do
        favorite = build(:favorite, user_id: nil)
        favorite.valid?
      end
    end

     context "question_idがない時" do
      it "お気に入りできない" do
        favorite = build(:favorite, question_id: nil)
        favorite.valid?
      end
    end

    context "既お気に入りされている場合" do
      it "お気に入りできない" do
        favorite
        other_favorite = build(:favorite, user_id: favorite.user_id, question_id: favorite.question_id)
        expect(other_favorite).not_to be_valid
      end
    end
  end
end