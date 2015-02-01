class LeadlinesController < ApplicationController
  before_action :set_leadline, only: [:edit, :update, :destroy]

  def edit
  end

  def update
    old_leadline = @leadline.leadline
    @leadline.leadline = params[:leadline]
    message = "Leadline was successfully updated.\n CHANGED FROM: " + old_leadline.to_s + "\nTO: " + params[:leadline].to_s 
    
    respond_to do |format|
      if @leadline.save
        format.html { redirect_to edit_story_url(params[:story_id]), notice: message }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /stories/1
  # DELETE /stories/1.json
  def destroy
    @leadline.destroy
    respond_to do |format|
      format.html { redirect_to stories_url, notice: 'Story was successfully destroyed.' }
      format.json { lead :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_leadline
      @leadline = Leadline.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def leadline_params
      params[:leadline].permit(:leadline)
    end
  
    def story_params
      params[:story]
    end
end
