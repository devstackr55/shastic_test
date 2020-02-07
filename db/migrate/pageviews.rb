require 'active_record'

class CreatePageviewsTable < ActiveRecord::Migration[5.2]
  def up
    return if ActiveRecord::Base.connection.table_exists?(:pageviews)

    create_table :pageviews do |t|
      t.references :visit, null: false, foreign_key: true
      t.string :title
      t.string :position
      t.text :url
      t.string :time_spent
      t.decimal :timestamp, precision: 14, scale: 3

      t.timestamps
    end
  end

  def down
    return unless ActiveRecord::Base.connection.table_exists?(:pageviews)

    drop_table :pageviews
  end
end
