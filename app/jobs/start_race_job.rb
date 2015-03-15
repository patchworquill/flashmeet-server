class StartRaceJob < ActiveJob::Base
  queue_as :default

  def perform(race)
    #assume that the "race" is the race we're in

    #1 filter the invitees
    #a grab info from firebase
    #b filter the people
    #c remove the people

    accepted_user = Array.new

    race.participants.each_pair { |participant, status|
      if status == 'accepted'
        accepted_user.push participant.inspect
      end
    }
    #TODO remove all invitees


    #2 Choose location and participants

    initiator = race.initiator
    destinations = Destination.all
    @destination
    @participant_list = Array.new
    choose_location_and_participants initiator, destinations

    #3 Add the destination, remove invitees, add participants list in firebase

    firebase = Firebase::Client.new(Rails.configuration.x.firebase_uri)
    #TODO: find the proper ID
    #TODO: is this a proper way to assign destination?
    response = firebase.update("races/#{@id}/destination", { 'destination'=> @destination })
    #TODO: do something if success
    response.success?


    # offset_list = Array.new
    # largest_time = 0
    #3.5 calculate starting offset
    @participant_list.each do |participant|
      directions = GoogleDirections.initialize(participant.lat_lon_string, @destination.lat_lon_string, {:mode => :transit})
      transit_time = directions.drive_time_in_minutes

      if transit_time > largest_time
        #TODO: is this proper variable assignment
        largest_time = transit_time
      end
    end


    @participant_list.each do |participant|
      time_stamp = (Time.now.to_i + 30)
      response = firebase.update("races/#{@id}/invitees", {participant => })
    end


    #4 send push notification with start time and destination





  end

  def choose_location_and_participants(initiator, destinations)
    destinations.each do |destination|
      directions = GoogleDirections.initialize(initiator.lat_lon_string, destination.lat_lon_string, {:mode => :transit})

      transit_time = directions.drive_time_in_minutes
      if transit_time <= 45 and find_nearby_users destination
        @destination = destination
        break
      end

      @participant_list
    end
  end

  def find_nearby_users(destination)
    user_counter = 0
    users = User.all

    users.each do |user|
      directions = GoogleDirections.initialize(destination.lat_lon_string, user.lat_lon_string, {:mode => :transit})
      if directions.drive_time_in_minutes <= 45
        user_counter += user_counter
        @participant_list.push user
        if user_counter == 4
          return true
        end
      end
    end
    false
  end

end



