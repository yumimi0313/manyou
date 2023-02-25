class AddDuedateToTasks < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :due_date, :date, null: false, defalt: -> { '(CURRENT_DATE + INTERVAL 1 DAY)' }
  end
end
