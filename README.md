# テーブル設計

## usersテーブル

| Column               | Type     | Options     |
| -------------------- | -------- | ----------- |
| full_name            | string   | null: false |
| name_kana            | string   | null: false |
| nickname             | string   | null: false |
| email                | string   | null: false |
| birth_date           | date     | null: false |
| encrypted_password   | string   | null: false |

### Association

- has_many :items
- has_many :records


## itemsテーブル

| Column           | Type       | Options                        |
| ---------------- | ---------- | ------------------------------ |
| item_name        | string     | null: false                    |
| description      | text       | null: false                    |
| category         | string     | null: false                    |
| item_status      | string     | null: false                    |
| delivery_charge  | string     | null: false                    |
| delivery_area    | string     | null: false                    |
| delivery_days    | string     | null: false                    |
| price            | integer    | null: false                    |
| user_id          | references | null: false, foreign_key: true |

### Association

- has_one :record
- belongs_to :user


## recordsテーブル

| Column    | Type         | Options                        |
| --------- | ------------ | ------------------------------ |
| user_id   | references   | null: false, foreign_key: true |
| item_id   | references   | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_many :delivery_addresses


## delivery_addressesテーブル

| Column              | Type       | Options                        |
| ------------------- | ---------- | ------------------------------ |
| postal_code         | integer    | null: false                    |
| prefecture          | string     | null: false                    |
| city                | string     | null: false                    |
| block               | string     | null: false                    |
| building            | string     | null: false                    |
| phone_number        | integer    | null: false                    |
| record_id           | references | null: false, foreign_key: true |

### Association

- belongs_to :record



