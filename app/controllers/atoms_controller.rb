class AtomsController < ApplicationController

  def create 
    @atom = Atom.new
    story = Story.find(params[:story_id])
    message = "Content was successfully added and set to position 1. All other positions have been incremented to one lower position."
    
    @atom.topic = params[:contentTopic]
    @atom.content = params[:contentContent]
    @atom.theme_list = params[:contentThemeTags]
    @atom.context_list = params[:contentContextTags]
    @atom.save
    
    story.story_elements.order(position: :asc) do |story_ele|
      pos = StoryElement.find(story_ele.id)
      pos.position += 1
      pos.save
    end
    
    story.story_elements.create(element_id: @atom.id, element_type: @atom.class.to_s, position: 1, active: true)
    
    respond_to do |format|
      if @atom.save
        format.html { redirect_to edit_story_url(params[:story_id]), notice: message }
      else
        format.html { render :edit }
      end
    end    
  end  
  
    def update
    message = "Atom was successfully updated."
    @atom = Atom.find(params[:element_id])
    
    @atom.topic = params[:contentEditTopic]
    @atom.content = params[:contentEditContent]
    @atom.theme_list = params[:contentEditThemeTags]
    @atom.context_list = params[:contentEditContextTags]
        
    respond_to do |format|
      if @atom.save
        format.html { redirect_to edit_story_url(params[:story_id]), notice: message }
      else
        format.html { render :edit }
      end
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
  def set_atom
    @atom = Atom.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
  def atom_params
    params[:atom].permit(:atom)
   end
end
