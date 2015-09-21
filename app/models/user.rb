class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
	has_many :requests

	USER_ROLES = %w(Client Coach)
	validates :role, :inclusion => {:in => USER_ROLES}
	# validates :name, presence: true
	validates :email, presence: true
	mount_uploader :avatar, AvatarUploader

	def online
    if !self.updated_at.nil?
      self.updated_at > 30.seconds.ago
    else
      false
    end
  end

  def as_json(options={})
    # binding.pry
    options.merge!(:methods => [:online])
    super(options)
  end
end
