class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.references :user, foreign_key: true 
      t.references :item, foreign_key: true 

      t.timestamps
    end
  end
end
