class CreateLeadlines < ActiveRecord::Migration
  def change
    create_table :leadlines do |t|
      t.string :leadline
      t.belongs_to :story, index: true

      t.timestamps
    end
  end
end