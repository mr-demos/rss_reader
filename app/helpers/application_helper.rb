# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def flash_messages
    html = ""
    [:message, :error].each do |key|
      next unless flash[key]
      html << %Q[<div class="flash_message flash_message_#{key}">#{flash[key]}</div>]
    end
    return html
  end

  def item_controls_id(article)
    "item_controls_#{article.id}"
  end
end
