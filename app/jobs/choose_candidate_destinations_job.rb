class ChooseCandidateDestinationsJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    user_id = args[0]
    # generate list of destinations the given user can get to
    destinations = []

    # for each point, kick off a search for invitation candidates
    destinations.each do |destination|
      ChooseCandidateUsersJob.perform_later user_id, destination
    end
  end
end
