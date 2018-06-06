# == Schema Information
#
# Table name: visits
#
#  id               :bigint(8)        not null, primary key
#  user_id          :integer          not null
#  shortened_url_id :integer          not null
#

class Visit < ApplicationRecord
  validates :user_id, :shortened_url_id, presence: true

  def self.record_visit!(user, shortened_url)
    Visit.create!(user_id: user.id, shortened_url_id: shortened_url.id)
  end

  belongs_to :user,
    foreign_key: :user_id,
    primary_key: :id,
    class_name: :User

  belongs_to :shortened_url,
    foreign_key: :shortened_url_id,
    primary_key: :id,
    class_name: :ShortenedUrl

  

end
