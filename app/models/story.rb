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
def all_elements
  self.atoms + self.quotes
end

# Returns and array of Citations of all associated elements
def all_citations 
  self.atom_citations + self.quote_citations
end

# Returns the active Headline line
def active_headline
  self.headlines.find(self.active_headline_id).headline
end

# Returns the active Leadline line
def active_leadline
  self.leadlines.find(self.active_leadline_id).leadline
end

# Returns the title of the associated Section
def filed_under
  self.section.title
end

public :all_elements, :all_citations, :active_headline, :active_leadline, :filed_under