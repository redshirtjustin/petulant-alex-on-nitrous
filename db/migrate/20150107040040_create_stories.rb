class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.string :subject
      t.string :mast_url
      t.string :thumb_url
      t.integer :active_headline_id
      t.integer :active_leadline_id
      
      t.belongs_to :section

      t.timestamps
    end
  end
end
