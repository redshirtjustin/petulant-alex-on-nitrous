class LeadlinesController < ApplicationController
  before_action :set_leadline, only: [:edit, :update, :destroy]

  def edit
  end
  
  def create
    @leadline = Leadline.new(leadline: params[:leadline], story_id: params[:story_id])
    story = Story.find(params[:story_id])   
    
    respond_to do |format|
      if @leadline.save
        story.active_leadline_id = @leadline.id
        if story.save
          format.html { redirect_to edit_story_url(params[:story_id]), notice: 'Leadline successfully created and made active.' }
        else
          format.html { redirect_to edit_story_url(params[:story_id]), notice: 'Leadline successfully created but not active.' }
        end
      else
        format.html { render :edit }
      end
    end
  end

  def update
    message = "Leadline was successfully updated. CHANGED FROM: " + @leadline.leadline + " TO: " + params[:leadline]
    @leadline.leadline = params[:leadline]
    
    respond_to do |format|
      if @leadline.save
        format.html { redirect_to edit_story_url(params[:story_id]), notice: message }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    message = "Leadline: " + @leadline.leadline.upcase + " was successfully deleted."
    
    @leadline.destroy
    
    respond_to do |format|
      format.html { redirect_to edit_story_url( params[:story_id] ), notice: message }
    end
  end
  
  def make_leadline_active    
    story = Story.find(params[:story_id])
    story.active_leadline_id = params[:id]
    leadline = Leadline.find(params[:id]).leadline
    message = leadline.upcase + " is now the active leadline."
    
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
