class NotifyUserJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    initiating_user = args[0]
    destination = args[1]
    user_to_notify = args[2]

    # notify this user
  end
end
