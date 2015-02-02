class HeadlinesController < ApplicationController
  before_action :set_headline, only: [:edit, :update, :destroy]

  def edit
  end
  
  def create
    @headline = Headline.new(headline: params[:headline], story_id: params[:story_id])
    story = Story.find(params[:story_id])   
    
    respond_to do |format|
      if @headline.save
        story.active_headline_id = @headline.id
        if story.save
          format.html { redirect_to edit_story_url(params[:story_id]), notice: 'Headline successfully created and made active.' }
        else
          format.html { redirect_to edit_story_url(params[:story_id]), notice: 'Headline successfully created but not active.' }
        end
      else
        format.html { render :edit }
      end
    end
  end

  def update
    message = "Headline was successfully updated. CHANGED FROM: " + @headline.headline + " TO: " + params[:headline]
    @headline.headline = params[:headline]
    
    respond_to do |format|
      if @headline.save
        format.html { redirect_to edit_story_url(params[:story_id]), notice: message }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    message = "Headline: " + @headline.headline.upcase + " was successfully deleted."
    
    @headline.destroy
    
    respond_to do |format|
      format.html { redirect_to edit_story_url( params[:story_id] ), notice: message }
    end
  end
  
  def make_headline_active    
    story = Story.find(params[:story_id])
    story.active_headline_id = params[:id]
    headline = Headline.find(params[:id]).headline
    message = headline.upcase + " is now the active headline."
    
    respond_to do |format|
      if story.save
        format.html { redirect_to edit_story_url(params[:story_id]), notice: message }
      else
        format.html { render :edit }
      end
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
  def set_headline
      @headline = Headline.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
  def headline_params
      params[:headline].permit(:headline)
    end
  
  def story_params
      params[:story]
    end
end
