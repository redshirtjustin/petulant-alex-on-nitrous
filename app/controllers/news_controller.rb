class NewsController < ApplicationController
  before_action :set_news, only: [:show, :edit, :update, :destroy]

  # GET /news
  # GET /news.json
  def index
    # Create some instance variables to display
    @latest_news_by_sections = {} # Will hold object relations type of each section

    latest = 15 # Display this many stories under each section
    all_sections = Section.all # What sections do we want to look at? All sections.

    # Logic for the index view
    all_sections.each do |s|
      @latest_news_by_sections[s.title] = s.stories.order('updated_at DESC').limit(latest)
    end
  end

  # GET /news/1
  # GET /news/1.json
  def show
    @news_sources = []
    @news.story_elements.order('position DESC').each do |ele|
      if (ele.element_type == "Atom")
        @news_sources << Citation.where("cite_id = :cite_id and cite_type = :cite_type", { cite_id: ele.element_id, cite_type: 'Atom' } ).to_a
      elsif (ele.element_type == "Quote")
        @news_sources << Citation.where("cite_id = :cite_id and cite_type = :cite_type", { cite_id: ele.element_id, cite_type: 'Quote' } ).to_a
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_news
      @news = Story.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def news_params
      params[:news]
    end
end
