class UsersController < ApplicationController
	def new
		@user = User.new
		
		# Clear sessions
		session[:user_id] = nil
		session[:user_role] = nil
	end

	def create
		name = params[:user][:name]
		role = params[:user][:role]
		email = params[:user][:email]

		# Create a user entry if it doesn't already exits. Logs in!
		@user = User.find_by(:email=> email, :role=> role)
		if @user.nil? 
			@user = User.create(:name => name, :role => role, :email => email, :avatar => params[:file])
		end

		# Initialise temp session
		session[:user_id] = @user.id
		session[:user_role] = @user.role 
		session[:not] = "Hello"
		redirect_to home_index_path(:id=> @user.id)
	end

	def update
	end

	def edit
	end

	def show
	end

	def requests
		@requests = Request.where(:receiver_id => current_user.id, :status => "Sent")
	end

	def coaches
		# @user = User.find(session[:user_id])
		@coaches = User.where(:role=> "Coach")
	end

	def published_messages
		if current_user.role == "Client"
			@client = true
			@requests = current_user.requests.where(:published => true)
		elsif current_user.role == "Coach"
			@client = false
			@requests = Request.where(:receiver_id => current_user.id, :published => true)
		end
		if @requests.count > 0
			redirect_to published_chatbox_path(:id => @requests.first.id)
		else
			redirect_to published_chatbox_path(:id => 0)
		end
	end

	def archived_messages
		if current_user.role == "Client"
			@client = true
			@requests = current_user.requests.where(:status => "Closed")
		elsif current_user.role == "Coach"
			@client = false
			@requests = Request.where(:receiver_id => current_user.id, :status => "Closed")
		end
		if @requests.count > 0
			redirect_to archived_chatbox_path(:id => @requests.first.id)
		else
			redirect_to archived_chatbox_path(:id => 0)
		end
	end

	def messages
		if current_user.role == "Client"
			@client = true
			@requests = current_user.requests.where(:status => ["Accepted", "Close_pending"])
			# binding.pry
		elsif current_user.role == "Coach"
			@client = false
			@requests = Request.where(:receiver_id => current_user.id, :status => ["Accepted", "Close_pending"])
		end
		if @requests.count > 0
			redirect_to "/message/#{@requests.first.id}"
		else
			redirect_to "/message/0"
		end
	end

	def profile
		@user = User.find(params[:id])
		if @user.role == "Client"
			@sessions = @user.requests.where(:published => "true", :status => "Closed")
		elsif @user.role == "Coach"
			@sessions = Request.where(:receiver_id => @user.id, :published => "true", :status => "Closed")
		end
		
	end

	def coach_search
		@entity = params[:type]
		if @entity == "name"
			User.where("users.name LIKE ?", "%#{params[:term]}%").where(role: "Coach")
		elsif @entity == "email"
			User.where(:role => "Coach", :email => params[:term])
		end
	end

	def keep_online
		current_user.updated_at = Time.now
		current_user.save
		@users = User.all
		render :json => @users.to_json(methods: :online)
	end
end
