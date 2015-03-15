class SendInvitesJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    race = args[0]

    #1. generate people that will get an invite (user.all)

    #2. send push notification to these people

  end
end
