API = "http://www.google.co.jp/search?num=3&lr=lang_ja&oe=utf-8&q="

require 'nkf'
require 'kconv'
require 'cgi'
require 'open-uri'
require 'hpricot'

module Google_search
    def google_search(message)
      word = message.toutf8.sub("g ","")
  
      url = "#{API}#{CGI.escape(word)}"
  
      html = open(url).read
      doc = Hpricot(html)
      result = doc / 'li.g/h3.r/a.l'
      result_array = []
      result.each do |element|
        result_array <<  "[" + element.inner_text.to_s + "] " + element["href"]
      end
          
      return result_array
    end
end
  
  

  
  
