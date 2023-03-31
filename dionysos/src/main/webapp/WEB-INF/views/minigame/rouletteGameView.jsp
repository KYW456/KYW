﻿<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML>
<html lang="ko">
<head>
<title>룰렛 게임</title>
<meta charset="utf-8">
<script type="text/javascript" src="resources/js/jquery-1.11.3.min.js"></script>
<script>
var $j1113 = jQuery.noConflict();
</script>
<script type="text/javascript" src="resources/js/jQueryRotateCompressed.js"></script>
<style>
#image{
  margin:50px 50px;z-index:10;
}
#n_id{position:absolute;left:564px;top:860px;z-index:20;}
</style>
</head> 
<body>
<c:import url="/WEB-INF/views/common/menubar.jsp" />
<br>
<center>
<img src="resources/images/roulette.png" id="image">
<img src="resources/images/niddle.png" id="n_id">
<br>
<input type='button' value='START' id='start_btn'></input>
<div id="result_id"></div>
<div id="result_id2"></div>
<div id="result_id3"></div>
<script>
window.onload = function(){
	
	var pArr = ["0","1","2","3","4:꽝","5","6","7","8","9"];

	$j1113('#start_btn').click(function(){
		rotation();
	});

	function rotation(){
		$j1113("#image").rotate({
		  angle:0,
		  animateTo:360 * 5 + randomize(0, 360),
		  center: ["50%", "50%"],
		  easing: $j1113.easing.easeInOutElastic,
		  callback: function(){ 
						var n = $j1113(this).getRotateAngle();
						endAnimate(n);
					},
		  duration:5000
	   });
	}
	
	function endAnimate($n){
		var n = $n;
		$('#result_id').html("<p>움직인 각도:" + n + "</p>");
		var real_angle = n%360 +18;
		var part = Math.floor(real_angle/36);
	
		$('#result_id2').html("<p>상품범위:" + part + "</p>");

		if(part < 1){
			$('#result_id3').html("<p>당첨내역:" + pArr[0] + "</p>");
			return;
		}

		if(part >= 10){
			$('#result_id3').html("<p>당첨내역:" + pArr[pArr.length-1] + "</p>");
			return;
		}

		$('#result_id3').html("<p>당첨내역:" + pArr[part] + "</p>");
	}

	function randomize($min, $max){
		return Math.floor(Math.random() * ($max - $min + 1)) + $min;
	}
};
</script>
</center>
<br>
<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>
