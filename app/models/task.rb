class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  validates :due_date, presence: true
  validates :status, presence: true
  validates :priority, presence: true

  # enumを使えば、数字を意味のある文字として扱える。DBには割り当てられた整数が保存される。
  enum status: { 未着手: 0, 着手中: 1, 完了: 2 }
  enum priority: { 低: 0, 中: 1, 高: 2 }
end
