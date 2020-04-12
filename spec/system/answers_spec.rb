require "rails_helper"

RSpec.describe "Answers", type: :system do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:question) { create(:question, user: user) }
  let!(:answer) { create(:answer, question: question, user_id: user.id)}

  describe "回答ページ" do
    before do
      sign_in user
      visit new_answer_path(question)
    end

    context "フォームの入力が正しい時" do
      it "投稿に成功し、フラッシュメッセージを表示する" do
        fill_in "answer[content]", with: "このような解決策があります。"
        click_button "回答する"
        expect(page).to have_content "回答が保存されました"
        expect(current_path).to eq questions_path
        expect(page).to have_content "腰が痛い"
      end
    end

    context "フォームの入力が無い時" do
      it "投稿に失敗し、エラーメッセージを表示する" do
        fill_in "answer[content]", with: ""
        click_button "回答する"
        #expect(page).to have_content "コンテンツを入力してください"
      end
    end
  end

  describe "質問詳細ページ" do
    before do
      create(:answer, content: "こんな解決策があります。", user: user)
      sign_in user
      visit question_path(question)
    end

    context "ログインユーザーと回答投稿者が一致する時" do
      it "編集と削除のリンクを表示する" do
       expect(page).to have_link "編集"
       expect(page).to have_link "削除"
      end

      it "回答の編集をする" do
        click_link "編集", match: :second
        fill_in "question[content]", with: "編集済みです"
        click_button "編集する"
        expect(page).to have_content "回答を更新しました"
        #expect(page).to have_content "回答を更新しました"
      end

      it "回答を削除をする" do
        click_link "削除", match: :second
        expect(current_path).to question_path(question)
        expect(page).to have_content "回答が削除されました"
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
        visit edit_answer_path(answer)
        expect(current_path).to eq root_path
        expect(page).to have_content "権限がありません"
      end
    end
  end
end