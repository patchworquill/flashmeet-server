class ChooseCandidatePointsJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    userId = args[0]
    # generate list of destinations the given user can get to
    destinations = []

    # for each point, kick off a search for invitation candidates
    destinations.each do |destination|
      ChooseCandidateUsersJob.perform_later userId, destination
    end
  end
end
