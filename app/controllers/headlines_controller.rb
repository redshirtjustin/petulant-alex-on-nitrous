class HeadlinesController < ApplicationController
  before_action :set_headline, only: [:edit, :update, :destroy]

  def edit
  end

  def update
    old_headline = @headline.headline
    @headline.headline = params[:headline]
    message = "Headline was successfully updated. CHANGED FROM: " + old_headline.to_s + " TO: " + params[:headline].to_s 
    
    respond_to do |format|
      if @headline.save
        format.html { redirect_to edit_story_url(params[:story_id]), notice: message }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /stories/1
  # DELETE /stories/1.json
  def destroy
    @headline.destroy
    respond_to do |format|
      format.html { redirect_to stories_url, notice: 'Story was successfully destroyed.' }
      format.json { head :no_content }
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
