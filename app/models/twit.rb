class Twit < ActiveRecord::Base

  def self.create_from_string(string)
    object = Yajl::Parser.parse(string)

    object['results'].map do |result|
      Twit.create(  :text => result["text"], 
                    :username => result["from_user"],
                    :avatar_url => result["profile_image_url"],
                    :userid => result["from_user_id"],
                    :twitid => result["id"],
                    :twit_created_at => result["created_at"] )
    end
  end
end
