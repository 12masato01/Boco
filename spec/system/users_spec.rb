require "rails_helper"

RSpec.describe "Users", type: :system do
  let!(:user) { (:user) }

  describe "会員登録ページ" do
    before do
      visit new_user_registration_path
    end

    context "フォームの入力が正しい時" do
      it "登録に成功し、フラッシュメッセージを表示する" do
        fill_in "user[email]", with: "user.email"
        fill_in "user[password]", with: "password"
        fill_in "user[password_confirmation]", with: "password"
        click_on "登録する"
        expect(page).to have_content "アカウント登録が完了しました。"
      end
    end

    context "フォームの入力が誤っている時" do
      it "登録に失敗し、エラーメッセージを表示する" do
        fill_in "user[email]", with: "test@example.com"
        fill_in "user[password]", with: "password"
        fill_in "user[password_confirmation]", with: "pass"
        click_on "登録する"
        expect(page).to have_content "確認用パスワードとパスワードの入力が一致しません"
      end
    end
  end

  describe "ログインページ" do
    before do
      visit new_user_session_path
    end

     context "フォームの入力が正しい時" do
      it "ログインに成功し、フラッシュメッセージを表示する" do
        fill_in "user[email]", with: "user.email"
        fill_in "user[password]", with: "password"
        click_button "ログイン"
        expect(page).to have_content "ログインしました"
      end
    end
  end
end