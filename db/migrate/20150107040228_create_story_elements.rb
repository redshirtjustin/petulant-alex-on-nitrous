class CreateStoryElements < ActiveRecord::Migration
  def change
    create_table :story_elements do |t|
	  t.belongs_to :story
      t.references :element, polymorphic: true, index: true
      t.integer :position
      t.boolean :active
      
      t.timestamps
    end
  end
end
