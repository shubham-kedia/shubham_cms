class AccessController < ApplicationController
  
  layout 'admin'

  before_action :confirm_logged_in, :except => [:login, :attempt_login, :logout]
  
  def index
  	# display text & links
  end

  def login
  	# login form
  end

  def attempt_login
	  	if params[:username].present? && params[:password].present?
	  		found_user = AdminUser.where(:username => params[:username]).first
	  			if found_user
	  				
			  		if found_user.authenticate(params[:password])
			  			# mark user as logged in 
			  			session[:user_id] = found_user.id
			  			session[:username] = found_user.username
			  			flash[:notice] = "You are Now logged in."
			  			redirect_to(:action => 'index')
			  			# redirect_to(:action => 'index', :name => found_user.username)
			  		else
			  			flash[:notice] = "invalid username/password combination"
			  			redirect_to(:action => 'login')
			  		end
			  	
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
  	# marked user as logout
  	session[:user_id] = nil
	session[:username] = nil
  	flash[:notice] = "You are Now logged out."
	redirect_to(:action => 'login')
  end
 
  def confirm_logged_in
  	unless session[:user_id]
  		flash[:notice] = "Please log in."
  		redirect_to(:action => 'login')
  		return false
  	else
  		return true
  	end
  end

end
