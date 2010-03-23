class UserSubscriptionsController < ApplicationController
  before_filter :find_user
  before_filter :find_subscription, :only => [:show, :destroy]

  def index
    @subscriptions = @user.subscriptions
  end

  def new
    @subscription = Subscription.new
  end

  def create
    @subscription = Subscription.new(params[:subscription].merge(:user => @user))
    if @subscription.save
      flash[:message] = %Q[You have been subscribed to "#{@subscription.title}"]
      redirect_to user_subscription_url(@user, @subscription)
    else
      flash[:error] = "There was a problem with the url you entered"
      render :new
    end
  end

  def show
    @articles = @subscription.articles.first(20)
  end

  def destroy
    @subscription.destroy
    flash[:message] = %Q[You have been unsubscribed from "#{@subscription.title}"]
    redirect_to user_subscriptions_url(@user)
  end

  protected

  def find_user
    @user = User.find(params[:user_id])
  end

  def find_subscription
    @subscription = Subscription.find(params[:id])
  end
end
