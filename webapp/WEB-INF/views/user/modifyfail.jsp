<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link href="${pageContext.request.contextPath}/assets/css/user.css" rel="stylesheet" type="text/css">
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
					
					<p class="jr-fail">
						회원정보 수정에 실패하였습니다. 다시 시도해주세요.
						<br><br>
						<a href="${pageContext.request.contextPath}/user/modifyform">회원정보 수정하기</a>
					</p>
					
				</div><!-- /user -->
			</div><!-- /content -->
		</div><!-- /wrapper -->
		
		<!-- /footer -->
		<c:import url="/WEB-INF/views/includes/footer.jsp"></c:import>
		
	</div> <!-- /container -->

</body>
</html>