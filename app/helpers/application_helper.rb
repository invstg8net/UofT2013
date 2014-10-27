module ApplicationHelper
  def flash_message
    messages = ""
    [:notice, :info, :warning, :error, :alert].each {|type|
      if flash[type]
        messages += "<p class=\"#{type}\">#{flash[type]}</p>"
      end
    }

    messages.html_safe
  end

  def add_topic(area)
     top = Expert.where(:active => true, :topic => area)
     if top
		top.researcher_count = top.researcher_count + 1
     else
		top = Expert.new
		top.topic = area
     end
 end

end
