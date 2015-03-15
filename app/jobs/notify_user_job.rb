class NotifyUserJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    initiator_id = args[0]
    destination = args[1]
    user = args[2]

    # notify this user
  end
end
