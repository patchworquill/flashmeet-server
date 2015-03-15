class OrganizeRaceJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    user = args[0]
    destinations = Destination.all
    ChooseCandidateDestinationsJob.perform_later user, destinations
  end
end
