class ArticlesController < ApplicationController
  before_filter :find_article

  def read
    @reading = current_user.readings.find_or_create_by_article_id(@article.id)
  end

  def unread
    @reading = current_user.readings.find_by_article_id(@article.id)
    @reading.destroy if @reading
  end

  protected

  def find_article
    @article = Article.find(params[:id])
  end
end
