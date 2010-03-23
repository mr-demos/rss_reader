ActionController::Routing::Routes.draw do |map|
  map.root :controller => :users, :action => :new
  map.resources :users, :member => {:logout => :any} do |users|
    users.resources :subscriptions, :controller => 'user_subscriptions'
  end
  map.resources :articles, :member => {:read => :post, :unread => :post}
end
