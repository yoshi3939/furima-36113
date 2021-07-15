# テーブル設計

## usersテーブル

| Column               | Type     | Options      |
| -------------------- | -------- | ------------ |
| last_name            | string   | null: false  |
| first_name           | string   | null: false  | 
| last_name_kana       | string   | null: false  |
| first_name_kana      | string   | null: false  |
| nickname             | string   | null: false  |
| email                | string   | unique: true |
| birth_date           | date     | null: false  |
| encrypted_password   | string   | null: false  |

### Association

- has_many :items
- has_many :records


## itemsテーブル

| Column             | Type       | Options           |
| ------------------ | ---------- | ----------------- |
| name               | string     | null: false       |
| description        | text       | null: false       |
| category_id        | integer    | null: false       |
| item_status_id     | integer    | null: false       |
| delivery_charge_id | integer    | null: false       |
| prefecture_id      | integer    | null: false       |
| delivery_days_id   | integer    | null: false       |
| price              | integer    | null: false       |
| user               | references | foreign_key: true |

### Association

- has_one :record
- belongs_to :user


## recordsテーブル

| Column | Type         | Options           |
| ------ | ------------ | ----------------- |
| user   | references   | foreign_key: true |
| item   | references   | foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :delivery_address


## delivery_addressesテーブル

| Column              | Type       | Options           |
| ------------------- | ---------- | ----------------- |
| postal_code         | string     | null: false       |
| prefecture_id       | integer    | null: false       |
| city                | string     | null: false       |
| house_number        | string     | null: false       |
| building_name       | string     |                   |
| phone_number        | string     | null: false       |
| record              | references | foreign_key: true |

### Association

- belongs_to :record



