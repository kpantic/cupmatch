class CupWinnersController < ApplicationController

  # GET /cup_winners
  # GET /cup_winners.json
  def index
    @cup_winners = CupWinner.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @cup_winners }
    end
  end

  # GET /cup_winners/1
  # GET /cup_winners/1.json
  def show
    @cup_winner = CupWinner.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @cup_winner }
    end
  end

  # GET /cup_winners/new
  # GET /cup_winners/new.json
  def new
    @cup_winner = CupWinner.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @cup_winner }
    end
  end

  # GET /cup_winners/1/edit
  def edit
    @cup_winner = CupWinner.find(params[:id])
  end

  # POST /cup_winners
  # POST /cup_winners.json
  def create
    @cup_winner = CupWinner.new(params[:cup_winner])

    respond_to do |format|
      if @cup_winner.save
        format.html { redirect_to @cup_winner.cup, :notice => 'Cup winner was successfully created.' }
        format.json { render :json => @cup_winner, :status => :created, :location => @cup_winner }
      else
        format.html { render :action => "new" }
        format.json { render :json => @cup_winner.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /cup_winners/1
  # PUT /cup_winners/1.json
  def update
    @cup_winner = CupWinner.find(params[:id])

    respond_to do |format|
      if @cup_winner.update_attributes(params[:cup_winner])
        format.html { redirect_to @cup_winner.cup, :notice => 'Cup winner was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @cup_winner.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /cup_winners/1
  # DELETE /cup_winners/1.json
  def destroy
    @cup_winner = CupWinner.find(params[:id])
    @cup_winner.destroy

    respond_to do |format|
      format.html { redirect_to cup_winners_url }
      format.json { head :ok }
    end
  end
end
