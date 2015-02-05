class User < ActiveRecord::Base
  validates :user_name, presence: true, length: {in: 6..12}, uniqueness: true
  validates :password, presence: true, length: {in: 6..12},
  exclusion: { in: %w(password, 123, blah), message: "Invalid Password type"}
end
