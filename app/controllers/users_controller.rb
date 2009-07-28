class UsersController < ApplicationController
  def new
  end

  def create
    @request_token = consumer.get_request_token
    session[:request_token] = @request_token.token
    session[:request_token_secret] = @request_token.secret
    # Send to twitter.com to authorize
    redirect_to @request_token.authorize_url
  end

  def callback
    @request_token = OAuth::RequestToken.new(UsersController.consumer,
    session[:request_token],
    session[:request_token_secret])
    # Exchange the request token for an access token.
    @access_token = @request_token.get_access_token(:oauth_verifier => params[:oauth_verifier])

    @oauth_response = consumer.request(:get, '/account/verify_credentials.json', @access_token, { :scheme => :query_string })

    case @oauth_response
    when Net::HTTPSuccess
      user_info = JSON.parse(@oauth_response.body)
      unless user_info['screen_name']
        flash[:notice] = "Authentication failed"
        redirect_to :action => :index
        return
      end
      # We have an authorized user, save the information to the database.
      @user = User.new({ :screen_name => user_info['screen_name'], :token => @access_token.token, :secret => @access_token.secret })
      @user.save!
      # Redirect to the show page
      redirect_to(@user)
    else
      RAILS_DEFAULT_LOGGER.error "Failed to get user info via OAuth"
      # The user might have rejected this application. Or there was some other error during the request.
      flash[:notice] = "Authentication failed"
      redirect_to :action => :index
      return
    end
  end

private
  def consumer
    # The readkey and readsecret below are the values you get during registration
    OAuth::Consumer.new("VHcx8uzQU2qQ5rKl3GvAw", "dY9V84hm59IjLTd7aiQoKZacGxgth65vDRub5MN7I", { :site=>"http://twitter.com" })
  end
end
