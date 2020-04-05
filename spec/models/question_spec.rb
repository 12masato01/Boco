require 'rails_helper'

RSpec.describe Question, type: :model do
  let!(:question) { create(:question) }

  describe "バリデーション" do
    context "titleとcontentが入力されている場合" do
      it "登録に成功する" do
        expect(question).to be_valid
      end
    end

    context "titleが空の場合" do
      it "投稿に失敗する" do
        question = build(:question, title: nil)
        question.valid?
      end
    end

    context "contentが空の場合" do
      it "投稿に失敗する" do
        question = build(:question, content: nil)
        question.valid?
      end
    end

    context "user_idが空の場合" do
      it "投稿に失敗する" do
        question = build(:question, user_id: nil)
        question.valid?
      end
    end
  end
end
