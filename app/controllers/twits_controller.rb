class TwitsController < ApplicationController
  before_filter :get_twit, :only => [:show, :voteup, :votedown]

  def index
    @twits = Twit.all( :order => "twitid desc", :limit => "15", :offset => params[:offset] )
    respond_to_twits
  end

  def top_voted
    @twits = Twit.all( :order => "votes desc", :limit => "15", :offset => params[:offset] )
    respond_to_twits
  end

  def top_rated
    @twits = Twit.all( :order => "rating desc", :limit => "15", :offset => params[:offset] )
    respond_to_twits
  end

  def show
  end

  def voteup
    vote(+1)
    @twit.save

    respond_to do |format|
      format.html { redirect_to twit_url(@twit) }
      format.js { render :status => :ok, :text => "{ status: 1 }" }
    end
  end

  def votedown
    vote(-1)
    @twit.save

    respond_to do |format|
      format.html { redirect_to twit_url(@twit) }
      format.js { render :status => :ok, :text => "{ status: 1 }" }
    end
  end

  def random
    count = Twit.count
    @twit = Twit.first(:offset => count * rand)
    
    respond_to do |format|
      format.html do
        render :action => 'show'
      end

      format.text do
        render :partial => 'twit.html.haml', :object => @twit
      end
    end
  end

  def recent
  end

private
  def respond_to_twits
    respond_to do |format|
      format.html do
        render :action => :index
      end
      format.text do
        render :partial => 'twit.html.haml', :collection => @twits
      end
    end
  end

  def get_twit
    @twit = Twit.find(params[:id])
  end

  def vote(delta)
    @twit.rating = ( @twit.rating || 0 ) + delta
    @twit.votes = ( @twit.votes || 0 ) + 1
  end
end
