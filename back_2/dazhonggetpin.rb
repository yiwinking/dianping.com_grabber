require 'net/http'

Net::HTTP.start("i1.dpfile.com") { |http|
  resp = http.get("/pc/9ea32d5122c6e78aa61dbd1595640951(249x249)/thumb.jpg")
  open("t.jpg", "wb") { |file|
    file.write(resp.body)
   }
}
puts "OK"
