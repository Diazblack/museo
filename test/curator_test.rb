require "minitest/autorun"
require "minitest/pride"

require './lib/curator'

class CuratorTest < Minitest::Test

   def setup
     @curator = Curator.new

     @photo_1 = {
      id: "1",
      name: "Rue Mouffetard, Paris (Boy with Bottles)",
      artist_id: "1",
      year: "1954"
    }

    @photo_2 = {
      id: "2",
      name: "Moonrise, Hernandez",
      artist_id: "2",
      year: "1941"
    }

    @artist_1 = {
      id: "1",
      name: "Henri Cartier-Bresson",
      born: "1908",
      died: "2004",
      country: "France"
  }

    @artist_2 = {
      id: "2",
      name: "Ansel Adams",
      born: "1902",
      died: "1984",
      country: "United States"
  }
  end

  def test_if_exist
    assert_instance_of Curator, @curator
  end

  def test_if_artist_and_photograph_repos_are_empty
    assert_equal [], @curator.artists
    assert_equal [], @curator.photographs
  end

  def test_if_curator_can_add_photos
    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)


    assert_equal 2, @curator.photographs.count
    @curator.photographs.each do |photo|
      assert_instance_of Photograph, photo
    end
    expected_2 = "Rue Mouffetard, Paris (Boy with Bottles)"
    assert_equal expected_2 , @curator.photographs.first.name
  end

  def test_if_can_add_artists
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)


    assert_equal 2, @curator.artists.count
    @curator.artists.each do |photo|
      assert_instance_of Artist, photo
    end
    expected_2 = "Henri Cartier-Bresson"
    assert_equal expected_2 , @curator.artists.first.name
  end

  def test_if_it_can_get_an_artist_by_id
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)

    artist = @curator.find_artist_by_id("1")

    assert_instance_of Artist, artist
    assert_equal "Henri Cartier-Bresson", artist.name
  end

  def test_if_it_can_get_a_photograph_by_id
    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)

    photo = @curator.find_photograph_by_id("2")

    assert_instance_of Photograph,  photo
    assert_equal "Moonrise, Hernandez", photo.name
  end
end
