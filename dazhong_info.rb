# encoding: UTF-8
require "json"
require "yaml"
require "csv"
require "net/http"


class DazhongInfo

  def get_dazhong_info(get_url_from)
    f = IO.popen("./phantomjs ~/workspace/mywork/dazhong/dazhong_new_fix.js #{get_url_from}")
    output =  f.readlines
    puts output
    detail = JSON.parse(output[0].to_s)
  end

  def push_data(info_unfix,name)
    info_name = info_unfix["shop_name"]
    info_phone = info_unfix["shop_phone"].strip
    info_address = info_unfix["shop_address"].gsub("公交/驾车","").strip
    #info_cuisine = info_unfix["cuisine"]
    info_cuisine = name
    info_detail_all = info_unfix["shop_detail_info"].strip
    #puts info_unfix["pictures_url"].gsub(/<[^>]+?>/,"").strip
    info_pic_unfix = info_unfix["pictures_url"].strip.split(/<*>/)
    info_pic_fix_hash = []

    info_pic_unfix.each do |pic|

      if pic.include?("img")
        pic_name =  pic.split(/\"*\"/)[3].gsub("的主页","")
        pic_url = pic.split(/\"*\"/)[1]
        if !pic_url.include?("_blank")
          info_pic_fix_hash << [pic_name +"=>"+ pic_url]

          if pic_url.include?("i1.dpfile.com")
            a = "i1.dpfile.com"
            include_url = pic_url.gsub("http://www.i1.dpfile.com","")
          elsif pic_url.include?("i2.dpfile.com")
            a = "i2.dpfile.com"
            include_url = pic_url.gsub("http://www.i2.dpfile.com","")
          elsif pic_url.include?("i3.dpfile.com")
            a = "i3.dpfile.com"
            include_url = pic_url.gsub("http://www.i3.dpfile.com","")
          end
          puts include_url
          Net::HTTP.start(a) { |http|
            resp = http.get(include_url)
            open(info_name+"-"+pic_name+".jpg", "wb") { |file|
              file.write(resp.body)
            }
          }
          #1,3
        end
      end
    end

    success_got_info = Array.new
    success_got_info = [info_name,info_phone,info_address,info_cuisine,info_detail_all,info_pic_fix_hash]
    return success_got_info
  end

  def get_csv_file(success_got_info)
    CSV.open(success_got_info[0]+".csv", "wb") do |csv|
      csv << success_got_info
    end
  end
end
#test_start = DazhongInfo.new
#test = test_start.get_dazhong_info("http://www.dianping.com/shop/4233409")
#test_2 = test_start.push_data(test)
#test_start.get_csv_file(test_2)

