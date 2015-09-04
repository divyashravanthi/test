class Message < ActiveRecord::Base
  belongs_to :request
  belongs_to :sender, class_name: User

  def sender_name
  	self.sender.name
  end

  def to_json
  	super(methods: :sender_name)
  end


end
