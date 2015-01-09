class SimilarStory < ActiveRecord::Base
	belongs_to :story
	belongs_to :similar_story, class_name: 'Story'
end
