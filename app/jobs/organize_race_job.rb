class OrganizeRaceJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    base_uri = 'https://nwhacks.firebaseio.com/'
    firebase = Firebase::Client.new(base_uri)
    # response = firebase.get('users')
    response = firebase.push('kabooms', {:name => 'FreshMeet', :priority => 1})
    print response
    #render json: {users: response.body}
  end
end
