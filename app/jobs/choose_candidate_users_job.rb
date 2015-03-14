class ChooseCandidateUsersJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    initiatorId = args[0]
    destination = args[1]

    # generate a list of users who can go to the given point
    candidateUsers = []

    # send out the notifications!
    candidateUsers.each do |candidateUser|
      NotifyUserJob.perform_later initiatorId, destination, candidateUser
    end
  end
end
