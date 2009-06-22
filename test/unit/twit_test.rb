require 'test_helper'

class TwitTest < ActiveSupport::TestCase
  # Stock result from twitter search :3
  z = "{\"results\":[{\"text\":\"moloz\",\"to_user_id\":null,\"from_user\":\"fanel_ro\",\"id\":2164271015,\"from_user_id\":21282203,\"iso_language_code\":\"it\",\"source\":\"&lt;a href=&quot;http:\\/\\/twitter.com\\/&quot;&gt;web&lt;\\/a&gt;\",\"profile_image_url\":\"http:\\/\\/s3.amazonaws.com\\/twitter_production\\/profile_images\\/256483872\\/untitled_normal.JPG\",\"created_at\":\"Sun, 14 Jun 2009 11:24:39 +0000\"},{\"text\":\"@krossfire moloz, moloz, moloz, moloz..... :))))))\",\"to_user_id\":3070507,\"to_user\":\"krossfire\",\"from_user\":\"Toppyx\",\"id\":2156185850,\"from_user_id\":205867,\"iso_language_code\":\"it\",\"source\":\"&lt;a href=&quot;http:\\/\\/twitter.com\\/&quot;&gt;web&lt;\\/a&gt;\",\"profile_image_url\":\"http:\\/\\/s3.amazonaws.com\\/twitter_production\\/profile_images\\/70700969\\/in_nori_normal.jpg\",\"created_at\":\"Sat, 13 Jun 2009 18:22:22 +0000\"}],\"since_id\":0,\"max_id\":2278398213,\"refresh_url\":\"?since_id=2278398213&q=moloz\",\"results_per_page\":15,\"total\":2,\"completed_in\":0.25944,\"page\":1,\"query\":\"moloz\"}"

  context "parsing from twitter result string" do
    setup do
      @twits = Twit.create_from_string(z)
    end

    should "create the right amount of twits" do
      assert_equal 2, @twits.length
    end

    should "save the proper fields from the string" do
      twit = @twits.first

      assert_equal "moloz", twit.text
      assert_equal "fanel_ro", twit.username
      assert_equal "http:\/\/s3.amazonaws.com\/twitter_production\/profile_images\/256483872\/untitled_normal.JPG", twit.avatar_url
      assert_equal 21282203, twit.userid
      assert_equal 2164271015, twit.twitid
      assert_equal "Sun, 14 Jun 2009 11:24:39 +0000", twit.twit_created_at
    end
  end
end
