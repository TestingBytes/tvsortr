require 'test/unit'
require 'tvsortr'

class TestTVSortr < Test::Unit::TestCase
  def test_always_passes
    assert true
  end
  def test_always_fails
    assert false
  end
end

class SomeOtherClass < Test::Unit::TestCase
	def test_passes
		assert true
	end
	def test_fail
		assert false
	end
end
