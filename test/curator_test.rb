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
  
 end
