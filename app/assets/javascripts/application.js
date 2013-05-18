// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require_tree .

$(document).ready(function(){
	$("a.tag").click(function(){
		if(location.href.match(/tag_filter/)){
			var params = location.href.split("\?tags\=")
			params = params[1].split(',');
			var tag = $(this).text();
			if(params.indexOf(tag)!=-1){
				params.splice(params.indexOf(tag),1);
			}else{
				params.push(tag);
			}
			var args = params.join(',');
			if(args.match(/^,/)){
				args = args.substring(1);
			}
			$(this).attr("href",$(this).attr("href")+'?tags='+args);
		}else{
			$(this).attr("href",$(this).attr("href")+'?tags='+$(this).text());
		}
  });
});

function add_comentario(post_id){
	$("#add_comentario").show();
	var form = $("form","#add_comentario");
	$("input[type=hidden][name=post_id]").val(post_id);
}
