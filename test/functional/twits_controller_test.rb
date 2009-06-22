require 'test_helper'

class TwitsControllerTest < ActionController::TestCase
  # Replace this with your real tests.
  context "getting index" do
    setup do
      get :index
    end

    should_assign_to :twits
    should_respond_with :success
    should_render_template :index
  end

  context "getting a tweet" do
    setup do
      @twit = Factory(:twit)
      get :show, :id => @twit.id
    end

    should_assign_to :twit
    should_respond_with :success
    should_render_template :show
  end

  context "voting a tweet up" do
    setup do 
      @twit = Factory(:twit)
      put :voteup, :id => @twit.id

      @twit.reload
    end

    should_assign_to :twit
    should_respond_with :redirect
    should_redirect_to "the tweet's original url" do
      twit_url(@twit)
    end
    should "increment votes" do
      assert_equal 1, @twit.votes
    end

    should "increase rating" do
      assert_equal 1, @twit.rating
    end
  end

  context "voting a tweet down" do
    setup do 
      @twit = Factory(:twit)
      put :votedown, :id => @twit.id

      @twit.reload
    end

    should_redirect_to "the tweet's original url" do
      twit_url(@twit)
    end

    should "increment votes" do
      assert_equal 1, @twit.votes
    end

    should "decrease rating" do
      assert_equal -1, @twit.rating
    end
  end
end
