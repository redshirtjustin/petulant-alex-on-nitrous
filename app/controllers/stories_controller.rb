class StoriesController < ApplicationController
  before_action :set_story, only: [:show, :edit, :update, :destroy]
  layout "authoring"

  # GET /stories
  # GET /stories.json
  def index
    @stories = Story.all
  end

  # GET /stories/1
  # GET /stories/1.json
  def show
  end

  # GET /stories/new
  def new
    @story = Story.new
    @sections = Section.all
  end

  # GET /stories/1/edit
  def edit
    @story_content = @story.get_all_elements
    @sections = Section.all
  end

  # POST /stories
  # POST /stories.json
  def create
    @story = Story.new()
    @story.section_id = params[:story][:section]
    @story.subject = params[:subject]
    # @story.mast_url = ""
    # @story.thumb_url = ""
    
    if !params[:theme_tags].empty?
        input = params[:theme_tags]
        input = input.gsub('"', '')
        input.slice!(0)
        input = input.chop
      @story.theme_list.add(input, parse: true)
    end
      
    respond_to do |format|
      if @story.save
        hl = @story.headlines.create(headline: params[:headline], story_id: @story.id)
        ll = @story.leadlines.create(leadline: params[:leadline], story_id: @story.id)
        @story.active_headline_id = hl.id
        @story.active_leadline_id = ll.id
        @story.save
        # Need to add theme tags       
        format.html { redirect_to @story, notice: 'Story was successfully created.' }
        format.json { render :show, status: :created, location: @story }
      else
        format.html { render :new }
        format.json { render json: @story.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stories/1
  # PATCH/PUT /stories/1.json
  def update
    @story.subject = params[:storyEditSubject]
    @story.section_id = story_params[:section_id]
    @story.theme_list = params[:storyEditTags]
    
    respond_to do |format|
      if @story.save
        format.html { redirect_to edit_story_url(@story), notice: 'Story was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /stories/1
  # DELETE /stories/1.json
  def destroy
    @story.destroy
    respond_to do |format|
      format.html { redirect_to stories_url, notice: 'Story was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_story
      @story = Story.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def story_params
      params[:story].permit(:subject, :mast_url, :thumb_url, :headline, :leadline, :section_id, :storyEditSubject, :element_id)
    end
end
