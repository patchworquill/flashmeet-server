class StartRaceJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    race = args[0]

    #1 filter the invitees

    #2 Choose location and participants

    #3 Add the destination, remove invitees, add participants list in firebase

    #4 send push notification with start time and destination

  end
end
