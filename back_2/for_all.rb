#encoding: UTF-8
require './dazhong_get_url.rb'
require './dazhong_info.rb'
require 'FileUtils'

#a = DazhongGetUrl.new
#area = "海珠区"
#shop_kind = "日本料理" 
#shop_address = "http://www.dianping.com/search/category/4/10/g1989r25"
#page_num = 8 

#if (page_num == 1)
#DazhongGetUrl.get_dazhong_info(area+":"+shop_kind,shop_address)
#puts "one"
#else
#DazhongGetUrl.get_dazhong_info(area+":"+shop_kind,shop_address)
#puts 1
#(2..page_num).each do |n|
#DazhongGetUrl.get_dazhong_info(area+":"+shop_kind + "#{n}",shop_address+"p#{n}")
#puts n
#end
#end


CURRENT_PATH = File.realpath(File.dirname(__FILE__))+'/'

Dir[CURRENT_PATH + '/yuexiu/*.csv'].each do |file|

  file_name =  file.split("/")
  puts cuisine_name =  file_name[file_name.length-1]
  folder_name = String.new
  CSV.foreach(file) do |row|
    puts url_from_csv = row[0].delete("[").chop
    test_start = DazhongInfo.new
    test = test_start.get_dazhong_info(url_from_csv)
    test_2 = test_start.push_data(test,cuisine_name.delete(".csv"))
    test_start.get_csv_file(test_2)
    Dir[CURRENT_PATH + '*.csv'].each do |folder|
      folder_array = folder.split('/')
      folder_add = folder_array[folder_array.length-1].delete(".csv")
 
      if !folder_name.include?(folder_add.to_s)
        puts folder_add
        floder_name = floder_name.to_s.concat(folder_add.to_s)
        puts floder_name
        if(!File.exist?("./#{folder_add}"))
          Dir.mkdir("./#{folder_add}")
          FileUtils.mv "#{folder_add}.csv", "./#{folder_add}"
      else
        puts "jump"
      end
    end
  end
end

#if(!File.exist?("./no_profile_history"))
#    Dir.mkdir("./no_profile_history")
#  end

#  CSV.open("#{CURRENT_PATH}/no_profile_history/#{filename}.csv", "wb") do |csv|
