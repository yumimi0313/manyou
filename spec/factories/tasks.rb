# 「FactoryBotを使用します」という記述
FactoryBot.define do
  # 作成するテストデータの名前を「task」とします
  # （実際に存在するクラス名と一致するテストデータの名前をつければ、そのクラスのテストデータを自動で作成します）
  factory :task do
    title { 'test' }
    content { 'test_content' }
    due_date { '2022/10/01' }
    status { '未着手'}
    priority { '低' }
  end

  factory :second_task, class: Task do
    title { 'new' }
    content { 'new_content' }
    due_date { '2022/11/01' }
    status { '着手中'}
    priority { '中' }
  end

    factory :third_task, class: Task do
    title { 'shine' }
    content { 'shine_content' }
  end
end