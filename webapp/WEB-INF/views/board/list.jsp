<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>mysite</title>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<link href="${pageContext.request.contextPath}/assets/css/board.css"
	rel="stylesheet" type="text/css">
</head>
<body>
	<div id="container">

		<!-- /header -->
		<c:import url="/WEB-INF/views/includes/header.jsp"></c:import>

		<!-- /navigation -->
		<c:import url="/WEB-INF/views/includes/navigation.jsp"></c:import>


		<div id="content">
			<div id="board">
				<form id="search_form" action="${pageContext.request.contextPath}/board/list" method="get">
					<input type="text" id="kwd" name="kwd" value="">
					<input type="submit" value="찾기">
					<input type="hidden" name="crtPage" value="${bMap.crtPage}"> 
				</form>
				<table class="tbl-ex">
					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>글쓴이</th>
						<th>조회수</th>
						<th>작성일</th>
						<th>&nbsp;</th>
					</tr>

					<c:forEach items="${bMap.boardList}" var="boardVo">
						<tr>
							<td>${boardVo.no}</td>
							<!-- /board/view/${list.no}로 PathVariable 값 넘길 때 넘기는 방법 약간 다르다는 것 기억 -->
							<td><a
								href="${pageContext.request.contextPath}/board/view/${boardVo.no}">${boardVo.title}</a></td>
							<td>${boardVo.name}</td>
							<td>${boardVo.hit}</td>
							<td>${boardVo.regDate}</td>
							<td><c:if test="${authUser.no==boardVo.userNo}"> <!-- 로그인 사용자의 번호와 게시물 작성자 번호가 같다면 -->
									<a
										href="${pageContext.request.contextPath}/board/delete?no=${boardVo.no}"
										class="del">삭제</a>
								</c:if></td>
						</tr>
					</c:forEach>

				</table>
				<div class="pager">
					<ul>
						<c:if test="${bMap.prev}"> <!-- 이 값이 false라면 prev 실행 x -->
							<li><a href="${pageContext.request.contextPath}/board/list?crtPage=${bMap.startPageBtnNo-1}">◀</a></li>
						</c:if>
						
						<c:forEach begin="${bMap.startPageBtnNo}" end="${bMap.endPageBtnNo}" var="idx">
							<li><a href="${pageContext.request.contextPath}/board/list?crtPage=${idx}">${idx}</a></li>
						</c:forEach>
						
						<c:if test="${bMap.next}"> <!-- 이 값이 false라면 next 실행 x -->
							<li><a href="${pageContext.request.contextPath}/board/list?crtPage=${bMap.endPageBtnNo+1}">▶</a></li>
						</c:if>
					</ul>
				
				</div>
				<c:if test="${not empty authUser}">
					<div class="bottom">
						<a href="${pageContext.request.contextPath}/board/writeform" id="new-book">글쓰기</a>
					</div>
				</c:if>
			</div>
		</div>

		<!-- /footer -->
		<c:import url="/WEB-INF/views/includes/footer.jsp"></c:import>
	</div>
</body>
</html>