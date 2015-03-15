class ChooseCandidateDestinationsJob < ActiveJob::Base
  queue_as :default


  # @@Google_Transit_Maps_Options = {
  #     :language => :en,
  #     :alternative => :true,
  #     :sensor => :false,
  #     :mode => :transit,
  # }


  def perform(*args)
    initiator = args[0]
    destinations = args[1]
    @group_list = Array.new

    destinations.each do |destination|
       directions = GoogleDirections.initialize(initiator.lat_lon_string, destination.lat_lon_string, {:mode => :transit})

       transit_time = directions.drive_time_in_minutes
       if transit_time <= 45 and find_nearby_users destination
         break
       end
    end

    GoogleDirections.initialize(userCurrentaddress, destination,  destination)
    # generate list of destinations the given user can get to
    destinations = []

    # for each point, kick off a search for invitation candidates
    destinations.each do |destination|
      ChooseCandidateUsersJob.perform_later initiator, destination
    end
  end

  def find_nearby_users(destination)
    user_counter = 0
    users = User.all

    users.each do |user|
      directions = GoogleDirections.initialize(destination.lat_lon_string, user.lat_lon_string, {:mode => :transit})
      if directions.drive_time_in_minutes <= 45
        user_counter += user_counter
        @group_list.push user
        if user_counter == 4
          return true
        end
      end
    end
    false
  end
end
