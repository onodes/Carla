require 'yaml'
require 'net/irc'
puts "dynamic include module"

#Dynamic include
yaml = YAML.load_file("config.yaml")
keys = yaml.keys
@keyword_array = {}
keys.each{|element| 
  require_relative "../plugins/"+ element
  eval("include "+ yaml[element][0])
}


class Message_analy
  def initialize
    yaml = YAML.load_file("config.yaml")
    keys = yaml.keys
    @keyword_array = {}
    keys.each{|element|
      @keyword_array[yaml[element][2]] = yaml[element][1]
    }
    @exec_array = @keyword_array.clone
  end

  def message_analy(message,channel)
    array = []
    # @keyword_array
    return loaded_module(message) if message.include?("Carla loaded module")
    return remove_module(message) if message.include?("Carla remove module")
    return load_module(message) if message.include?("Carla load module")
    return module_list(message) if message.include?("Carla module list")
    @exec_array.keys.each{|item|
      if item.include?("*")&&item[0] == "*"
        keyword = message[message.size-item.sub("*","").size,item.sub("*","").size]
        keyword = "*" + keyword.to_s
        puts keyword
      elsif item.include?("*")&&item[item.sub("*","").size] == "*"
        keyword = message[0,item.sub("*","").size] + "*"
      else
        keyword = message[0,item.size]
      end

      if @exec_array.has_key?(keyword)         
        word = message.sub(keyword.sub("*",""),"")
        array = eval("#{@exec_array[keyword]}('#{word}')")
        break
      end
    }
    return array

  end


  private 

  def load_module(message)
    mod = message.sub("Carla load module ","")
    array=[]
    return array << "loaded #{mod}" if @exec_array.has_value?(mod)
    p @keyword_array
    @keyword_array.each{|key,value|
      # @exec_array[key] = value if value == mod
      #return array << "load #{mod}"
      puts key +  ":" + value
      
      if value == mod
        @exec_array.store(key,value)
        array << "load #{value}"
      end
    }
    return array
  end

  def remove_module(message)
    mod = message.sub("Carla remove module ","")

    @exec_array.reject!{|key,value| value==mod}
    puts "AAA"
    p @exec_array
    array = []


    return array << "remove module => #{mod}"

  end

  def loaded_module(message)
    mod = message.sub("Carla loaded module ","") 
    array = []
    @exec_array.each{|key,value|
      array << value
    }
    return array
  end

  def module_list(message)
    array = []
    @keyword_array.each{|key,value|
      array << value
    }
    return array
  end

  def send_data(array,channel)
    array.each{|element|
      POST NOTICE,channel, element
      # sleep 0.1
    }
  end


end
