class Destination
  include ActiveModel::Serialization
  attr_accessor :id, :address, :description, :name, :latitude, :longitude

  include GlobalID::Identification

  def self.find(id)
    self.new(id)
  end

  def id
    @id
  end

  def initialize(destination_id, fields = nil)
    @id = destination_id

    unless fields.nil?
      @address = fields['address']
      @description = fields['description']
      @name = fields['name']
      @latitude = fields['lat']
      @longitude = fields['long']

      return
    end

    firebase = Firebase::Client.new(Rails.configuration.x.firebase_uri)
    response = firebase.get("destinations/#{@id}/")

    if defined? response.body['name']
      @address = response.body['address']
      @description = response.body['description']
      @name = response.body['name']
      @latitude = response.body['lat']
      @longitude = response.body['long']
    else
      raise ActiveRecord::RecordNotFound
    end
  end

  def self.all
    firebase = Firebase::Client.new(Rails.configuration.x.firebase_uri)
    response = firebase.get("destinations")

    all = Array.new
    response.body.each_with_index do |destination, counter|
      all.push self.new(counter, destination)
    end

    all
  end

  def attributes
    {
        :id => @id,
        :address => @address,
        :description => @description,
        :name => @name,
        :latitude => @latitude,
        :longitude => @longitude
    }
  end

  def lat_lon_string
    @latitude.to_s+','+@longitude.to_s
  end
end