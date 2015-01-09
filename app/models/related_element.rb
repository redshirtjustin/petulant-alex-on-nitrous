class RelatedElement < ActiveRecord::Base
  belongs_to :story
  belongs_to :story_element
end
