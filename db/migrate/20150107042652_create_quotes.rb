class CreateQuotes < ActiveRecord::Migration
  def change
    create_table :quotes do |t|
      t.string :topic
      t.text :quote
      t.string :quoted_line
      t.string :quoted_subline
 	  t.text :content

      t.timestamps
    end
  end
end
