class Story < ActiveRecord::Base
  has_many :story_elements
  has_many :atoms, :through => :story_elements, :source => :element, :source_type => 'Atom'
  has_many :quotes, :through => :story_elements, :source => :element, :source_type => 'Quote'
  has_many :headlines
  has_many :leadlines
  has_many :atom_citations, :through => :atoms, :source => :citations 
  has_many :quote_citations, :through => :quotes, :source => :citations
  has_and_belongs_to_many :similar_stories, class_name: "Story", foreign_key: "story_id", association_foreign_key: "similar_story_id", join_table: "similar_stories"  
  has_many :related_elements
  acts_as_taggable_on :themes
  belongs_to :section
end

# Returns an array Atoms and Quotes associated with this Story
def get_all_elements
  self.atoms + self.quotes
end

# Returns and array of Citations of all associated elements
def get_all_citations 
  self.atom_citations + self.quote_citations
end

# Returns the active Headline line
def get_active_headline  
  if Headline.exists?(self.active_headline_id)  
    self.headlines.find(self.active_headline_id).headline
  else
    false
  end
end

# Returns the active Leadline line
def get_active_leadline  
  if Leadline.exists?(self.active_leadline_id)
    self.leadlines.find(self.active_leadline_id).leadline
  else
    false
  end
end

# Returns the title of the associated Section
def filed_under?
  self.section.title
end


# Story elements helper functions.
# The story_elements is much like an array.
# And array we'll call the position stack.
# Starts from 1 on, 1 being the top,
#
# manipulators: pop, insert, push, append, replace,
# make_consistent
# utilities: consistent?

# pop - pop off the last position in the stack
def pop
end

# insert - insert position somewhere in the stack, and move all subsequent positions down one
def insert
end

# push - move down all positions and put a new position at the beginning
def push
end

# append - add a position at the end of the stack
def append
end

# replace - put a new element into a position without disturbing any other position
def replace
end

# consistent? - are there numerical gaps in the order of positions, 1, 2, 4, 5, 10, returns true|false
def consistent?
  stack = self.story_elements
  key = stack.sum(:position)
  len = stack.length 
  
    if len % 2 == 0 # even len
      checksum = (len / 2) * (1 + len)
    else
      checksum = ((len / 2) + 1) * len
    end 

    if checksum == key
      return true
    else
      return false
    end
end

# make_consistent - slide up every position, 1, 2, 4, 5, 10 => 1, 2, 3, 4, 5
def make_consistent
  if !self.consistent?
      stack = self.story_elements.order(position: :asc)
      order = 1    
      stack.each do |s|
        pos = StoryElement.find(s.id)
        pos.position = order
        pos.save
        order += 1
      end
    return true
  else 
    return true
  end  
end

public :all_elements, :all_citations, :active_headline, :active_leadline, :filed_under, :pop, :insert, :push, :append, :replace, :consistent?, :make_consistent