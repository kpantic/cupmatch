class MatchesController < ApplicationController
  before_filter :authenticate_user!, :except => [:index,:show]

  # GET /matches
  # GET /matches.json
  def index
    @cup = params[:cup]
    @stadium = params[:stadium]
    @home_team = params[:home_team]
    @away_team = params[:away_team]
    @from_date = Date.strptime("{#{params[:from_date][:month]}, #{params[:from_date][:day]}, #{params[:from_date][:year]}}","{%m, %d, %Y}") unless params[:from_date].blank? || params[:from_date][:month].blank? || params[:from_date][:day].blank? || params[:from_date][:year].blank?
    @to_date = Date.strptime("{#{params[:to_date][:month]}, #{params[:to_date][:day]}, #{params[:to_date][:year]}}","{%m, %d, %Y}") unless params[:to_date].blank? || params[:to_date][:month].blank? || params[:to_date][:day].blank? || params[:to_date][:year].blank?

    @matches = Match.filter({:away_team_id => @away_team, 
                              :home_team_id => @home_team, 
                              :stadium_id => @stadium,
                              :cup_id => @cup,
                              :from_date => @from_date, 
                              :to_date => @to_date})

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @matches }
    end
  end

  # GET /matches/1
  # GET /matches/1.json
  def show
    @match = Match.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @match }
    end
  end

  # GET /matches/new
  # GET /matches/new.json
  def new
    @match = Match.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @match }
    end
  end

  # GET /matches/1/edit
  def edit
    @match = Match.find(params[:id])
  end

  # POST /matches
  # POST /matches.json
  def create
    @match = Match.new(params[:match])

    respond_to do |format|
      if @match.save
        format.html { redirect_to matches_url, :notice => 'Match was successfully created.' }
        format.json { render :json => @match, :status => :created, :location => @match }
      else
        format.html { render :action => "new" }
        format.json { render :json => @match.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /matches/1
  # PUT /matches/1.json
  def update
    @match = Match.find(params[:id])

    respond_to do |format|
      if @match.update_attributes(params[:match])
        format.html { redirect_to matches_url, :notice => 'Match was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @match.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /matches/1
  # DELETE /matches/1.json
  def destroy
    @match = Match.find(params[:id])
    @match.destroy

    respond_to do |format|
      format.html { redirect_to matches_url }
      format.json { head :ok }
    end
  end
end
