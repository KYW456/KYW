<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="currentPage" value="${requestScope.currentPage}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
<!-- 상대경로로 대상 파일의 위치를 지정한 경우 -->
<c:import url="../common/menubar.jsp" />
<hr>
<h2 align="center">${requestScope.board.board_num} 번 게시글 상세보기</h2>
<br>
<table align="center" width="500" border="1" cellspacing="0" cellpadding="5">
	<tr><th>제목</th><td>${board.board_title}</td></tr>
	<tr><th>작성자</th><td>${board.board_writer}</td></tr>
	<tr><th>날짜</th>
		<td><fmt:formatDate value="${board.board_date}" type="date" pattern="yyyy-MM-dd"/></td>
	</tr>
	<tr><th>첨부파일</th>
		<td>
			<!-- 첨부파일이 있다면 파일명 클릭시 다운로드 실행 처리 -->
			<c:if test="${!empty board.board_original_filename}">
				<c:url var="bfd" value="/bfdown.do">
					<c:param name="ofile" value="${board.board_original_filename}" />
					<c:param name="rfile" value="${board.board_rename_filename}" />
				</c:url>
				<a href="${bfd}">${board.board_original_filename}</a>
			</c:if>
			<!-- 첨부파일이 없다면 공백 처리 -->
			<c:if test="${empty board.board_original_filename}">
				&nbsp;
			</c:if>
		</td>
	</tr>
	<tr><th>내용</th><td>${board.board_content}</td></tr>
	<tr><th colspan="2">
		<button onclick="javascript:location.href='blist.do?page=${currentPage}';">목록</button>
		&nbsp;
		<!-- 글 작성자가 아닌 로그인 회원인 경우 댓글달기 버튼 -->
		<c:if test="${requestScope.board.board_writer ne sessionScope.loginMember.userid}">
			<c:url var="brf" value="/breplyform.do">
				<c:param name="board_num" value="${board.board_num}" />
				<c:param name="page" value="${currentPage}" />
			</c:url>
			<a href="${brf}">[댓글달기]</a> &nbsp;
		</c:if>
		<!-- 본인이 등록한 게시글일 때는 수정과 삭제 기능 제공 -->
		<c:if test="${requestScope.board.board_writer eq sessionScope.loginMember.userid}">
			<c:url var="bup" value="/bupview.do">
				<c:param name="board_num" value="${board.board_num}" />
				<c:param name="page" value="${currentPage}" />
			</c:url>
			<a href="${bup}">[수정페이지로 이동]</a> &nbsp;
			
			<c:url var="bdel" value="/bdel.do">
				<c:param name="board_num" value="${board.board_num}" />
				<c:param name="board_lev" value="${board.board_lev}" />
				<c:param name="board_rename_filename" value="${board.board_rename_filename}" />
			</c:url>
			<a href="${bdel}">[글삭제]</a> &nbsp;
		</c:if>
	</th></tr>
</table>
<br>
<hr>
<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>





