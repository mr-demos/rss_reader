class UsersController < ApplicationController
  skip_before_filter :require_login
  before_filter :redirect_if_logged_in, :except => :logout

  def new
    @user = User.new
  end

  def create
    @user = User.find_or_initialize_by_email(params[:user][:email])
    if !@user.new_record?
      log_in(@user)
      redirect_to user_subscriptions_url(@user)
    elsif @user.save
      flash[:message] = "Your account has been created"
      log_in(@user)
      redirect_to user_subscriptions_url(@user)
    else
      flash.now[:error] = "There was a problem creating your account"
      render :new
    end
  end

  def logout
    log_out
    redirect_to :action => :new
  end

  protected

  def redirect_if_logged_in
    if current_user
      redirect_to user_subscriptions_url(current_user)
    end
  end
end
