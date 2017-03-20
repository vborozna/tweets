# frozen_string_literal: true
class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :provider
      t.string :uid
      t.string :name
      t.string :oauth_token
      t.string :oauth_secret

      t.datetime :remember_created_at

      t.timestamps
    end

    add_index :users, [:provider, :uid], unique: true
    add_index :users, [:uid, :provider], unique: true
  end
end
