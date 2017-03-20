# frozen_string_literal: true
class CreateTweets < ActiveRecord::Migration[5.0]
  def change
    create_table :tweets do |t|
      t.references :user
      t.string :message, limit: 140
      t.string :uri

      t.timestamps
    end
  end
end
