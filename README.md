

## ** users テーブル（ユーザー情報）**

| Column             | Type    | Options                   |
|--------------------|--------|---------------------------|
| nickname          | string  | null: false              |
| email             | string  | null: false, unique: true |
| encrypted_password | string  | null: false              |

### **アソシエーション**
- has_many :items
- has_many :purchase_logs

---

## ** items テーブル（商品情報）**

| Column            | Type      | Options                        |
|-------------------|-----------|--------------------------------|
| name             | string     | null: false                   |
| description      | text       | null: false                   |
| category_id      | integer    | null: false                   |
| condition_id     | integer    | null: false                   |
| shipping_fee_id  | integer    | null: false                   |
| prefecture_id    | integer    | null: false                   |
| scheduled_id     | integer    | null: false                   |
| price            | integer    | null: false                   |
| user            | references | null: false, foreign_key: true |

### **アソシエーション**
- belongs_to :user
- has_one :purchase_log

---

## ** purchase_logs テーブル（購入履歴）
**

| Column        | Type       | Options                        |
|--------------|-----------|--------------------------------|
| user         | references | null: false, foreign_key: true |
| item         | references | null: false, foreign_key: true |


### **アソシエーション**
- belongs_to :user
- belongs_to :item
- has_one :shipping_address

## **shipping_addresses テーブル（配送情報）**

| Column        | Type       | Options                        |
|--------------|-----------|--------------------------------|
| purchase_log_id        | references | null: false, foreign_key: true |
| postal_code        | string | null: false,  |
| prefecture_id  | integer     | null: false                   |
| city         | string     | null: false                   |
| address      | string     | null: false                   |
| building     | string     |                                |
| phone_number | string     | null: false                   |

### **アソシエーション**
- belongs_to :purchase_log