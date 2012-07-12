//get'name','language','number of members','description'
var page = require('webpage').create();
page.settings.userAgent = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_6_8) AppleWebKit/535.19 (KHTML, like Gecko) Chrome/18.0.1025.163 Safari/535.19';

page.onLoadStarted = function(){
        console.log('Start loading...');
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

page.open("http://www.dianping.com/search/category/4/10/g363r22",function(status){
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
         var body_info = document.body.innerHTML;

            return body_info;
            };
        return information;
    });
    if(information ==false){
        setTimeout("get_elements_info()",set_time_out_time);
    }
    else{
        console.log(information);
        phantom.exit();
    }
}

