class AddDescriptionToExpense < ActiveRecord::Migration
  def change
    add_column :expenses, :description, :text
  end
end
