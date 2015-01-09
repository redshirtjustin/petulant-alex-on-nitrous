class Quote < ActiveRecord::Base
  has_many :story_elements, :as =>:element
  has_many :stories, :through => :story_elements

  has_many :citations, :as =>:cite

  acts_as_taggable_on :themes, :contexts
end
