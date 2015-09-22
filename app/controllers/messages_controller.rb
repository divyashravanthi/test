class MessagesController < ApplicationController
	skip_before_filter :verify_authenticity_token
	def create
	end

	def update
	end

	def delete
	end

	def published_chatbox
		if params[:id].to_i == 0
			render :text => "Inactive chat"
		else
			@request = Request.find(params[:id])
			if current_user.role == "Client"
				@client = true
				@requests = current_user.requests.where(:published => true, :status => "Closed")
			elsif current_user.role == "Coach"
				@client = false
				@requests = Request.where(:receiver_id => current_user.id, :published => true, :status => "Closed")
			end
		end
	end


	def archived_chatbox
		if params[:id].to_i == 0
			render :text => "Inactive chat"
		else
			@request = Request.find(params[:id])
			if current_user.role == "Client"
				@client = true
				@requests = current_user.requests.where(:status => "Closed")
			elsif current_user.role == "Coach"
				@client = false
				@requests = Request.where(:receiver_id => current_user.id, :status => "Closed")
			end
		end
	end

	def chatbox
		if params[:id].to_i == 0
			render :text => "Inactive chat"
		else
			@request = Request.find(params[:id])
			if current_user.role == "Client"
				@client = true
				@requests = current_user.requests.where(:status => ["Accepted", "Close_pending"])
			elsif current_user.role == "Coach"
				@client = false
				@requests = Request.where(:receiver_id => current_user.id, :status => ["Accepted", "Close_pending"])
			end
		end
		# binding.pry
	end

	def new_message
		@req = Request.find(params[:request_id])
		if @req.user.id == params[:sender_id].to_i
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

	def change_status
		# @req = Request.find(params[:id])
		@messages = Request.find(params[:id]).messages.where(:receiver_id => current_user.id)
		@messages.each do |m|
			m.read_status = true
			m.save
		end
		render :text => "Success"
	end
end
