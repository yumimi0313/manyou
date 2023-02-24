require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  # let!(:task) { FactoryBot.create(:task) }
  # let!(:new_task) { FactoryBot.create(:second_task) }
  # let!(:shine_task) { FactoryBot.create(:third_task) }
  describe '新規作成機能' do
    context 'タスクを新規作成した場合、ステータスも登録' do
      it '作成したタスクが表示される' do
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

  # describe '新規作成機能' do
  #   context 'タスクを新規作成した場合' do
  #     it '作成したタスクが表示される' do
  #       # 1. new_task_pathに遷移する（新規作成ページに遷移する）
  #       # ここにnew_task_pathにvisitする処理を書く
  #       visit new_task_path
  #       # 2. 新規登録内容を入力する
  #       #「タスク名」というラベル名の入力欄と、「タスク詳細」というラベル名の入力欄にタスクのタイトルと内容をそれぞれ入力する
  #       # ここに「タスク名」というラベル名の入力欄に内容をfill_in（入力）する処理を書く
  #       fill_in 'task_title', with: '掃除'
  #       # ここに「タスク詳細」というラベル名の入力欄に内容をfill_in（入力）する処理を書く
  #       fill_in 'task_content', with: '部屋の掃除'
  #       # 3. 「登録する」というvalue（表記文字）のあるボタンをクリックする
  #       # ここに「登録する」というvalue（表記文字）のあるボタンをclick_onする（クリックする）する処理を書く
  #       click_on '登録する'
  #       # 4. clickで登録されたはずの情報が、タスク詳細ページに表示されているかを確認する
  #       # （タスクが登録されたらタスク詳細画面に遷移されるという前提）
  #       # ここにタスク詳細ページに、テストコードで作成したデータがタスク詳細画面にhave_contentされているか（含まれているか）を確認（期待）するコードを書く
  #       expect(page).to have_content '掃除'
  #     end
  #   end
  # end
  # describe '一覧表示機能' do
  #   context '一覧画面に遷移した場合' do
  #     it '作成済みのタスク一覧が表示される' do
  #       visit tasks_path
  #       # visitした（遷移した）page（タスク一覧ページ）に「task」という文字列が
  #       # have_contentされているか（含まれているか）ということをexpectする（確認・期待する）
  #       expect(page).to have_content 'test'
  #       # expectの結果が true ならテスト成功、false なら失敗として結果が出力される
  #     end
  #   end
  #   context 'タスクが作成日時の降順に並んでいる場合' do
  #     it '新しいタスクが一番上に表示される' do
  #       FactoryBot.create(:second_task)
  #       FactoryBot.create(:third_task) 
  #       visit tasks_path
  #       task_list = all('.task_row') 
  #       # タスク一覧を配列として取得するため、View側でclassを振っておく
  #       expect(task_list[0]).to have_content 'shine'
  #       expect(task_list[1]).to have_content 'new'
  #       expect(task_list[2]).to have_content 'test'
  #     end
  #   end
  # end
  # describe '詳細表示機能' do
  #   context '任意のタスク詳細画面に遷移した場合' do
  #     it '該当タスクの内容が表示される' do
  #       visit task_path(task.id)
  #       expect(page).to have_content 'title'
  #      end
  #    end
  # end
end