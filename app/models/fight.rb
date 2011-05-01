class Fight < ActiveRecord::Base
  # http://stackoverflow.com/questions/3827851/raisl-3-howto-storing-unstructured-data-in-a-database-column-field-data
  belongs_to :challenger, :class_name => 'Contestant'
  belongs_to :defender, :class_name => 'Contestant'
  belongs_to :victor, :class_name => 'Contestant'

  validates_presence_of :challenger, :defender


  @@WEIGHTS = {:open_issues => -1}
  cattr_accessor :WEIGHTS

  def determine
    # loops through stats from defender and challenger.  Takes weights from each


    c_stats = self.challenger.stats
    d_stats = self.defender.stats

    rounds, c_points, d_points = {}, 0, 0

    # takes stats from individual contestants and compares them
    c_stats.map do |stat|
      stat_key, stat_val = stat[0], stat[1]
      c_score, d_score, weight = stat_val, d_stats[stat_key], (Fight.WEIGHTS[stat_key] || 1)
      good = (weight > 0)
      weight = weight.abs

      rounds[stat_key.to_sym] = {
          :h_name => stat_key.to_s.gsub(/_/, ' ').capitalize,
          :c_score => c_score,
          :d_score => d_score,
          :good => good,
          :weight => weight
      }

      if c_score.respond_to?(:>)
        (c_score > d_score) ? c_points += weight : d_points += weight
      end
    end

    self.rounds = rounds.to_json
    self.victor = (c_points > d_points) ? self.challenger : self.defender
    self.count += 1
    save!

  end



  include ActionView::Helpers::DateHelper
  def json_for_view
    # add up-to-date human titles to different rounds

    rounds = JSON.parse(self.rounds)

    pushed_pretty  = lambda { |score| time_ago_in_words(DateTime.parse(score))    }
    created_pretty = lambda { |score| Date.parse(score).to_s(:'January 1, 2011') }

    rounds['last_pushed'].send_updates!({
      'c_score' => pushed_pretty,
      'd_score' => pushed_pretty
    })
    rounds['created_at'].send_updates!({
      'c_score' => created_pretty,
      'd_score' => created_pretty
    })

    rounds.to_json
  end

  def to_param
    "#{id}-#{self.defender.user}-vs-#{self.challenger.user}"
  end


end


# data passed to client
# category name, left score, right score, winner, weight
# overall winner

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

