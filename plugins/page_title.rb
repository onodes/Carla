require 'mechanize'

module Page_title
  def page_title(message)
    array = []
    begin    
      message = message[0,message.index(" ")] if message.include?(" ")
      agent = Mechanize.new
      page = agent.get("http://"+message)
      return array << page.title
    rescue
      return array << "page error"
    end
  end
end


