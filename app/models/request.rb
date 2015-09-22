class Request < ActiveRecord::Base
  belongs_to :user
  has_many :messages
  REQUEST_STATUSES = %w(Sent Accepted Rejected Close_pending Closed)
  validates :status, :inclusion => {:in => REQUEST_STATUSES}

  def sender_unread_count
  	self.messages.where(:receiver_id => self.user_id, :read_status => false).count
  end

  def receiver_unread_count
  	self.messages.where(:receiver_id => self.receiver_id, :read_status => false).count
  end
end
