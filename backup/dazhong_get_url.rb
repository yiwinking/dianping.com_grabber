# encoding: UTF-8
require "json"
require "yaml"
require "csv"
require "net/http"

class DazhongGetUrl 

  def self.get_dazhong_info(file_name,address)
    f = IO.popen("./phantomjs ~/workspace/mywork/dazhong/get_url.js #{address}")
   output =  f.readlines
    detail = output
    CSV.open(file_name+".csv","w") do |csv|
    detail.each do |url_find|
    if url_find.include?("shop")
    puts url_ok =  url_find.strip.split("href=").join("\"\"").scan(/shop\/.*?\"/)[0].chop
      csv << CSV.parse("http://www.dianping.com/"+url_ok)
     end
    end
   end
  end
end

#get_dazhong_info("g363r22p8")

#test = DazhongGetUrl.new
#DazhongGetUrl.get_dazhong_info("winking","http://www.dianping.com/search/category/4/10/g363p2")
