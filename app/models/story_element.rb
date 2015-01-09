class StoryElement < ActiveRecord::Base
  belongs_to :story
  belongs_to :element, :polymorphic => true

  has_many :related_elements
end
