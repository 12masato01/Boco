require 'rails_helper'

RSpec.describe Comment, type: :model do
  let!(:comment) { create(:comment, :for_question) }

  describe "バリデーション" do
    context "contentが入力されている場合" do
      it "登録に成功する" do
        expect(comment).to be_valid
      end
    end

    context "contentが空の場合" do
      it "投稿に失敗する" do
        comment = build(:comment, content: nil)
        comment.valid?
      end
    end

    context "user_idが空の場合" do
      it "投稿に失敗する" do
        comment = build(:comment, user_id: nil)
        comment.valid?
      end
    end
  end
end
