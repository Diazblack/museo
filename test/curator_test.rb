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

    @photo_3 = {
      id: "3",
      name: "Identical Twins, Roselle, New Jersey",
      artist_id: "3",
      year: "1967"
    }

    @photo_4 = {
      id: "4",
      name: "Child with Toy Hand Grenade in Central Park",
      artist_id: "3",
      year: "1962"
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

    @artist_3 = {
      id: "3",
      name: "Diane Arbus",
      born: "1923",
      died: "1971",
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

  def test_if_it_can_find_photographs_by_artist
    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)
    @curator.add_photograph(@photo_3)
    @curator.add_photograph(@photo_4)
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)
    @curator.add_artist(@artist_3)

    diane_arbus = @curator.find_artist_by_id("3")
    photos = @curator.find_photographs_by_artist(diane_arbus)

    photos.each do |photo|
      assert_instance_of Photograph, photo
    end
    assert_equal 2, photos.count
    expected = "Child with Toy Hand Grenade in Central Park"
    assert_equal expected, photos.last.name
  end

  def test_if_it_can_find_artists_with_multiple_photos
    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)
    @curator.add_photograph(@photo_3)
    @curator.add_photograph(@photo_4)
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)
    @curator.add_artist(@artist_3)

    artist = @curator.artists_with_multiple_photographs

    assert_instance_of Artist, artist.first
    assert_equal 1, artist.count
    assert_equal "Diane Arbus", artist.first.name
  end

  def test_if_it_can_find_photographs_by_artist_country
    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)
    @curator.add_photograph(@photo_3)
    @curator.add_photograph(@photo_4)
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)
    @curator.add_artist(@artist_3)

    photos_from_1  = @curator.photographs_taken_by_artists_from("United States")

    photos_from_1.each do |photo|
      assert_instance_of Photograph, photo
    end
    assert_equal 3, photos_from_1.count

    photos_from_2  = @curator.photographs_taken_by_artists_from("Argentina")
    assert_equal [], photos_from_2
  end

  def test_if_it_can_load_photographs_from_csv_file
    @curator.load_photographs('./data/photographs.csv')

    @curator.photographs.each do |photo|
      assert_instance_of Photograph, photo
    end
    assert_equal 4, @curator.photographs.count
    expected = "Rue Mouffetard, Paris (Boy with Bottles)"
    assert_equal expected, @curator.photographs.first.name
  end

  def test_if_it_can_load_artists_from_csv_file
    @curator.load_artists('./data/artists.csv')

    @curator.artists.each do |artist|
      assert_instance_of Artist, artist
    end

    assert_equal 6, @curator.artists.count
    expected = "Henri Cartier-Bresson"
    assert_equal expected, @curator.artists.first.name
  end

  def test_if_it_can_get_a_photograph_taken_between
    @curator.load_artists('./data/artists.csv')
    @curator.load_photographs('./data/photographs.csv')

    photos = @curator.photographs_taken_between(1950..1965)

    assert_equal 2, photos.count
    photos.each do |photo|
      assert_instance_of Photograph, photo
    end
  end

end
