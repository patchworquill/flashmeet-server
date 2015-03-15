class ApiController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception

  # Acknowledge that the race request was received.
  # The receipt of a race request does NOT guarantee a race.
  def start_race
    user_id = params[:userId]
    user = User.new user_id
    OrganizeRaceJob.perform_later user
    render json: {status: 'OK'}
  end

  def rsvp
    user = User.new 'alanisawesome'
    render json: user.id
  end

  def push_location
    render json: {status: 'OK'}
  end
end
