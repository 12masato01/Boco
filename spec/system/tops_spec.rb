require "rails_helper"

RSpec.describe "Tops", type: :system do
  let!(:user) { create(:user) }
  let!(:question) { create(:question, user: user) }

  describe "トップページ" do
    before do
      visit root_path
    end

    it "タイトルが表示されている事を確認する" do
      expect(page).to have_title full_title
    end

    it "会員登録へのリンクが表示されている事を確認する" do
      expect(page).to have_link "まずは会員登録"
    end

    it "質問が表示されている事を確認する" do
      expect(page).to have_link question.title
    end

    it "質問一覧へのリンクが表示されている事を確認する" do
      expect(page).to have_link "もっと質問を見る"
    end
  end
end