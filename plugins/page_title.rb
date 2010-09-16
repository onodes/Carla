require 'mechanize'

module Page_title
  def page_title(message)
    
     message = message[0,message.index(" ")] if message.include?(" ")
    agent = Mechanize.new
    page = agent.get("http://"+message)
    array = []
    return array << page.title
  end
end


