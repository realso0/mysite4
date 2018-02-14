<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${pageContext.request.contextPath}/assets/css/guestbook.css"
	rel="stylesheet" type="text/css">
<link
	href="${pageContext.request.contextPath}/assets/bootstrap/css/bootstrap.min.css"
	rel="stylesheet" type="text/css">
<script type="text/javascript"
	src="${pageContext.request.contextPath}/assets/js/jquery/jquery-1.12.4.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/assets/bootstrap/js/bootstrap.min.js"></script>

<!-- 경로 처리 유의할 것. -->
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
					<!--<form action="${pageContext.request.contextPath}/guestbook/add"
						method="post"> 화면 이동하므로, 없애주고 console확인-->
						<!-- jstl 문법 다 없애기 -->
						<table>
							<tr>
								<td>이름</td>
								<td><input id="name" type="text" name="name"
									value="${sessionScope.authUser.name}"></td>
								<td>비밀번호</td>
								<td><input id="password" type="password" name="password"></td>
								<!-- input의 name과 vo변수이름이 같아야 읽어옴. -->
							</tr>
							<tr>
								<td colspan=4><textarea class="content" name="content" id="content"></textarea></td>
							</tr>
							<tr>
								<td colspan=4 align=right><input id="btnInsert" type="submit" VALUE=" 확인 "></td>
							</tr>
						</table>

					<!-- </form> -->

					<ul id="listArea">

					</ul>
					<center>
						<input id="btnNext" type="button" value="더보기">
					</center>
				</div>
			</div>
		</div>
		<!-- /footer -->
		<c:import url="/WEB-INF/views/includes/footer.jsp"></c:import>
	</div>

	<!-- 삭제팝업(모달)창 -->
	<div class="modal fade" id="del-pop">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title">방명록삭제</h4>
				</div>
				<div class="modal-body">
					<input type="text" name="modalPassword" value="" id="modalNo">
					<br> <label>비밀번호</label> <input type="password" name="modalPassword" id="modalPassword"><br>
					<div id="message" ></div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
					<!-- data-dismiss="modal"을 통해 모든 모달창 닫기 -->
					<button type="button" class="btn btn-danger" id="btn_del" data-dismiss="modal">삭제</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- /.modal -->

</body>

