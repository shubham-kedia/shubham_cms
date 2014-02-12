class AccessController < ApplicationController
  
  layout 'admin'

  def index
  	# display text & links
  end

  def login
  	# login form
  end

  def attempt_login
	  	if params[:username].present? && params[:password].present?
	  		found_user = AdminUser.where(:username => params[:username]).first
	  		if found_user.authenticate(params[:password])
	  			flash[:notice] = "You are Now logged in."
	  			redirect_to(:action => 'index', :name => found_user.username)
	  		else
	  			flash[:notice] = "invalid username/password combination"
	  			redirect_to(:action => 'login')
	  		end
	  	else
	  		flash[:notice] = "Username/password can't left blank"
	  		redirect_to(:action =>'login')
	  	end

  end

  def logout
  	flash[:notice] = "You are Now logged out."
	redirect_to(:action => 'login')
  end
end
