class CreateHeadlines < ActiveRecord::Migration
  def change
    create_table :headlines do |t|
      t.string :headline
      t.belongs_to :story, index: true

      t.timestamps
    end
  end
end
