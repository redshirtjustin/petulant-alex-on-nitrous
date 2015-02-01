class StoryElement < ActiveRecord::Base
  belongs_to :story
  belongs_to :element, :polymorphic => true
  belongs_to :atom, class_name: "Atom", foreign_key: "story_element_id"
  belongs_to :quote, class_name: "Quote", foreign_key: "story_element_id"
  has_many :related_elements
end