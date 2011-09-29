class StadiaController < ApplicationController
  # GET /stadia
  # GET /stadia.json

  def index
    @name = params[:name]
    @country = params[:country]
    @stadia = Stadium.filter({:name => @name, :country => @country})
  
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @stadia }
    end
  end

  # GET /stadia/1
  # GET /stadia/1.json
  def show
    @stadium = Stadium.find(params[:id])
    @matches = @stadium.matches.uniq
    @cups = @stadium.cups.uniq

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @stadium }
    end
  end

  # GET /stadia/new
  # GET /stadia/new.json
  def new
    @stadium = Stadium.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @stadium }
    end
  end

  # GET /stadia/1/edit
  def edit
    @stadium = Stadium.find(params[:id])
  end

  # POST /stadia
  # POST /stadia.json
  def create
    @stadium = Stadium.new(params[:stadium])

    respond_to do |format|
      if @stadium.save
        format.html { redirect_to @stadium, :notice => 'Stadium was successfully created.' }
        format.json { render :json => @stadium, :status => :created, :location => @stadium }
      else
        format.html { render :action => "new" }
        format.json { render :json => @stadium.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /stadia/1
  # PUT /stadia/1.json
  def update
    @stadium = Stadium.find(params[:id])

    respond_to do |format|
      if @stadium.update_attributes(params[:stadium])
        format.html { redirect_to @stadium, :notice => 'Stadium was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @stadium.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /stadia/1
  # DELETE /stadia/1.json
  def destroy
    @stadium = Stadium.find(params[:id])
    @stadium.destroy

    respond_to do |format|
      format.html { redirect_to stadia_url }
      format.json { head :ok }
    end
  end

end
