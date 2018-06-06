# == Schema Information
#
# Table name: users
#
#  id    :bigint(8)        not null, primary key
#  name  :string
#  email :string
#

class User < ApplicationRecord
  validates :email, uniqueness: true, presence: true
  validates :name, presence: true

  has_many :submitted_urls,
    foreign_key: :user_id,
    primary_key: :id,
    class_name: :ShortenedUrl


  has_many :visits,
    foreign_key: :user_id,
    primary_key: :id,
    class_name: :Visit

  has_many :visited_urls,
    through: :visits,
    source: :shortened_url
end
