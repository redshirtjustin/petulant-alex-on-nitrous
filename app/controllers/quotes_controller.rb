class QuotesController < ApplicationController
  
  def create 
    @quote = Quote.new
    story = Story.find(params[:story_id])
    message = "Quote was successfully added and set to position 1. All other positions have been incremented to one lower position."
    
    @quote.topic = params[:quoteTopic]
    @quote.quote = params[:quoteQuote]
    @quote.quoted_line = params[:quoteQuoted]
    @quote.quoted_subline = params[:quoteQuotedSubline]
    @quote.content = params[:quoteContent]
    @quote.theme_list = params[:quoteThemeTags]
    @quote.context_list = params[:quoteContextTags]
    @quote.save
    
    story.story_elements.order(position: :asc) do |story_ele|
      pos = StoryElement.find(story_ele.id)
      pos.position += 1
      pos.save
    end
    
    story.story_elements.create(element_id: @quote.id, element_type: @quote.class.to_s, position: 1, active: true)
    
    respond_to do |format|
      if @quote.save
        format.html { redirect_to edit_story_url(params[:story_id]), notice: message }
      else
        format.html { render :edit }
      end
    end    
  end
  
  def update
    message = "Quote was successfully updated."
    @quote = Quote.find(params[:element_id])
    
    @quote.topic = params[:quoteEditTopic]
    @quote.quote = params[:quoteEditQuote]
    @quote.quoted_line = params[:quoteEditQuoted]
    @quote.quoted_subline = params[:quoteEditQuotedSubline]
    @quote.content = params[:quoteEditContent]
    @quote.theme_list = params[:quoteEditThemeTags]
    @quote.context_list = params[:quoteEditContextTags]
        
    respond_to do |format|
      if @quote.save
        format.html { redirect_to edit_story_url(params[:story_id]), notice: message }
      else
        format.html { render :edit }
      end
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
  def set_quote
    @quote = Quote.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
  def quote_params
    params[:quote].permit(:quote)
   end
end
