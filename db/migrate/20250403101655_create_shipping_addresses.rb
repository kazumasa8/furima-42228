class CreateShippingAddresses < ActiveRecord::Migration[7.1]
  def change
    create_table :shipping_addresses do |t|

      t.references :order, foreign_key: true  # 購入記録（Orderモデルと関連）
      t.string :postal_code, null: false      # 郵便番号
      t.integer :prefecture_id, null: false   # 都道府県（ActiveHash用）
      t.string :city, null: false             # 市区町村
      t.string :address, null: false          # 番地
      t.string :building                      # 建物名（任意）
      t.string :phone_number, null: false     # 電話番号

      t.timestamps
    end
  end
end
