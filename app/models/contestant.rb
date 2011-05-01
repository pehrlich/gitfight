class Contestant < ActiveRecord::Base
  has_many :fights

  def stats
    # returns github data fresh or cached
    # cached_data variable name is a bit of a misnomer here.  technically, the user doesn't care how cached it it.

    # for now, never re-fresh
    if cached_data.blank?
      logger.warn "Retrieving fresh github data for #{self.user}/#{self.name}"

#      self.cached_data = Repository.find(:name => self.name, :user => self.user).to_json
      self.cached_data = open("http://github.com/api/v2/json/repos/show/#{user}/#{name}").read #uses open-uri
      save!
    end

    data = JSON.parse(self.cached_data)['repository']
    {
        :watchers => data['watchers'],
        :forks => data['forks'],
        :open_issues => data['open_issues'],
        :last_pushed => data['pushed_at'],
        :created_at => data['created_at'],
        :has_wiki => data['has_wiki']
    }

  end

  def self.find_or_create_by_url(url)
    matches = Regexp.new(/github.com\/(.*)\/(.*)/i).match(url)
    user, name = matches[1], matches[2]
    Contestant.find_or_create_by_user_and_name({:user => user, :name => name})
  end

  def to_s
    url
  end

  def url
    # also stored in cached data.. whatevs.
    "https://github.com/#{user}/#{name}"
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

