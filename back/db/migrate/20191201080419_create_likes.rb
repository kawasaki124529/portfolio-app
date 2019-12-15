# frozen_string_literal: true

class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.integer :user_id, foreign_key: true
      t.integer :topic_id, foreign_key: true
      t.timestamps
    end
  end
end
