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
			@user = User.create(:name => name, :role => role, :email => email)
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
		@requests = Request.where(:receiver_id => session[:user_id], :status => "Sent")
	end

	def coaches
		@user = User.find(session[:user_id])
		@coaches = User.where(:role=> "Coach")
	end

	def messages
		if session[:user_role] == "Client"
			@client = true
			@requests = User.find(session[:user_id]).requests.where(:status => "Accepted")
		elsif session[:user_role] == "Coach"
			@client = false
			@requests = Request.where(:receiver_id => session[:user_id], :status => "Accepted")
		end
		if @requests.count > 0
			redirect_to "/message/#{@requests.first.id}"
		else
			redirect_to "/message/0"
		end
	end
end
