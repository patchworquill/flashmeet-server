class ApiController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception

  # Acknowledge that the race request was received.
  # The receipt of a race request does NOT guarantee a race.
  def start_race
    user_id = params[:userId]

    user = User.new user_id
    race = Race.new nil, user_id

    OrganizeRaceJob.perform_later race
    render json: {status: 'OK', raceId: race.id}
  end

  def rsvp
    user_id = params[:userId]
    race_id = params[:raceId]
    accepted_invitation = params[:acceptedInvitation] == '1' ? true : false

    race = Race.new race_id
    user = User.new user_id
    race.rsvp user, accepted_invitation

    render json: {status: 'OK'}
  end
end
