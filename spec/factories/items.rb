FactoryBot.define do
  factory :item do
    name { 'テスト商品' }
    description { 'これはテスト商品の説明です' }
    price { 1000 }
    category_id { 2 }
    condition_id { 2 }
    shipping_fee_id { 2 }
    prefecture_id { 2 }
    scheduled_id { 2 }

    association :user # ユーザーとの関連付け

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
