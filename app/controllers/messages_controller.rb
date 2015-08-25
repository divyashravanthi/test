class MessagesController < ApplicationController
	def create
	end

	def update
	end

	def delete
	end

	def chatbox
		@request = Request.find(params[:id])
	end

	def new_message
		@req = Request.find(params[:request_id])
		if @req.user.id == params[:sender_id]
			@receiver_id = @req.receiver_id
		else
			@receiver_id = @req.user.id
		end
		# binding.pry
		@msg = @req.messages.new(
			:sender_id => params[:sender_id],
			:receiver_id => @receiver_id,
			:raw_text => params[:msg])
		@msg.save
		render :text => "Message saved"
	end
end
