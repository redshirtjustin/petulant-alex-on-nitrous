class CreateAtoms < ActiveRecord::Migration
  def change
    create_table :atoms do |t|
      t.string :topic
      t.text :content

      t.timestamps
    end
  end
end
