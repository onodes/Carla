require 'yaml'
require 'net/irc'
puts "dynamic include module"

#Dynamic include
yaml = YAML.load_file("plugins/config.yaml")
keys = yaml.keys
@keyword_array = {}
keys.each{|element| 
  require_relative element
  eval("include "+ yaml[element][0])
}


class Message_analy
  def initialize
    yaml = YAML.load_file("plugins/config.yaml")
    keys = yaml.keys
    @keyword_array = {}
    keys.each{|element|
      @keyword_array[yaml[element][2]] = yaml[element][1]
    }
  end

  def message_analy(message,channel)
      array = [] 
      @keyword_array.keys.each{|item|
        keyword = message[0,item.size]
        if @keyword_array.has_key?(keyword)
          word = message.sub(keyword,"")
           array = eval("#{@keyword_array[keyword]}('#{word}')")
        end
       }
      return array 
   end


  private  
  def send_data(array,channel)
    array.each{|element|
      POST NOTICE,channel, element
      # sleep 0.1
    }
  end


end
