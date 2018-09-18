require './lib/photograph'
require './lib/artist'

class Curator
  attr_reader :artists,
              :photographs


  def initialize
    @artists = []
    @photographs = []

  end

  def add_photograph(photo)
    @photographs << Photograph.new(photo)
  end

  def add_artist(artist)
    @artists << Artist.new(artist)
  end

  def find_artist_by_id(string)
    to_look = @artists
    find_by_id(string, to_look)
  end

  def find_photograph_by_id(string)
    to_look = @photographs
    find_by_id(string, to_look)
  end

  def find_photographs_by_artist(artist)
    id_from_artist = artist.id
    @photographs.find_all do |photo|
      photo.artist_id == id_from_artist
    end
  end 

  def find_by_id(string, to_look)
    to_look.find do |data|
      data.id.downcase == string.downcase
    end
  end
end
