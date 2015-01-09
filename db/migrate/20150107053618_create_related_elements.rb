class CreateRelatedElements < ActiveRecord::Migration
  def change
    create_table :related_elements do |t|
      t.integer :story_element_id
      t.integer :story_id
      t.string :call_line
      t.string :short_line
      t.timestamps
    end
  end
end
