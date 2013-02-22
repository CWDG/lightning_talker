class CreateAnalyticsEvents < ActiveRecord::Migration
  def change
    create_table :analytics_events do |t|
      t.string :name
      t.string :user
      t.string :url
      t.integer :count

      t.timestamps
    end
    add_index :analytics_events, [:name, :user, :url]
  end
end
