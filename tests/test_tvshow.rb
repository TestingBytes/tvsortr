require 'lib/tvshow'
require 'test/unit'

class TVShowTest
    attr_reader :tvShow, :fileName, :name, :type, :episode, :season

    def initialize(fileName)
        @fileName = fileName
        @tvshow = TVShow.new(filename)
    end
end

class TVShowTests < Test::Unit::TestCase
  TestTVShowFileName = "The.Simpsons.S12E14.pdtv.[HDTV].avi"
  
  def setup
    
    @TVShow = TVShow.new(TestTVShowFileName)
  end
  
  def test_FileName
    assert_equal(@TVShow.fileName,TestTVShowFileName)
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
