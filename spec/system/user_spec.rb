require "rails_helper"
RSpec.describe "ユーザー管理機能", type: :system do
  describe "ユーザの登録のテスト" do
    context "ユーザの場合" do
      it "新規登録ができること" do
        visit new_user_path
        fill_in "user_name", with: "テストユーザー"
        fill_in "user_email", with: "test_user@dic.com"
        fill_in "user_password", with: "password"
        fill_in "user_password_confirmation", with: "password"
        click_on "Create my account"
        expect(page).to have_content "保存しました"
      end
    end

    context "ユーザがログインせずタスク一覧画面にアクセスした場合" do
      it "ログイン画面に遷移すること" do
        visit tasks_path
        expect(page).to have_content "Log in"
      end
    end
  end

  describe "セッション機能のテスト" do
    let!(:user) { FactoryBot.create(:user) }
    before do
      visit new_session_path
      fill_in "session_email", with: user.email
      fill_in "session_password", with: "password"
      click_on "log in"
    end

    context "ユーザがログインした場合" do
      it "ログインできること" do
        expect(page).to have_content user.name
      end
    end

    context "ユーザがログインした場合" do 
      it "自分の詳細画面にアクセスできる" do
        visit user_path(user.id)
        expect(page).to have_content "test_user_01@dic.com"
      end
    end

    context "ユーザが他人の詳細画面にアクセスした場合" do
      it "タスク一覧画面に遷移すること" do
        user = FactoryBot.create(:second_user)
        visit user_path(user.id)
        expect(page).to have_content "ユーザが異なりアクセス出来ません"
      end
    end

    context "ログインした場合" do
      it "ログアウトできるかテスト" do
        visit tasks_path
        click_on "Log out"
        expect(page).to have_content "ログアウトしました"
      end
    end
  end

  describe "管理者のテスト" do
    before do
      FactoryBot.create(:user)
      visit new_session_path
      fill_in "session_email", with: "test_user_01@dic.com"
      fill_in "session_password", with: "password"
      click_on "log in"
    end

    context "管理者の場合" do
      it "管理画面にアクセスできること" do
        visit admin_users_path
        expect(page).to have_content "ユーザー一覧"
      end
    end

    context "管理者の場合" do
      it "ユーザーの新規登録できること" do
        visit new_admin_user_path
        fill_in "user_name", with: "テストユーザー"
        fill_in "user_email", with: "test_user@dic.com"
        uncheck "user_admin"
        fill_in "user_password", with: "password"
        fill_in "user_password_confirmation", with: "password"
        click_on "Create account"
        expect(page).to have_content "保存しました"
        expect(page).to have_content "テストユーザー"
      end
    end

    context "管理者の場合" do
      it "ユーザー詳細画面にアクセスできること" do
        visit admin_users_path
        click_on "詳細"
        expect(page).to have_content "test_user_01"
      end
    end

    context "管理者の場合" do
      it "ユーザの編集画面からユーザを編集できること" do
        visit admin_users_path
        click_on "編集"
        fill_in "user_name", with: "氏名を変更する"
        fill_in "user_email", with: "test_user@dic.com"
        uncheck "user_admin"
        fill_in "user_password", with: "password"
        fill_in "user_password_confirmation", with: "password"
        click_on "Edit account"
        expect(page).to have_content "保存しました"
        expect(page).to have_content "氏名を変更する"
      end
    end

    context "管理者の場合" do
      it "ユーザーを削除できること" do
        visit admin_users_path
        click_on "削除"
        expect(page).to have_content "削除しました"
      end
    end
  
    context "一般ユーザの場合" do
      it "管理画面にアクセス出来ないこと" do
        FactoryBot.create(:second_user)
        visit new_session_path
        fill_in "session_email", with: "test_user_02@dic.com"
        fill_in "session_password", with: "password"
        click_on "log in"
        visit admin_users_path
        expect(page).to have_content "管理者以外はアクセス出来ません"
      end
    end
  end
end