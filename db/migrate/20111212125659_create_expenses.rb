class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
      t.decimal :value, :precision =>8, :scale => 2
      t.date :date

      t.timestamps
    end
  end
end
