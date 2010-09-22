require 'yaml'

module Minmin 
  def minmin(message)
    puts 'yobareta!'
    File.open('./data/karma.yaml','a').close
    file = File.open('./data/karma.yaml','r')
    hash = YAML.load(file)
    file.close
    #p hash
    #p message
    p hash  
    if hash.has_key?(message)
      hash[message]["--"] += 1
    else
      hash[message] = {"--" => 1, "++" => 0}
    end
   puts "-"*5
    p hash 
    file = File.open('./data/karma.yaml','w')
    YAML.dump(hash,file)
    file.close
  
    plus = hash[message]["++"]
    min = hash[message]["--"]
    array=[]
    array << "#{message}:#{(plus-min)} (#{plus}++ #{min}--)"
    return array
  end 


end

