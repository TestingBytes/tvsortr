require './lib/tvshow'
require 'test/unit'

class EpisodicTVShowTests < Test::Unit::TestCase

  EpisodicTVShowFileName = "The.Simpsons.S12E14.pdtv.[HDTV].avi"
  
  def setup
    @TVShow = TVShow.new(EpisodicTVShowFileName)
  end
  
  def test_FileName
    assert_equal(@TVShow.fileName,EpisodicTVShowFileName)
  end
  
  def test_Season
    assert_equal(@TVShow.season,"12")
  end
  
  def test_Episode
    assert_equal(@TVShow.episode,"14")
  end
  
  def test_Name
    assert @TVShow.name == "The Simpsons"
  end
  
  def test_ScrubbedFileName
    assert_equal(@TVShow.scrubbed_name,"The.Simpsons.S12E14.avi")
  end

end

class UnknownTVShowTests < Test::Unit::TestCase

  UnknownTVShowFileName = "Just some file or dir"

  def setup
    @TVShow = TVShow.new(UnknownTVShowFileName)
  end

  def test_Type
    assert_equal(@TVShow.type,"Unknown")
  end

end
