require 'tempfile'

class Minimizer   
  def upload_file(js)
    @tempfile = Tempfile.new("mini-me.js")
    @tempfile << js
    @tempfile.flush
  end
  
  def minimize(js)
    upload_file(js)
    %x{java -jar lib/yuicompressor-2.4.2.jar --type js #{@tempfile.path}}
  end
end