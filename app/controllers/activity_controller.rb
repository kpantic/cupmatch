class ActivityController < ApplicationController
  def index
    @recent_activity = Activity.recent_activity

    respond_to do |format|
      format.json { render :json => @recent_activity }
    end
  end
end
