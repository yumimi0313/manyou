require "rails_helper"
RSpec.describe "ラベル機能", type: :system do
  describe "ラベル機能" do
    let!(:user) { FactoryBot.create(:user) }
    let!(:task) { FactoryBot.create(:task, user:user) }
    let!(:label1) { FactoryBot.create(:label) }
    let!(:label2) { FactoryBot.create(:second_label) }
    let!(:labelling1) { FactoryBot.create(:labelling, task: task, label: label1) }
    let!(:labelling2) { FactoryBot.create(:labelling, task: task, label: label2) }
    
    before do
      visit new_session_path
      fill_in "session_email", with: "test01@aaa.com"
      fill_in "session_password", with: "password"
      click_on "log in"
    end
    
    it "ラベルを複数新規登録できる" do
      visit new_task_path
      fill_in 'task_title', with: '掃除'
      fill_in 'task_content', with: '部屋の掃除'
      fill_in 'task_due_date', with: '002022/10/11' 
      select '未着手', from: 'task_status'
      select '中', from: 'task_priority'
      check "勉強"
      check "仕事"
      click_on "登録する"
      expect(page).to have_content '勉強'
    end

    it "タスクと一緒に編集できる" do
      visit edit_task_path(task.id)
      fill_in 'task_title', with: '掃除'
      fill_in 'task_content', with: '部屋の掃除'
      fill_in 'task_due_date', with: '002022/10/11' 
      select '未着手', from: 'task_status'
      select '中', from: 'task_priority'
      check "仕事"
      click_on "登録する"
      expect(page).to have_content '仕事'
    end

    it "タスクの詳細画面で、タスクに紐づいてるラベルを確認できる" do
      visit task_path(task.id)
      expect(page).to have_content '勉強'
      expect(page).to have_content '仕事'
    end

    it  "ラベルで検索できるかテスト" do
      visit tasks_path
      select "勉強", from: "task_label_id"
      click_on "Search"
      expect(page).to have_content "勉強"
    end
  end
end