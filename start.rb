require_relative 'carla'

carla = Carla.new("irc.livedoor.ne.jp", 6667,{:nick => "Carla", :user => "Carla", :real => "Carla",:channel => "#onodesroom" , :pass => "yatsuhashi"})

carla.start
