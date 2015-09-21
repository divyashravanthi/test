class HomeController < ApplicationController
  def index
  	@user = current_user
  	if @user.role == "Client"
  		@coaches = User.where(:role=> "Coach")
  		# render 'client_view'
  	else
  		@requests = Request.where(:receiver_id => @user.id, :status => "Sent")
  		# render 'coach_view'
  	end
    
  end

  def index2
  end
end
