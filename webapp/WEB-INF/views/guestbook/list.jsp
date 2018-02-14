<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${pageContext.request.contextPath}/assets/css/guestbook.css" rel="stylesheet"
	type="text/css">
<title>Mysite</title>
</head>
<body>
	<div id="container">

		<!-- /header -->
		<c:import url="/WEB-INF/views/includes/header.jsp"></c:import>
			
		<!-- /navigation -->
		<c:import url="/WEB-INF/views/includes/navigation.jsp"></c:import>
		
		<div id="wrapper">
			<div id="content">
				<div id="guestbook">
					<form action="${pageContext.request.contextPath}/guestbook/add"
						method="post">
						<!-- jstl 문법 다 없애기 -->
						<table>
							<tr>
								<td>이름</td>
								<td><input type="text" name="name"
									value="${sessionScope.authUser.name}"></td>
								<td>비밀번호</td>
								<td><input type="password" name="password"></td>
								<!-- input의 name과 vo변수이름이 같아야 읽어옴. -->
							</tr>
							<tr>
								<td colspan=4>
										<textarea name="content" id="content"></textarea></td>
							</tr>
							<tr>
								<td colspan=4 align=right><input type="submit" VALUE=" 확인 "></td>
							</tr>
						</table>
					</form>
						<ul>
						<c:forEach items="${requestScope.elist}" var="list">

						<table>
							<tr>
								<td>${list.no}</td>
								<td>${list.name}</td>
								<td>${list.regDate}</td>
								<td><a href="${pageContext.request.contextPath}/guestbook/deleteform?no=${list.no}">삭제</a></td>
							</tr>
							<tr>
								<td colspan=4>
								<div class="view-content"> <!-- 치환 한 것 기억 -->
								${fn:replace(list.content , ctrl, "</br>" )}
								</div>
								</td>
							</tr>
						</table>
						<br />
						</c:forEach>
						</ul>
				</div>
			</div>
		</div>
		<!-- /footer -->
		<c:import url="/WEB-INF/views/includes/footer.jsp"></c:import>
	</div>
</body>

</html>