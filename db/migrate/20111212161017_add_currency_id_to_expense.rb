class AddCurrencyIdToExpense < ActiveRecord::Migration
  def change
    add_column :expenses, :currency_id, :integer
  end
end
