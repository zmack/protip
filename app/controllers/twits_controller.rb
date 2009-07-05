class TwitsController < ApplicationController
  before_filter :get_twit, :except => [:index, :random, :recent]

  def index
    @twits = Twit.all( :order => "twitid desc", :limit => "15" )
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
  def get_twit
    @twit = Twit.find(params[:id])
  end

  def vote(delta)
    @twit.rating = ( @twit.rating || 0 ) + delta
    @twit.votes = ( @twit.votes || 0 ) + 1
  end
end
