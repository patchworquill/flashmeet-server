class OrganizeRaceJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    race = args[0]

    SendInvites.perform_later race

    StartRace.set(wait: 30.seconds).perform_later race
  end
end
