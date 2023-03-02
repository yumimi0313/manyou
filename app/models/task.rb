class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  validates :due_date, presence: true
  validates :status, presence: true
  validates :priority, presence: true
  belongs_to :user
  has_many :labellings, dependent: :destroy
  has_many :labels, through: :labellings
  accepts_nested_attributes_for :labels, allow_destroy: true
  
  #scope、クラスメソッド（モデルクラスに対して働きかけるメソッド）のように呼び出せる
  scope :created_at_sort, -> { order(created_at: :desc) }
  scope :due_date_sort, -> { order(due_date: :desc) }
  scope :priority_sort, -> { order(priority: :desc) }
  scope :title_search, -> (title) { where("title LIKE ?", "%#{ title }%") }
  scope :status_search, -> (status) { where(status: status) }
  scope :title_status_search, -> (title, status) { where("title LIKE ?", "%#{ title }%").where(status: status) }

  # enumを使えば、数字を意味のある文字として扱える。DBには割り当てられた整数が保存される。
  enum status: { 未着手: 0, 着手中: 1, 完了: 2 }
  enum priority: { 低: 0, 中: 1, 高: 2 }
end
