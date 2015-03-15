class ChooseCandidateUsersJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    initiating_user = args[0]
    destination = args[1]

    # generate a list of users who can go to the given point
    candidate_users = []

    # send out the notifications!
    candidate_users.each do |user_to_notify|
      NotifyUserJob.perform_later initiating_user, destination, user_to_notify
    end
  end
end
