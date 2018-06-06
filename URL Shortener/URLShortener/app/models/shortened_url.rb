# == Schema Information
#
# Table name: shortened_urls
#
#  id        :bigint(8)        not null, primary key
#  short_url :string           not null
#  long_url  :string           not null
#  user_id   :integer          not null
#
require 'securerandom'
class ShortenedUrl < ApplicationRecord

  def self.random_code
    code = SecureRandom.urlsafe_base64
    while ShortenedUrl.exists?(short_url: code)
      code = SecureRandom.urlsafe_base64
    end
    code
  end

  def self.make_short(user, long_url)
    code = ShortenedUrl.random_code
    ShortenedUrl.create!(short_url: code, user_id: user.id, long_url: long_url)
  end

  belongs_to :submitter,
    foreign_key: :user_id,
    primary_key: :id,
    class_name: :User

  has_many :visits,
    foreign_key: :shortened_url_id,
    primary_key: :id,
    class_name: :Visit

  has_many :visitors,
    through: :visits,
    source: :user

  def num_clicks
    self.visitors.length
  end

  def num_uniques
    # self.visitors.uniq.length
    data = ShortenedUrl.connection.execute(<<-SQL)
      SELECT
        COUNT(DISTINCT user_id)
      FROM
        visits
      WHERE
        visits.shortened_url_id = #{self.id}
    SQL

  end

  def num_recent_uniques

  end
end
