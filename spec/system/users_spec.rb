require "rails_helper"

RSpec.describe "Users", type: :system do
  let!(:user) { create(:user) }
  describe "会員登録ページ" do
    before do
      visit new_user_registration_path
    end

    context "フォームの入力が正しい時" do
      it "登録に成功し、フラッシュメッセージを表示する" do
        fill_in "user[email]", with: "test@example.com"
        fill_in "user[password]", with: "password"
        fill_in "user[password_confirmation]", with: "password"
        click_on "登録する"
        expect(page).to have_content "アカウント登録が完了しました。"
        expect(current_path).to eq root_path
      end
    end

    context "フォームの入力が誤っている時" do
      it "登録に失敗し、エラーメッセージを表示する" do
        fill_in "user[email]", with: "test@example.com"
        fill_in "user[password]", with: "password"
        fill_in "user[password_confirmation]", with: "pass"
        click_on "登録する"
        expect(page).to have_content "確認用パスワードとパスワードの入力が一致しません"
        expect(current_path).to eq new_user_registration_path
      end
    end
  end

  describe "ログインページ" do
    before do
      visit new_user_session_path
    end

    context "フォームの入力が正しい時" do
      it "ログインに成功し、フラッシュメッセージを表示する" do
        fill_in "user[email]", with: "#{user.email}"
        fill_in "user[password]", with: "password"
        click_button "ログイン"
        expect(page).to have_content "ログインしました"
        expect(current_path).to eq root_path
      end
    end

    context "フォームの入力が誤っている時" do
      it "ログインに失敗し、フラッシュメッセージを表示する" do
        fill_in "user[email]", with: "#{user.email}"
        fill_in "user[password]", with: "pass"
        click_button "ログイン"
        expect(page).to have_content "メールアドレスまたはパスワードが違います。"
        expect(current_path).to eq new_user_session_path
      end
    end
  end

  describe "マイページ" do
    before do
      sign_in user
      visit edit_user_registration_path
    end

    context "有効なプロフィールを更新する時" do
      it "更新に成功する" do
        fill_in "user[name]", with: "test_name"
         click_button "更新する"
        expect(page).to have_content "アカウント情報を変更しました。"
        expect(current_path).to eq root_path
      end
    end

    context "誤ったプロフィールを更新する時" do
      it "更新に失敗する" do
        fill_in "user[name]", with: "test_name"
        fill_in "user[email]", with: ""
        click_button "更新する"
        expect(page).to have_content "メールアドレスが入力されていません。"
        expect(current_path).to eq edit_user_registration_path
      end
    end

    it "ログアウトする" do
      click_on "ログアウト"
      sign_out user
      expect(page).to have_content "ログアウトしました。"
      expect(current_path).to eq root_path
    end

    it "アカウントを削除する" do
      click_on "アカウントを削除"
      expect(page.driver.browser.switch_to.alert.text).to eq "本当に削除していいですか？"
      page.driver.browser.switch_to.alert.accept
      expect(page).to have_content "アカウントを削除しました。またのご利用をお待ちしております。"
      expect(current_path).to eq root_path
    end
  end
end