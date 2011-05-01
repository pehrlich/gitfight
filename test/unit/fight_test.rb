require 'test_helper'

class FightTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end


# == Schema Information
#
# Table name: fights
#
#  id            :integer         not null, primary key
#  defender_id   :integer
#  challenger_id :integer
#  victor_id     :integer
#  rounds        :string(255)
#  count         :integer         default(0)
#  created_at    :datetime
#  updated_at    :datetime
#

