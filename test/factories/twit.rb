Factory.define :twit do |twit|
  twit.text 'Protips lol'
  twit.username 'el tipador'
  twit.avatar_url 'http://localhost:3000/avatar.gif'
  twit.userid '100'
  twit.twit_created_at Time.now
end
