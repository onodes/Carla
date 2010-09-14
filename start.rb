require 'pit'
require_relative 'carla'

carla = Carla.new("localhost", 6669,{:nick => "carla", :user => "carla", :real     => "carla",:channel => "#Carla" , :pass => Pit.get("locant")["pass"]})

carla.start
