require 'open-uri'
require 'hpricot'

module Av
  def av(message)
    url = []
    url << "http://www.adulttube.info/tag/p1/c/#{CGI.escape(message)}"
    return url
  end
end
