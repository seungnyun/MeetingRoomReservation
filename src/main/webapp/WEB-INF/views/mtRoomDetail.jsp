<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<title>회의실 상세</title>
<script type="text/javascript">
	/* 회의실 삭제 */
	function fncDeleteMtRoom(mrNo){
		if(confirm("삭제 하시겠습니까?")){
			var loc = '/deleteMtRoom?searchCondition=1&mrNo=' + mrNo;
			location.href = loc;
		}
	}
</script>
</head>
<body>
	<div style="width:730px">
		<table border="0">
			<tr>
				<td width="700">
				<div class="wTableFrm">
					<h2>회의실 상세</h2>
					<table>
					<colgroup>
						<col style="width:25%"/>
						<col style="width:34%"/>
						<col style="width:16%"/>
						<col style=""/>
					</colgroup>
					<tr>
						<th>회의실 명<span class="pilsu">*</span></th>
						<td colspan="3"><c:out value="${mtRoomVO.mr_Name}"/></td>
					</tr>
					<tr>
						<th>수용인원<span class="pilsu">*</span></th>
						<td><c:out value="${mtRoomVO.capacity}"/>명</td>
						<th>개방시간<span class="pilsu">*</span></th>
						<td><c:out value="${mtRoomVO.start_Time}"/> ~ <c:out value="${mtRoomVO.end_Time}"/></td>
					</tr>
					<tr>
						<th>위치<span class="pilsu">*</span></th>
						<td colspan="1"><c:out value="${mtRoomVO.location}"/> <c:out value="${mtRoomVO.building}"/> <c:out value="${mtRoomVO.roomNo}"/></td>
					</tr>
					<!-- 첨부파일 테이블 레이아웃 설정 -->
					<c:if test="${!empty mtRoomVO.picture}">
						<tr>
							<th height="23" scope="row">이미지 파일</th>
							<td colspan="3">
								<img src="<c:url value='/resources/images/${mtRoomVO.picture}'/>" width="200" height="150" alt="">
							</td>
						</tr>
					</c:if>
		<!-- 첨부파일 테이블 레이아웃 End. /cmm/fms/selectFileInfs.do -->
		</table>
		<!-- 하단버튼 -->
		<div>
			<span><a href="<c:url value='/updateMtRoom'/>?searchCondition=1&mrNo=<c:out value='${mtRoomVO.mrNo}'/>">수정</a></span>
			<span><a href="#" onclick="fncDeleteMtRoom('${mtRoomVO.mrNo}'); return false;">삭제</a></span>
			<span><a href="<c:url value='/mtRoomList'/>?searchCondition=1">목록</a></span>
		</div>
		<div style="clear:both;"></div>
		</div></td></tr>
	</table>
</div>
</body>
</html>