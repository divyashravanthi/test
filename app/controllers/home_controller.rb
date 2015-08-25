class HomeController < ApplicationController
  def index
  	@user = User.find(params[:id])
  	if @user.role == "Client"
  		@coaches = User.where(:role=> "Coach")
  		# render 'client_view'
  	else
  		@requests = Request.where(:receiver_id => @user.id)
  		# render 'coach_view'
  	end
    
  end
end
