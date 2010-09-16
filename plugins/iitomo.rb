require 'rss'


module Iitomo
  def iitomo(message)
    rss = open("http://telephoneshocking.dtiblog.com/?xml"){|file| RSS::Parser.parse(file.read)}

    tel = rss.items[0]
  return  array = [tel.title,tel.description]
  end
end
