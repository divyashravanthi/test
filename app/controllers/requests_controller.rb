class RequestsController < ApplicationController
	def new
		@req = Request.new
	end

	def create
		User.find(params[:request][:sender_id]).requests.create(:receiver_id => params[:request][:receiver_id])
		render html: "<strong>Request Sent!</strong>".html_safe
	end

	def accept_request
		@req = Request.find(params[:id])
		@req.status = "Accepted"
		@req.save
		render html: "<strong>Request Accepted</strong>".html_safe
	end

	def show
	end

	def edit
	end

	def update
	end

end
