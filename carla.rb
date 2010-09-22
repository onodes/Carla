require 'net/irc'
require_relative 'core/carla_core'
require 'kconv'
#require_relative 'core/log_write.rb'

class Carla < Net::IRC::Client

  def initialize(*args)
    super
    @mem = Message_analy.new
#    @da =  Log.new 
  end  
  def on_rpl_welcome(m)
    hash_make
    post JOIN, opts.channel
  end

 # def on_message(m)
  def on_privmsg(m)
    channel = m.params[0].to_s
    message = m.params[1].to_s
    array =  @mem.message_analy(message,channel)
 #   @da.write(channel,m.prefix.nick,message)
    array.each{|element| post NOTICE, channel,element.tojis}
  end 


end