<script type=text/javascript>
<!-- 비동기 방식 사용을 위해, dom을 생성 -->
	var page = 1;
	$(document).ready(function() {//페이지의 내용이 로딩되기 이전에 데이터 요청

		fetchList();
	}); //jsp화면을 뿌려주기 전에 2번 읽고, 한 번은 읽어서 전부 객체로 바꿔주고, 두번 째에 전부 읽기 전에 fetchList를 뿌려주어 읽음.
	
	// 클릭시 페이지 5개씩 내려가는 이벤트
	$("#btnNext").on("click", function() {
		page = page + 1; //page+=1;
		console.log(page);

		fetchList();
	});

	//스크롤 이벤트
	$(window).on("scroll", function() { //좌표를 찍어서 windowTop의 좌표가  document의 좌표와 같아지면 페이지가 5개씩 더 뿌려짐.
		console.log($(window).scrollTop()+"/"+$(document).height()+"/"+$(window).height());
		
		if($(window).scrollTop()==$(document).height()-$(window).height()) {
			page = page + 1; //page+=1;
			console.log(page);
	
			fetchList();
		}
	});

	function fetchList() {
		$.ajax({//리스트 요청
			url : "${pageContext.request.contextPath}/guestbook/api/list",
			type : "post",
			data : {
				page : page
			}, //데이터를 줄 때 parameter

			dataType : "json", //데이터를 받을때 리턴타입 , json은 문자열임(객체, 맵처럼 쌍으로 묶어 받음.)
			success : function(glist) {
				console.log(glist); //glist가 콘솔창에 도착했는지 테스트, 여기까지 성공했다면, 위에 주석처리 한 것을 하나하나 

				for (var i = 0; i < glist.length; i++) {
					render(glist[i], "down");
				}

			},
			error : function(XHR, status, error) {
				console.error(status + " : " + error);
			}
		});
	};

	function render(guestbookVo, updown) {
		var str = "";
		str += "<li id='g"+guestbookVo.no+"'>";
		str += "	<table>";
		str += "			<tr>";
		str += "				<td>[" + guestbookVo.no + "]</td>";
		str += "				<td>" + guestbookVo.name + "</td>";
		str += "				<td>" + guestbookVo.regDate + "</td>";
		str += "				<td><div><input class='delete' id='" + guestbookVo.no + "' type='button' value='삭제' data-no='"+guestbookVo.no+"'><div></td>";
		str += "			</tr>";
		str += "			<tr>";
		str += "				<td colspan=4>" + guestbookVo.content + "</td>";
		str += "			</tr>";
		str += "		</table>";
		str += "	<br>";
		str += "</li>";

		if (updown == "up") {
			$("#listArea").prepend(str);
		} else if (updown == "down") {
			$("#listArea").append(str);
		} else {
			console.log("update 오류");
		}
	};
	
	$("#btnInsert").on("click", function(){
		console.log("btnInsert");
		
		var name = $("#name").val();
		var password = $("#password").val();
		var content = $(".content").val(); //클래스 만들어주기.
		
		var guestbookVo = {
				name:name,
				password:password,
				content:content
		}; //데이터를 줄 때 parameter, vo값 만들어줄 때도 세미콜론 잊지말기.
		//console.log(guestbookVo);
		$.ajax({
			//보내기
			url : "${pageContext.request.contextPath}/guestbook/api/addAjax",
			type : "post",
			contentType : "application/json", //json 형태로 바디에 담아 보내겠다고 타입 지정함.
			data : JSON.stringify(guestbookVo), //json으로 보낼 때는 문자형으로 보내야, 짜를수 있음(파싱해주기)
			//stringify를 해줘야, 바디에 담아 보낼수 있음.
			/*json으로 보내고, 받지 않는다면, contentType, dataType은 안 써줘도 되며, data=guestbookVo로 해주고, 
			Controller에서는 @RequestBody가 아닌 기존 방식대로, @ModelAttribute 해주면 됨.*/
			//받기
			dataType : "json", //데이터를 받기 위한 리턴타입 , json으로 리턴받는데, json은 문자열임(객체, 맵처럼 쌍으로 묶어 받음.)
			success : function(guestbookVo){ //리턴 받은 데이터 그대로 사용.
			/*성공시 처리해야될 코드 작성*/
				console.log(guestbookVo); //guestbookVo가 콘솔창에 도착했는지 테스트
				var no = guestbookVo.no;
				
				selectList(no);
				
				$("[name=name]").val(""); //기존에 작성했던 글 다시 공백으로 바꿔주기.
				$("[name=password]").val("");
				$("[name=content]").val("");
			},
			
			error : function(XHR, status, error) {
				console.error(status + " : " + error);
			}
			
		});
	}); 
	
	//db로부터 값 가져오면서 regDate까지 가져옴.
	//render함수로 맨위에 붙이기.
	function selectList(no) { //어떤 사용자 정의함수 든, 세미콜론으로 닫아주기.
		$.ajax({
			//보내기
			url : "${pageContext.request.contextPath}/guestbook/api/selectListAjax",
			type : "post",
			//contentType : "application/json", json형태가 아닌 일반형태로 보내기
			data :{no: no}, //기존방식으로 보내기, 기존방식으로 보낸 값을 Controller에서 받는 방법에는 @RequestParam, @ModelAttribute 2가지가 있음.

			//받기
			dataType : "json",
			success : function(writeListAjax){
			/*성공시 처리해야될 코드 작성*/
				render(writeListAjax,"up")
			},

			error : function(XHR, status, error) {
				console.error(status + " : " + error);
			}

			});
	};
	
	//ul로 묶어서, delete 클릭시, 모달폼에 no값 넣어주기.
	$("ul").on("click",".delete", function(){ //class는 여러개여도 됨. ul묶음 안에서 btnDel을 누르면, #listArea 로도 동작가능함.(새로고침 안 했으므로, 부모에게 명령해야 삭제 모달이 뜸)
		//var no1=$(this).data("no"); //no를 가져오는 또 다른 방법. 태그 값으로 data-no에 값 지정해두면 쉽게 가져올 수 있음.
		//console.log(no1);
		var no = this.id; //id는 고유값(하나여야 함.)
		console.log(no);
		$("#del-pop").modal();
		$("#modalNo").val(no); //no값을 modalNo에 입력
	});
	
	//modal 안에 삭제버튼 클릭시 apiController에 전송
	$("#btn_del").on("click", function(){
		var no=$("#modalNo").val();
		var guestbookVo = {
				no : $("#modalNo").val(),
				password : $("#modalPassword").val()
		}; // no와 password를 guestbookVo에 저장

		console.log(guestbookVo)
		$.ajax({
			//보내기
			url : "${pageContext.request.contextPath}/guestbook/api/deleteAjax",
			type : "post",
			contentType : "application/json", //json타입으로, 바디에 넣어보냄.
			data : JSON.stringify(guestbookVo),

			//받기
			dataType : "json",
			success : function(count) {
				if(count==1){
					console.log(count+"개 제거 완료")
					
					$("#g" + no).remove(); //li마다 id를 주어, 번호에 해당하는 id를 삭제(페이지에 없앤 값 반영하기)
					//$("#del-pop").modal("hide");
					/* $("[id="+no+"]").remove(); */
	     			//window.location.reload(true);//새로고침1번 
				//}else {
				//	console.log("제거 실패");
				//	$("#message").html("<font color=\"red\">잘못된 비밀번호입니다.</font>");
				}
			},
			error : function(XHR, status, error) {
				console.error(status + " : " + error);
			}
		});
		
		$("#modalPassword").val(""); //모달에 남아있는 비밀번호 값 없애기
	});
	
	
</script>

</html>