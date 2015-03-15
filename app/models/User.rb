class User
  include ActiveModel::Serialization
  attr_accessor :id, :latitude, :longitude

  include GlobalID::Identification

  def self.find(id)
    self.new(id)
  end

  def id
    @id
  end

  def initialize(user_id)
    @id = user_id
    update
  end

  def update
    firebase = Firebase::Client.new(Rails.configuration.x.firebase_uri)
    response = firebase.get("users/#{@id}/")
    if defined? response.body['userId']
      @latitude = response.body['lat']
      @longitude = response.body['long']
    else
      raise ActiveRecord::RecordNotFound
    end
  end

  def attributes
    {
        :id => @id,
        :latitude => @latitude,
        :longitude => @longitude
    }
  end
end