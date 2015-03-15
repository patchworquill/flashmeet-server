class ChooseCandidateDestinationsJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    user = args[0]
    # generate list of destinations the given user can get to
    destinations = []

    # for each point, kick off a search for invitation candidates
    destinations.each do |destination|
      ChooseCandidateUsersJob.perform_later user, destination
    end
  end
end
