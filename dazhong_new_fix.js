//get'name','language','number of members','description'
var page = require('webpage').create();
page.settings.userAgent = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_6_8) AppleWebKit/535.19 (KHTML, like Gecko) Chrome/18.0.1025.163 Safari/535.19';

page.onLoadStarted = function(){
    //        console.log('Start loading...');
    };

page.onLoadFinished = function(status){
    //  console.log('Loading finished.');
    };

var account_id =744405;
var language_class ="JTB";
var number_of_members_class ="IRB";
var description_class ="DUB EUB";
//output for collecting 4 information together 
var output;
//running times limit
var running_times =0;
var running_times_max = 20;
var set_time_out_time = 500;
//var url = "http://www.dianping.com/shop/4233409"
//var url = "http://www.dianping.com/shop/572601"
var url = phantom.args[0]
page.open(url,function(status){
    if(status == 'success'){
        var outputString = get_elements_info();
    }else{
        console.log('Unable to access network');
    }
});

function get_elements_info(){
    running_times = running_times +1;
    if(running_times > running_times_max){
        console.log(information);
        phantom.exit();
    }
   
    var information =  page.evaluate(function(){
        var shop_name_info = document.getElementsByClassName("shop-title")[0]
        var shop_phone_info = document.getElementsByClassName("shop-info-content");
        var each_person_price_info = document.getElementsByTagName("dd");
        var each_person_price = 0;

        if(shop_name_info == "undefined"){
            var shop_name = "";
        }
        else{
            var shop_name = document.getElementsByClassName("shop-title")[0].innerHTML;
        }
      
        if(shop_phone_info.length < 2){
            var shop_phone = "not exist";
        }
        else {
            var  shop_phone = document.getElementsByClassName("shop-info-content")[1].innerHTML;
        }
    
        if(document.getElementsByClassName("region")[0]== "undefined"){
            var shop_area = ""
        }else{
            var shop_area = document.getElementsByClassName("region")[0].innerHTML;
        }

        if(document.getElementsByClassName("shopDeal-Info-address")[0] == "undefined"){
            var shop_address = ""
        }else{
            var shop_address = document.getElementsByClassName("shopDeal-Info-address")[0].innerHTML.replace(/<[^>].*?>/g,"");
        }

        if(each_person_price_info[1] == "undefined"){
            each_person_price  == "";
        }else{
            var each_person_price = document.getElementsByTagName("dd")[1].innerHTML.replace(/<[^>].*?>/g,"");
        }

        if(document.getElementsByClassName("shop-detail-info")[0] == "undefined"){
            shop_detail_info== ""
            }
        else{
            var shop_detail_info = document.getElementsByClassName("shop-detail-info")[0].innerHTML.replace(/<[^>].*?>/g,"");
        }

        //  var body_info = document.body.innerHTML;
        // var shop_name = document.getElementsByClassName("shop-title")[0].innerHTML;
        //	 var  shop_phone = document.getElementsByClassName("shop-info-content")[1].innerHTML.replace(/<[^>].*?>/g,"");
        //   var shop_area = document.getElementsByClassName("region")[0].innerHTML;
        // var shop_address = document.getElementsByClassName("shopDeal-Info-address")[0].innerHTML.replace(/<[^>].*?>/g,"");
        // var cuisine = document.getElementsByClassName("")[0].innerHTML;
        	 var cuisine_info = document.getElementsByTagName("dt");
        //	 var each_person_price = document.getElementsByTagName("dd")[1].innerHTML.replace(/<[^>].*?>/g,"");
        //	 var shop_detail_info = document.getElementsByClassName("shop-detail-info")[0].innerHTML.replace(/<[^>].*?>/g,"");
        for(var count=0;count< cuisine_info.length;count++){
            if(cuisine_info[count].innerHTML == "标签:"){
                break;
            }
        }
        var cuisine = cuisine_info[count].innerHTML;
          
        var picture_info = document.getElementsByClassName("rec-slide-wrapper")[0];
        if(picture_info != null){
            var pictures = picture_info.innerHTML;
        }
        else{
            var pictures ="no pictures"
        }
        output = {
            'shop_name':shop_name,
            'shop_phone':shop_phone,
            'shop_address':shop_address,
            'cuisine':cuisine,
            'shop_detail_info':shop_detail_info,
            'pictures_url':pictures
        }
        return JSON.stringify(output);

        return shop_detail_info
    });
    if(information ==false){
        setTimeout("get_elements_info()",set_time_out_time);
    }
    else{
        console.log(information);
        phantom.exit();
    }
}
