class CreateLogEntries < ActiveRecord::Migration[5.2]
  def change
    create_table :log_entries do |t|
      t.date :date
      t.integer :volume
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
