class Story < ActiveRecord::Base
  has_many :story_elements
  has_many :atoms, :through => :story_elements, :source => :element, :source_type => 'Atom'
  has_many :quotes, :through => :story_elements, :source => :element, :source_type => 'Quote'
  has_many :headlines
  has_many :leadlines

  has_and_belongs_to_many :similar_stories, class_name: "Story", foreign_key: "story_id", association_foreign_key: "similar_story_id", join_table: "similar_stories"
  
  has_many :related_elements

  acts_as_taggable_on :themes

  belongs_to :section
end