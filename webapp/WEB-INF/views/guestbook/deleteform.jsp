<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${pageContext.request.contextPath}/assets/css/guestbook.css"
	rel="stylesheet" type="text/css">
<title>GuestBook</title>
</head>
<body>
	<div id="container">

		<!-- /header -->
		<c:import url="/WEB-INF/views/includes/header.jsp"></c:import>

		<!-- /navigation -->
		<c:import url="/WEB-INF/views/includes/navigation.jsp"></c:import>

		<div id="wrapper">
			<div id="content">
				<div id="guestbook" class="delete-form">
					<form method="post"
						action="${pageContext.request.contextPath}/guestbook/delete">
						<input type="text" name="no" value="${requestScope.no}"> 번 글 <br>
						비밀번호 : <input type="password" name="password"> 
						<input type="submit" value="확인"> 
						<a href="${pageContext.request.contextPath}/guestbook/list">메인으로
							돌아가기</a>
					</form>
				</div>
			</div>
		</div>
		<!-- /footer -->
		<c:import url="/WEB-INF/views/includes/footer.jsp"></c:import>
	</div>
</body>
</html>