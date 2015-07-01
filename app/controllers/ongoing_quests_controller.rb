class OngoingQuestsController < ApplicationController
  before_action :set_ongoing_quest, only: [:show, :edit, :update, :destroy]

  # GET /ongoing_quests
  # GET /ongoing_quests.json
  def index
    @ongoing_quests = OngoingQuest.all
  end

  # GET /ongoing_quests/1
  # GET /ongoing_quests/1.json
  def show
  end

  # GET /ongoing_quests/new
  def new
    @ongoing_quest = OngoingQuest.new
  end

  # GET /ongoing_quests/1/edit
  def edit
  end

  # POST /ongoing_quests
  # POST /ongoing_quests.json
  def create
    @ongoing_quest = OngoingQuest.new(ongoing_quest_params)

    respond_to do |format|
      if @ongoing_quest.save
        format.html { redirect_to @ongoing_quest, notice: 'Ongoing quest was successfully created.' }
        format.json { render :show, status: :created, location: @ongoing_quest }
      else
        format.html { render :new }
        format.json { render json: @ongoing_quest.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ongoing_quests/1
  # PATCH/PUT /ongoing_quests/1.json
  def update
    respond_to do |format|
      if @ongoing_quest.update(ongoing_quest_params)
        format.html { redirect_to @ongoing_quest, notice: 'Ongoing quest was successfully updated.' }
        format.json { render :show, status: :ok, location: @ongoing_quest }
      else
        format.html { render :edit }
        format.json { render json: @ongoing_quest.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ongoing_quests/1
  # DELETE /ongoing_quests/1.json
  def destroy
    source = @ongoing_quest.quest.source
    source.events.create(raw_exp: @ongoing_quest.bounty, language_id: @ongoing_quest.language_id)  
    @ongoing_quest.destroy
    respond_to do |format|
      format.html { redirect_to ongoing_quests_url, notice: 'Ongoing quest was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ongoing_quest
      @ongoing_quest = OngoingQuest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ongoing_quest_params
      params.require(:ongoing_quest).permit(:quest_id, :user_id)
    end
end
