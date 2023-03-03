class Label < ApplicationRecord
  validates :name, presence: true
  has_many :labellings, dependent: :destroy
  has_many :tasks, dependent: :destroy
  has_many :labelling_tasks, through: :labellings, source: :task

  scope :label_search, -> (label_id) { find_by(id: label_id).labelling_tasks }
end
