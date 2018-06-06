class AddTimestamps < ActiveRecord::Migration[5.1]
  def change
    add_timestamps :users, default: Time.now
    add_timestamps :visits, default: Time.now
    add_timestamps :shortened_urls, default: Time.now

  end
end
