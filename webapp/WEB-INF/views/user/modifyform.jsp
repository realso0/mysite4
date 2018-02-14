<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link href="${pageContext.request.contextPath}/assets/css/user.css" rel="stylesheet" type="text/css">
	<script type="text/javascript"
	src="${pageContext.request.contextPath}/assets/js/jquery/jquery-1.12.4.js"></script>
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
	
					<form id="join-form" name="joinForm" method="post" action="${pageContext.request.contextPath}/user/modify">

						
						<label class="block-label" for="name">이름</label>
						<input id="name" name="name" type="text" value="${requestScope.userVo.name}" />
	
						<label class="block-label" for="email">이메일</label>
						<strong>${requestScope.userVo.email}</strong> <!-- 못바꾸게 하기 위해서 input이 없음. -->
						
						<label class="block-label">패스워드</label>
						<input id="password" name="password" type="password" value="${requestScope.userVo.password}" />
						<div id="chkPassword"></div>
						
						<fieldset>
							<legend>성별</legend>
							<c:if test="${requestScope.userVo.gender=='male'}">
							<label>여</label> <input type="radio" name="gender" value="female" >
							<label>남</label> <input type="radio" name="gender" value="male" checked="checked">
							</c:if>
							<c:if test="${requestScope.userVo.gender=='female'}">
							<label>여</label> <input type="radio" name="gender" value="female" checked="checked">
							<label>남</label> <input type="radio" name="gender" value="male">
							</c:if>
						</fieldset>
						<input type="submit" value="수정완료">
					</form>
				</div><!-- /user -->
			</div><!-- /content -->
		</div><!-- /wrapper -->
		
		<!-- /footer -->
		<c:import url="/WEB-INF/views/includes/footer.jsp"></c:import>
		
	</div> <!-- /container -->

</body>

<script type="text/javascript"> <!-- 자바스크립트 코드가 브라우저로 텍스트로 내려가서, 해석됨. -->
/* $("#btnPass").on("click", function(){
	var password = $("#password").val();
	console.log(password);
	
	check();
}); */
$("#password").keyup(function(){
		var pw = $("#password").val();
		var check = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,20}$/;
		if(!check.test(pw)) {
			$("#chkPassword").html("<font color=\"red\">8~20자의 영문대소문자, 숫자 및 특수문자 사용</font>");
		} else {
			$("#chkPassword").text("사용 가능한 비밀번호입니다.");
		}
});

</script>

</html>