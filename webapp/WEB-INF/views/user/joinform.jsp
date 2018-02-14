<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${pageContext.request.contextPath}/assets/css/user.css"
	rel="stylesheet" type="text/css">

<script type="text/javascript"
	src="${pageContext.request.contextPath}/assets/js/jquery/jquery-1.12.4.js"></script> <!-- 경로 처리 유의할 것. -->
<title>Insert title here</title>
</head>
<body>

	<div id="container">

		<!-- /header -->
		<c:import url="/WEB-INF/views/includes/header.jsp"></c:import>

		<!-- /navigation -->
		<c:import url="/WEB-INF/views/includes/navigation.jsp"></c:import>

		<div id="wrapper">
			<div id="content">
				<div id="user">

					<form id="join-form" name="joinForm" method="get"
						action="${pageContext.request.contextPath}/user/join">

						<label class="block-label" for="name">이름</label> 
						<input id="name" name="name" type="text" value=""> 
						<label class="block-label" for="email">이메일</label> 
						<input id="email" name="email" type="text" value=""> 
						<input id="emailchk" type="button" value="id 중복체크"> 
						<div id="chkMessage"></div>
						
						<label class="block-label">패스워드</label>
						<input id="password" name="password" type="password" value="">
						<div id="chkPassword"></div>

						<fieldset>
							<legend>성별</legend>
							<label>여</label> <input type="radio" name="gender" value="female"
								checked="checked"> <label>남</label> <input type="radio"
								name="gender" value="male">
						</fieldset>

						<fieldset>
							<legend>약관동의</legend>
							<input id="agree-prov" type="checkbox" name="agreeProv" value="y">
							<label>서비스 약관에 동의합니다.</label>
						</fieldset>

						<input type="submit" value="가입하기">

					</form>

				</div>
				<!-- /user -->
			</div>
			<!-- /content -->
		</div>
		<!-- /wrapper -->

		<!-- /footer -->
		<c:import url="/WEB-INF/views/includes/footer.jsp"></c:import>

	</div>
	<!-- /container -->

</body>

<script type="text/javascript"> <!-- 자바스크립트 코드가 브라우저로 텍스트로 내려가서, 해석됨. -->
$("#emailchk").on("click", function() {
	var email=$("#email").val();//email에 입력한 값을 클릭할 때, 빼내보자
	//빼낸 값을 DispatcherController에 전송하는 작업
	var userVo = {
				email: email,
				password: 1111				
		}
	console.log(email); //항상 console로 email 변수가 유효한지 테스트
	
	$.ajax({ //이 작업은 비동기로 데이터를 보내는 것임. 요청문서에 email값이 있어야 함.
		url : "${pageContext.request.contextPath}/user/api/emailchk",		
		type : "post", //post로 대부분 씀.
		//contentType : "application/json", //이것은 아직 사용안함. 주석처리.
		data : {email:email}, //앞에 email은 텍스트, 뒤 email은 위에서 입력 받은 변수 email
		//data : JSON.stringify(userVo), //넘길 데이터가 email하나가 아닌 여러개인 경우, jsp->servlet 줄 때
		
		//dataType : "json", 이것도 기존방식에서는 아직 사용안함, servlet->jsp 받을 때
		success : function(result){ //result를 우리는 true, false로 함.
			/*성공시 처리해야될 코드 작성*/
			console.log(result) //contrller로부터 제대로 값을 받아, 오는지 테스트
			if(result==true) {
				$("#chkMessage").text("사용 가능한 이메일입니다.");
			} else {
				$("#chkMessage").html("<font color=\"red\">사용중인 이메일입니다.</font>");
			}
		},
		error : function(XHR, status, error) {
			console.error(status + " : " + error); //실패(통신장애, 시도조차 안된 경우)했을 때, 처리해야할 코드 작성
		}
	});
});

$("#password").keyup(function(){
	var pw = $("[name=password]").val();
	var check = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,20}$/;
	if(!check.test(pw)) {
		$("#chkPassword").html("<font color=\"red\">8~20자의 영문대소문자, 숫자 및 특수문자 사용</font>");
	} else {
		$("#chkPassword").text("사용 가능한 비밀번호입니다.");
	}
});
</script>

</html>