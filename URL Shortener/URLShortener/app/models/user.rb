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


end
