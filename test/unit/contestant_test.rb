require 'test_helper'

class ContestantTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end


# == Schema Information
#
# Table name: contestants
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  user        :string(255)
#  cached_data :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

