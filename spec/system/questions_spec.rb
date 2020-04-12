require "rails_helper"

RSpec.describe "Questions", type: :system do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:question) { create(:question, user: user) }

  describe "質問投稿ページ" do
    before do
      sign_in user
      visit new_question_path
    end

    context "フォームの入力が正しい時" do
      it "投稿に成功し、フラッシュメッセージを表示する" do
        fill_in "question[title]", with: "腰が痛い"
        fill_in "question[content]", with: "どのような運動をしたらよいでしょうか。"
        click_button "質問する"
        expect(page).to have_content "質問が保存されました"
        expect(current_path).to eq questions_path
        expect(page).to have_content "腰が痛い"
      end
    end

    context "フォームの入力が無い時" do
      it "投稿に失敗し、エラーメッセージを表示する" do
        fill_in "question[title]", with: ""
        fill_in "question[content]", with: ""
        click_button "質問する"
        expect(page).to have_content "タイトルを入力してください"
        expect(page).to have_content "コンテンツを入力してください"
      end
    end
  end

  describe "質問表示ページ" do
    before do
      create(:question, title: "腰が痛い", user: user)
      create(:question, title: "肩が痛い", user: other_user)
      sign_in user
    end

    context "質問一覧ページ" do
      before do
      visit questions_path
      end
      it "userとother_userの質問を表示する" do
        expect(page).to have_content "腰が痛い"
        expect(page).to have_content "肩が痛い"
      end
    end

    context "自分の質問ページ" do 
      before do
      visit user_question_path
      end
      it "userの質問を表示する" do
        expect(page).to have_content "腰が痛い"
      end

      it "other_userの質問を表示しない" do
        expect(page).not_to have_content "肩が痛い"
      end
    end
  end

  describe "質問詳細ページ" do
    before do
      sign_in user
      visit question_path(question)
    end

    context "ログインユーザーと、質問投稿者が一致する時" do
      it "編集と削除のリンクを表示する" do
        expect(page).to have_link "編集"
        expect(page).to have_link "削除"
      end

      it "質問の編集をする" do
        click_link "編集"
        fill_in "question[title]", with: "編集済み"
        fill_in "question[content]", with: "編集済みです"
        click_button "編集する"
        expect(page).to have_content "質問を更新しました"
        expect(page).to have_content "編集済み"
      end

      it "質問を削除をする" do
        click_link "削除"
        expect(current_path).to eq questions_path
        expect(page).to have_content "質問が削除されました"
      end
    end

    context "ログインユーザーと、質問投稿者が一致しない時" do
      before do
      sign_in other_user
      visit question_path(question)
      end
      it "編集と削除のリンクを表示しない" do
        expect(page).not_to have_link "編集"
        expect(page).not_to have_link "削除"
      end

       it "質問の編集ができない" do
        visit edit_question_path(question)
        expect(current_path).to eq root_path
        expect(page).to have_content "権限がありません"
      end
    end
  end
end