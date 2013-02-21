class LinkTopicsToUsers < ActiveRecord::Migration
  def change
    add_column :topics, :submitter_id, :integer
    add_column :topics, :speaker_id, :integer
  end

end
