class TwitsController < ApplicationController
  before_filter :get_twit, :except => [:index]

  def index
    @twits = Twit.all( :order => "twitid desc", :limit => "15" )
  end

  def show
  end

  def voteup
    vote(+1)
    @twit.save

    redirect_to twit_url(@twit)
  end

  def votedown
    vote(-1)
    @twit.save

    redirect_to twit_url(@twit)
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
