require 'rails_helper'

RSpec.describe Answer, type: :model do
  let!(:answer) { create(:answer) }

  describe "バリデーション" do
    context "contentが入力されている場合" do
      it "登録に成功する" do
        expect(answer).to be_valid
      end
    end

    context "contentが空の場合" do
      it "投稿に失敗する" do
        answer = build(:answer, content: nil)
        answer.valid?
      end
    end

    context "user_idが空の場合" do
      it "投稿に失敗する" do
        answer = build(:answer, user_id: nil)
        answer.valid?
      end
    end

    context "question_idが空の場合" do
      it "投稿に失敗する" do
        answer = build(:answer, question_id: nil)
        answer.valid?
      end
    end
  end
end
