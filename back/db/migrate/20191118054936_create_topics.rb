# frozen_string_literal: true

class CreateTopics < ActiveRecord::Migration[5.2]
  def change
    create_table :topics do |t|
      t.string :shop_name, null: false
      t.string :date, null: false
      t.string :meals, null: false
      t.string :price, null: false
      t.string :review, null: false
      t.integer :rating, null: false
      t.string :image, null: false
      t.references :user, foreign_key: true, null: false
      t.timestamps
    end
  end
end
