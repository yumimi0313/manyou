# 「FactoryBotを使用します」という記述
FactoryBot.define do
  # 作成するテストデータの名前を「task」とします
  # （実際に存在するクラス名と一致するテストデータの名前をつければ、そのクラスのテストデータを自動で作成します）
  factory :task do
    title { 'test' }
    content { 'test_content' }
  end

  factory :second_task, class: Task do
    title { 'new' }
    content { 'new_content' }
  end

    factory :third_task, class: Task do
    title { 'shine' }
    content { 'shine_content' }
  end
end