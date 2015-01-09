class CreateSimilarStories < ActiveRecord::Migration
  def change
    create_table :similar_stories do |t|
      t.integer :story_id
      t.integer :similar_story_id
    end
  end
end
