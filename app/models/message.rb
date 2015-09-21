class Message < ActiveRecord::Base
  belongs_to :request
  belongs_to :sender, class_name: User

  def sender_name
  	# self.sender.name
  	User.find(self.sender_id).name
  end

  def avatar_url
  	User.find(self.sender_id).avatar.url
  end

  def to_json
  	super(:methods => [:sender_name, :avatar_url])
  end


end
