class OrganizeRaceJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    base_uri = 'https://nwhacks.firebaseio.com/'
    firebase = Firebase::Client.new(base_uri)
    response = firebase.push('kabooms', {:name => 'FreshMeet', :priority => 1})

    print 'User ID:' + args[0].to_s
  end
end
