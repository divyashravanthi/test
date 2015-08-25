class User < ActiveRecord::Base
	has_many :requests

	USER_ROLES = %w(Client Coach)
	validates :role, :inclusion => {:in => USER_ROLES}
	validates :name, presence: true
	validates :email, presence: true
end
