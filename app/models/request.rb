class Request < ActiveRecord::Base
  belongs_to :user
  has_many :messages
  REQUEST_STATUSES = %w(Sent Accepted Rejected)
  validates :status, :inclusion => {:in => REQUEST_STATUSES}
end
