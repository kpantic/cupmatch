// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

$(function(){
    $('.topbar').dropdown();
    $('.tabs').tabs();
    $('.dropdown input').bind('click', function (e) {
	e.stopPropagation()
    });
    updateRecentActivity();
});

var updateRecentActivity = function(){
    $("#activity-overlay").toggleClass("loading");
    $.getJSON('/activity.json',function(data){
	var items = [];
	$.each(data,function(key,val){
	    items.push('<li>'+val.user_email+' '+val.activity
		       +'d a '+val.model_type+'</li>');
	});
	$("#activity-list").html("");
	$("#activity-list").html(items.join(''));
	$("#activity-overlay").toggleClass("loading");
	setTimeout('updateRecentActivity()',30000);
    });
    
}
