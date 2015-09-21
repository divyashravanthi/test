class RequestsController < ApplicationController
	def new
		@req = Request.new
	end

	def create
		User.find(params[:request][:sender_id]).requests.create(:receiver_id => params[:request][:receiver_id])
		session[:not] = "Request sent!"
		redirect_to home_index_path
	end

	def accept_request
		@req = Request.find(params[:id])
		@req.status = "Accepted"
		@req.save
		session[:not] = "Request Accepted!"
		redirect_to home_index_path
	end

	def reject_request
		@req = Request.find(params[:id])
		@req.status = "Rejected"
		@req.save
		session[:not] = "Request Rejected!"
		redirect_to home_index_path
	end

	def closing
		@req = Request.find(params[:id])
		if current_user.role == "Client"
			@req.status = "Close_pending"
		else
			@req.status = "Closed"
		end
		@req.save
		render :text => "Success"
	end

	def publish
		@req = Request.find(params[:id])
		@req.published = true
		@req.save
		render :text => "Success"
	end

	def show
	end

	def edit
	end

	def update
	end

end
