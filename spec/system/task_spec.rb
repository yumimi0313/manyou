require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  # let!(:task) { FactoryBot.create(:task) }
  # let!(:new_task) { FactoryBot.create(:second_task) }
  # let!(:shine_task) { FactoryBot.create(:third_task) }
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in 'task_title', with: '掃除'
        fill_in 'task_content', with: '部屋の掃除'
        click_on '登録する'
        expect(page).to have_content '掃除'
      end
    end
  end
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        FactoryBot.create(:task)
        visit tasks_path
        expect(page).to have_content 'test'
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        FactoryBot.create(:task)
        FactoryBot.create(:second_task)
        FactoryBot.create(:third_task) 
        visit tasks_path
        task_list = all('.task_row') 
        # タスク一覧を配列として取得するため、View側でclassを振っておく
        expect(task_list[0]).to have_content 'shine'
        expect(task_list[1]).to have_content 'new'
        expect(task_list[2]).to have_content 'test'
      end
    end
  end
  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
        task = FactoryBot.create(:task)
        visit task_path(task.id)
        expect(page).to have_content 'test'
       end
     end
  end
  describe '終了期限のテスト' do
      context '終了期限の新規作成' do
        it '作成した終了期限が表示される' do
          visit new_task_path
          fill_in 'task_title', with: '掃除'
          fill_in 'task_content', with: '部屋の掃除'
          fill_in 'task_due_date', with: '002022/10/11' 
          click_on '登録する'
          expect(page).to have_content '2022-10-11'
        end
      end
      context 'タスクが終了期限の降順に並んでいる場合' do
        it '期限が先の日が一番上に表示される' do
          FactoryBot.create(:task)
          FactoryBot.create(:second_task)
          FactoryBot.create(:third_task) 
          visit tasks_path
          click_link '終了期限'
          sleep 1.0
          task_list = all('.task_row') 
          # タスク一覧を配列として取得するため、View側でclassを振っておく
          expect(task_list[0]).to have_content '2022-12-01'
          expect(task_list[1]).to have_content '2022-11-01'
          expect(task_list[2]).to have_content '2022-10-01'
        end
      end
    end
  describe 'ステータス新規作成機能' do
    context 'タスクを新規作成した場合、ステータスも登録' do
      it '作成したステータスが表示される' do
        visit new_task_path
        select '未着手', from: 'task_status'
        click_on '登録する'
        expect(page).to have_content '未着手'
      end
    end
  end
  describe '検索機能' do
    before do
      FactoryBot.create(:task)
      FactoryBot.create(:second_task)
    end
    context 'タイトルであいまい検索をした場合' do
      it "検索キーワードを含むタスクで絞り込まれる" do
        visit tasks_path
        # タスクの検索欄に検索ワードを入力する (例: task)
        fill_in "task_title", with: "test"
        # 検索ボタンを押す
        click_on 'Search'
        expect(page).to have_content 'test'
      end
    end
    context 'ステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        visit tasks_path
        select "未着手", from: "task_status"
        click_on 'Search'
      end
    end
    context 'タイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        visit tasks_path
        fill_in "task_title", with: "test"
        select "未着手", from: "task_status"
        click_on 'Search'
        expect(page).to have_content "test"
        expect(page).to have_content "未着手"
      end
    end
  end
end