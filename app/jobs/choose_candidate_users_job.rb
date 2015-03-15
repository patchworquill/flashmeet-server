class ChooseCandidateUsersJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    initiator_id = args[0]
    destination = args[1]

    # generate a list of users who can go to the given point
    candidate_users = []

    # send out the notifications!
    candidate_users.each do |candidate_user|
      NotifyUserJob.perform_later initiator_id, destination, candidate_user
    end
  end
end
