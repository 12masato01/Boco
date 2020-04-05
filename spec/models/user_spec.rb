require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }

  describe "バリデーション" do
    context "emailとpassword、password_confirmationが設定されている場合" do
      it "登録に成功する" do
        expect(user).to be_valid
      end
    end

    context "emailが空の場合" do
      it "登録に失敗する" do
        user = build(:user, email: nil)
        user.valid?
        expect(user.errors[:email]).to include("が入力されていません。")
      end
    end

    context "emailが重複している場合" do
      it "登録に失敗する" do
        other_user = build(:user, email: user.email)
        other_user.valid?
        expect(other_user.errors[:email]).to include("は既に使用されています。")
      end
    end

    context "パスワードが6文字以上の場合" do
      it "登録に成功する" do
        user = build(:user, password: "a" * 6, password_confirmation: "a" * 6)
        user.valid?
        expect(user).to be_valid
      end
    end

    context "passwordが空の場合" do
      it "登録に失敗する" do
        user = build(:user, password: nil)
        user.valid?
        expect(user.errors[:password]).to include("が入力されていません。")
      end
    end

    context "passwordが6文字未満の場合" do
      it "登録に失敗する" do
        user = build(:user, password: "a" * 3)
        user.valid?
        expect(user.errors[:password]).to include("は6文字以上に設定して下さい。")
      end
    end
  end
end
