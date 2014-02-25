require 'test_helper'

class LeftMenuCellTest < Cell::TestCase
  test "show" do
    invoke :show
    assert_select "p"
  end
  

end
