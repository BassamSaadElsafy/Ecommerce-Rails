class CreateListedItems < ActiveRecord::Migration[5.2]
  def change
    create_table :listed_items do |t|

      t.timestamps
    end
  end
end
