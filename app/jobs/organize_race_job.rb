class OrganizeRaceJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    user_id = args[0]

    print 'User ID:' + userId.to_s
    ChooseCandidateDestinationsJob.perform_later user_id
  end
end
