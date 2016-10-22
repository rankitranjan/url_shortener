class CreateShortUrls < ActiveRecord::Migration
  def change
    create_table :short_urls do |t|
      t.string :original_url
      t.string :shorty
      t.integer :visits_count, default: 0
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
