# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Atom.delete_all
Citation.delete_all
Headline.delete_all
Leadline.delete_all
Quote.delete_all
RelatedElement.delete_all
Section.delete_all
SimilarStory.delete_all
StoryElement.delete_all

total_stories = 50
total_atoms = 250
total_quotes = 100

# Seed the sections table
sec1 = Section.create!(title: 'Business & Economics')
sec2 = Section.create!(title: 'Government & Politics')
sec3 = Section.create!(title: 'Sports')
sec4 = Section.create!(title: 'Science')
sec5 = Section.create!(title: 'Environment')
sec6 = Section.create!(title: 'Arts & Entertainment')

# mass populate Stories through iteration
1.upto(total_stories) do |s|
  rand_sec_num = SecureRandom.random_number(6) + 1
  story = Story.create(subject: "#{Section.find(rand_sec_num).title}, Story ##{s}", mast_url: "image1.jpg", thumb_url: "image1_thb.jpg", section_id: rand_sec_num)
end

# mass populate Atoms through iteration
1.upto(total_atoms) do |a|
  lorem_length = SecureRandom.random_number(10) + 4
  atom = Atom.create(topic: "Atom Topic ##{a}, #{Faker::Lorem.sentence(3)}", content: Faker::Lorem.paragraph(1, false, lorem_length))
end

# mass populate Quotes through iteration
1.upto(total_quotes) do |q|
  lorem_length = SecureRandom.random_number(10) + 4
  quote = Quote.create(topic: "Quote Topic ##{q}", content: Faker::Lorem.paragraph(1, false, lorem_length), quote: Faker::Lorem.paragraph(1, false, lorem_length), quoted_line: Faker::Name.name, quoted_subline: Faker::Name.title)
end

# make story elements associations
1.upto(total_stories) do |s|
  rand_num_stels = SecureRandom.random_number(12) + 1
  track_at = []
  track_qt = []
      1.upto(rand_num_stels) do |c|
      	if (SecureRandom.random_number(3) < 2)
	        rand_atom_id = SecureRandom.random_number(total_atoms) + 1
	        
	        until !(track_at.include?(rand_atom_id))
	          rand_atom_id = SecureRandom.random_number(total_atoms) + 1
	        end

	        track_at << rand_atom_id
	        stel = StoryElement.create(story_id: s, element_id: rand_atom_id, element_type: "Atom", active: true, position: c)

	        if (SecureRandom.random_number(10) < 1)
	        	rand_story_id = SecureRandom.random_number(total_stories) + 1
	        	relel = RelatedElement.create(story_element_id: rand_atom_id, story_id: s, call_line: 'Related Story', short_line: 'Short line')
	        end
	    else
	        rand_quote_id = SecureRandom.random_number(total_quotes) + 1
	        
	        until !(track_qt.include?(rand_quote_id))
	          rand_quote_id = SecureRandom.random_number(total_quotes) + 1
	        end

	        track_qt << rand_quote_id
	        stel = StoryElement.create(story_id: s, element_id: rand_quote_id, element_type: "Quote", active: true, position: c)

	        if (SecureRandom.random_number(10) < 1)
	        	rand_story_id = SecureRandom.random_number(total_stories) + 1
	        	relel = RelatedElement.create(story_element_id: rand_quote_id, story_id: s, call_line: 'Related Story', short_line: 'Short line')
	        end
    	end
      end
end

# seed headlines and leadlines, also make last headline leadline for each atom active
1.upto(total_stories) do |s|
  rand_num_headlines = SecureRandom.random_number(3) + 1
  rand_num_leadlines = SecureRandom.random_number(2) + 1

  1.upto(rand_num_headlines) do |hl|
    headline = Headline.create(headline: Faker::Lorem.sentence(10), story_id: s)
    if hl == rand_num_headlines
      story = Story.find(s)
      story.active_headline_id = hl
      story.save
    end
  end

  1.upto(rand_num_leadlines) do |ll|
    leadline = Leadline.create(leadline: Faker::Lorem.sentence(10), story_id: s)
    if ll = rand_num_leadlines
      story = Story.find(s)
      story.active_leadline_id = ll
      story.save
    end
  end
end

# seed citations
1.upto(total_atoms) do |atom|
  rand_num_citations = SecureRandom.random_number(3) + 1
  1.upto(rand_num_citations) do |cit|
    citation = Citation.create(cite_id: atom, cite_type: "Atom", title: Faker::Lorem::sentence(10), url: Faker::Internet::url)
  end
end

1.upto(total_quotes) do |quote|
  rand_num_citations = SecureRandom.random_number(3) + 1
  1.upto(rand_num_citations) do |cit|
    citation = Citation.create(cite_id: quote, cite_type: "Quote", title: Faker::Lorem::sentence(10), url: Faker::Internet::url)

  end
end