require 'net/irc'
require_relative 'core/carla_core'
require 'kconv'

class Carla < Net::IRC::Client

  def initialize(*args)
    super
    @mem = Message_analy.new
  end  
  def on_rpl_welcome(m)
    hash_make
    post JOIN, opts.channel
  end

  def on_message(m)
    channel = m.params[0].to_s.toutf8
    message = m.params[1].to_s
    array =  @mem.message_analy(message.toutf8,channel)
    array.each{|element| post NOTICE, channel,element.tojis}
  end 


end

