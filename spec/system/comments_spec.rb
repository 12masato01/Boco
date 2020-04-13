require "rails_helper"

RSpec.describe "Comments", type: :system do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user)}
  let!(:question) { create(:question, user: user) }
  let!(:comment) { create(:comment, :for_question, user: user) }

  describe "質問詳細ページ" do
    before do
      create(:comment, :for_question, content: "こんな解決策があります。", user: user)
      sign_in user
      visit question_path(question)
    end

    context "フォームの入力が正しい時" do
      it "投稿に成功し、フラッシュメッセージを表示する" do
        fill_in "comment[content]", with: "僕も気になります。"
        click_button "コメントする"
        expect(page).to have_content "コメントが投稿されました"
        expect(current_path).to eq question_path(question)
        expect(page).to have_content "僕も気になります。"
      end
    end

    context "フォームの入力が無い時" do
      it "投稿に失敗し、フラッシュメッセージを表示する" do
        fill_in "comment[content]", with: ""
        click_button "コメントする"
        expect(page).to have_content "コメントの投稿に失敗しました"
      end
    end

    context "ログインユーザーとコメント投稿者が一致する時" do
      it "削除のリンクを表示する" do
        expect(page).to have_link "削除"
      end
    end

      it "コメントを削除をする" do #コメントが生成されず落ちる
        within("timestamp") do
          click_link "削除"
        end
        expect(current_path).to eq question_path(comment.question)
        expect(page).to have_content "コメントが削除されました"
      end

    context "ログインユーザーと、質問投稿者が一致しない時" do
      before do
      sign_in other_user
      visit question_path(question)
      end

      it "削除のリンクを表示しない" do
        expect(page).not_to have_link "削除"
      end
    end
  end
end