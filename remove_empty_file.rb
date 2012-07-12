CURRENT_PATH = File.realpath(File.dirname(__FILE__))+'/'

Dir[CURRENT_PATH + 'yuexiu_no_update/*.csv'].each do |file|
puts file
a = File.open(file).readlines
puts a.length

end
