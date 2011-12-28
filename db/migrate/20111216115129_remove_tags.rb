class RemoveTags < ActiveRecord::Migration
  def up
    drop_table :tags
	  drop_table :expenses_tags
  end

  def down
  end
end
