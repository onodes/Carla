require 'pit'
require_relative 'carla'

carla = Carla.new("chat.freenode.net", 6667,{:nick => "Carla2", :user => "Carla", :real => "Carla",:channel => "#onodesroom" , :pass => Pit.get("locant")["pass"]})

carla.start
