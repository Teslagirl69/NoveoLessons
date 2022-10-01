# frozen_string_literal: true

# Используя 'active_record' гем, без создания самого рейлс приложения,
# реализовать 4 модели с соответствующими таблицами:
#   - User. Атрибуты: username (уникальный и не может быть пустым);
#   - Podcast. Атрибуты: name (уникальный и не может быть пустым),
# type (жанр подкаста, можно придумать несколько доступных жанров, плюсом будет использовать для них enum в модели);
#   - Newspaper. Атрибуты: name (уникальный и не может быть пустым),
# type (тематика газеты, то есть тоже придумать несколько типов, используя enum метод в модели);
#   - Subscription. Связующая таблица между пользователями и газетами/подскастами. Определяющая подписки пользователей.

# Особенность реалиции заключается в том, что с таблицами podcasts, newspapers должна быть связана полиморфной связью.
# На уровне модели будет иметь два belongs_to: belongs_to :user, belongs_to :subscribable, polymorphic: true

# Для реализации подключения в 4-ой задаче использовать Postgresql
require 'active_record'

ActiveRecord::Base.establish_connection(
  adapter: 'postgresql',
  host: 'localhost',
  username: ' ',
  password: ' ',
  database: 'test5'
)

class CreateUserTable < ActiveRecord::Migration[7.0]
  def change
    create_table :users, if_not_exists: true do |table|
      table.string :username, null: false, unique: true
      table.timestamps
      table.boolean :active, null: false, default: true
    end
  end
end

class CreatePodcastTable < ActiveRecord::Migration[7.0]
  def change
    create_table :podcasts, if_not_exists: true do |table|
      table.string :name, null: false, unique: true
      table.string :kind, null: false
      table.timestamps
    end
  end
end

class CreateNewspaperTable < ActiveRecord::Migration[7.0]
  def change
    create_table :newspapers, if_not_exists: true do |table|
      table.string :name, null: false, unique: true
      table.string :kind, null: false
      table.timestamps
    end
  end
end

class CreateSubscriptionTable < ActiveRecord::Migration[7.0]
  def change
    create_table :subscriptions, if_not_exists: true do |table|
      table.integer :user_id
      table.references :subscribable, polymorphic: true
      table.column :status, :integer, default: 0
      table.timestamps
    end
  end
end

CreateUserTable.migrate(:up)
CreatePodcastTable.migrate(:up)
CreateNewspaperTable.migrate(:up)
CreateSubscriptionTable.migrate(:up)

class User < ActiveRecord::Base
  after_update :disable_subscriptions # callback будет вызываться при любом user update
  has_many :subscriptions
  has_many :podcasts, source: :subscribable, through: :subscriptions
  has_many :newspapers, source: :subscribable, through: :subscriptions
  validates :username, presence: true, uniqueness: true
  def disable_subscriptions
    subscriptions.update(status: :disabled)
  end
end

class Podcast < ActiveRecord::Base
  has_many :subscriptions, as: :subscribable
  has_many :users, source: :user, foreign_key: 'user_id', through: :subscriptions
  validates :name, presence: true, uniqueness: true
  enum kind: { Business: 0, Dogs: 1 }
end

class Newspaper < ActiveRecord::Base
  has_many :subscriptions, as: :subscribable
  has_many :users, source: :user, foreign_key: 'user_id', through: :subscriptions
  validates :name, presence: true, uniqueness: true
  enum kind: { Finance: 0, Fashion: 1 }
end

class Subscription < ActiveRecord::Base
  belongs_to :user, foreign_key: 'user_id'
  belongs_to :subscribable, polymorphic: true
  enum status: { active: 0, disabled: 1 }
end

# Потестим модельки наполним данными БД

# User

user1 = User.new(username: 'Blonde')
user1.save!

user2 = User.new(username: 'Businessman')
user2.save!

user3 = User.new(username: 'Hipster')
user3.save!

# Podcast
podcast1 = Podcast.new(name: 'How to groom a yorkshire terrier', kind: 'Dogs')
podcast1.users << User.find_by(username: 'Blonde')
podcast1.users << User.find_by(username: 'Hipster')
podcast1.save

podcast2 = Podcast.new(name: 'The Internet Business Mastery', kind: 'Business')
podcast2.users << User.find_by(username: 'Businessman')
podcast2.save

# Newspaper

newspaper1 = Newspaper.new(name: 'Glamour', kind: 'Fashion')
newspaper1.users << User.find_by(username: 'Blonde')
newspaper1.save

newspaper2 = Newspaper.new(name: 'Forbes', kind: 'Finance')
newspaper2.users << User.find_by(username: 'Businessman')
newspaper2.users << User.find_by(username: 'Blonde')
newspaper2.save

user3.update(active: false)
