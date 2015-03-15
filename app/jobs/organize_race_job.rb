class OrganizeRaceJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    race = args[0]

    SendInvitesJob.perform_later race

    StartRaceJob.set(wait: 30.seconds).perform_later race
  end
end
