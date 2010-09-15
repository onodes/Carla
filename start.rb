require 'pit'
require_relative 'carla'

carla = Carla.new("irc.huie.hokudai.ac.jp", 6667,{:nick => "Carla", :user => "Carla", :real => "Carla",:channel => "#onodesroom" , :pass => Pit.get("locant")["pass"]})

carla.start
