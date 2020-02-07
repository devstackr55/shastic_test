require 'active_record'

class CreateVisitsTable < ActiveRecord::Migration[5.2]
  def up
    return if ActiveRecord::Base.connection.table_exists?(:visits)

    create_table :visits do |t|
      t.string :evid
      t.string :vendor_site_id
      t.string :vendor_visit_id
      t.string :visit_ip
      t.string :vendor_visitor_id

      t.timestamps
    end
  end

  def down
    return unless ActiveRecord::Base.connection.table_exists?(:visits)

    drop_table :visits
  end
end
