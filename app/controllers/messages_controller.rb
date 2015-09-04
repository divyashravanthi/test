class MessagesController < ApplicationController
	def create
	end

	def update
	end

	def delete
	end

	def chatbox
		if params[:id].to_i == 0
			render :text => "Inactive chat"
		else
			@request = Request.find(params[:id])
			if session[:user_role] == "Client"
				@client = true
				@requests = User.find(session[:user_id]).requests.where(:status => "Accepted")
			elsif session[:user_role] == "Coach"
				@client = false
				@requests = Request.where(:receiver_id => session[:user_id], :status => "Accepted")
			end
		end
	end

	def new_message
		@req = Request.find(params[:request_id])
		if @req.user.id == params[:sender_id]
			@receiver_id = @req.receiver_id
		else
			@receiver_id = @req.user.id
		end
		@msg = @req.messages.create(
			:sender_id => params[:sender_id],
			:receiver_id => @receiver_id,
			:raw_text => params[:msg])
		render :json => @msg.to_json
	end

	def get_messages
		@messages = Request.find(params[:id]).messages
		render :json => @messages.to_json(methods: :sender_name)
	end
end
