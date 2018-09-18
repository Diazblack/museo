require "minitest/autorun"
require "minitest/pride"

require './lib/photograph'
require './lib/artist'

 class PhotographTest < Minitest::Test
   def setup
    @attributes = {
      id: "1",
      name: "Rue Mouffetard, Paris (Boy with Bottles)",
      artist_id: "4",
      year: "1954"
    }
    @photograph = Photograph.new(@attributes)
  end

  def test_if_exist
    assert_instance_of Photograph, @photograph
  end

  def test_if_it_has_attrubutes
    assert_equal "1", @photograph.id
    assert_equal "Rue Mouffetard, Paris (Boy with Bottles)", @photograph.id
    assert_equal "1", @photograph.id
    assert_equal "1", @photograph.id

end
