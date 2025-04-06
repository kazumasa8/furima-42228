class OrderForm
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postal_code, :prefecture_id, :city, :address, :building, :phone_number, :token

  validates :user_id, :item_id, :postal_code, :prefecture_id, :city, :address, :phone_number, :token, presence: true
  validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/, message: "must be in the format '123-4567'" }
  validates :phone_number, format: { with: /\A\d{10,11}\z/, message: "must be between 10 and 11 digits" }
  validates :prefecture_id, numericality: { other_than: 1, message: "must be selected" }
  def save
    # 購入記録を保存
    order = Order.create(user_id: user_id, item_id: item_id)

    # 配送先情報を保存
    ShippingAddress.create(
      order_id: order.id, postal_code: postal_code, prefecture_id: prefecture_id,
      city: city, address: address, building: building, phone_number: phone_number
    )
  end

end