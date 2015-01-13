class NewsController < ApplicationController
  before_action :set_news, only: [:show, :edit, :update, :destroy]

  # GET /news
  # GET /news.json
  def index
    @news = Story.all
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
