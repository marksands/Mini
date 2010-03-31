require 'rubygems'

class Shortener
  def self.load
    obj = self.new
    return obj
  end
  
  def self.minimize(js)
    load.minimize(js)
  end  
  
  attr_accessor :js
  
  def minimize(js)
    @js = system "java -jar yui-compressor-1.4.1.jar " # ????????
    # @js = Min::minimize(js)
  end 
end

class Min
  class << self
    # erases "/* foo bar baz */"
    def scanForComments buff      
      buff.gsub!(/\/\*[^\*]+\*\//, "")
      buff.gsub!(/\/\/.+$/, "")
    end
    # gets rid of excess spaces
    def scanForWhiteSpace buff  
      buff.squeeze!(" ")
      buff.squeeze!("\t")
      # Right Parenth
      buff.gsub!(/\)\s+\)/, "))")
         buff.gsub!(/\)\s+/, ")")
         buff.gsub!(/\s+\)/, ")")
      # Left Parenth
      buff.gsub!(/\(\s+\(/, "((")
         buff.gsub!(/\(\s+/, "(")  
         buff.gsub!(/\s+\(/, "(")  
      # Right Brace
      buff.gsub!(/\s+\}\s+/, "}")
         buff.gsub!(/\}\s+/, "}")  
         buff.gsub!(/\s+\}/, "}")  
      # Left Brace
      buff.gsub!(/\s+\{\s+/, "{")
         buff.gsub!(/\{\s+/, "{")  
         buff.gsub!(/\s+\{/, "{")
      buff.gsub!(/:\s+/, ":")
      # +
      buff.gsub!(/\s+\+\s+/, "+")
         buff.gsub!(/\+\s+/, "+")
         buff.gsub!(/\s+\+/, "+")
      # -
      buff.gsub!(/\s+\-\s+/, "-")
         buff.gsub!(/\+\s+/, "-")
         buff.gsub!(/\s+\+/, "-")
      # =
      buff.gsub!(/\s+\=\s+/, "=")
         buff.gsub!(/\=\s+/, "=")
         buff.gsub!(/\s+\=/, "=")
      # punctuation 
      buff.gsub!(/\s+\./, ".")
      buff.gsub!(/\;\s+/, ";")
      buff.gsub!(/\,\s+/, ",")
      buff.gsub!(/^\s+/,"")
    end
    # shortens long variable names
    def replaceVariableNames buff
      word_count = {}
      buff.each do |word|
        word_count[word] ||= 0
        word_count[word] += 1
      end
      word_count.each do |k,v|
        puts "#{k}\t#{v}"
      end
    end
    #the big kahoonah!
    def minimize js
      buffer = ""
      js.each_line do |line|
        buffer += line
      end
      # get rid of comments
      Min::scanForComments buffer
      # rids excess whitespce
      Min::scanForWhiteSpace buffer
      # write buffer
      return buffer
    end
  end
end