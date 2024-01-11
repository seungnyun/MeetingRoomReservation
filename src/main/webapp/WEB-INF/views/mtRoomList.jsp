<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>회의실관리 목록</title>
	<script type="text/javascript" defer="defer">
		/* 회의실 목록 조회 */
		function fncSelectMtList(pageNo){
			document.listForm.searchCondition.value = "1";
			document.listForm.pageIndex.value = pageNo;
			document.listForm.action = "<c:url value='/mtRoomList'/>";
			document.listForm.submit();
		}
		
		/* 회의실 상세 조회 */
		function fncGetMtRoomManage(mtgPlaceId){
			document.item.mrNo.value = mtgPlaceId;
			document.item.action = "<c:url value='/getMtRoomManage'/>";
			document.item.submit();
		}
		
		/* 회의실 신규등록 화면 호출 */
		function fncInsertMtRoom(){
			if(document.listForm.pageIndex.value == ""){
				document.lsitForm.pageIndex.value = 1;
			}
			document.listForm.action = "<c:url value='/insertMtRoom'/>"
			document.item.submit();
		}
		
		/* 회의실 목록 조회 Enter키 처리 */
		function press(){
			if(event.keyCode==13){
				fncSelectMrList('1');
			}
		}
	</script>
</head>
<body>

	<div>
		<form name="listform" action="<c:url value='mtRoomlist'/>" method="post">
			<h1>회의실 관리목록</h1>
			<div title="회의실명">
				<ul>
					<li>
						<label for="">회의실명</label>
						<input name="searchKeyword" type="text" value='' size="25" onkeypress="press();" title=""/>
						<input type="submit" value="검색" title='"button.inquire"' onclick="fncSelectMtrList('1'); return flase;"/>
						<span><a href="/insertMtRoom?searchCondition=1" onclick="fncInsertMtRoom(); return false;" title="등록">등록</a></span>
					</li>
				</ul>	
			</div>
		</form>
		<table>
			<colgroup>
				<col style="width:7%"/>
				<col style="width:20%"/>
				<col style="width:25%"/>
				<col style="width:5%"/>
			</colgroup>
			<thead>
				<tr>
					<th scope="col">번호</th>
					<th scope="col">회의실명</th>
					<th scope="col">개방시간</th>
					<th scope="col">수용인원</th>
					<th scope="col">위치</th>
					<th scope="col">건물</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="mtRoom" items="${mtRoomList}" varStatus="status">
					<tr>
						<td><c:out value="${mtRoom.mrNo}"/></td>
						<td>
							<form name="item" method="post" action="<c:url value="mtRoomDetail"/>">
								<input type="hidden" name="mrNo" value="<c:out value="${mtRoom.mrNo}"/>">
								<span><input type="submit" value="<c:out value="${mtRoom.mr_Name}"/>" style="text-align : left;"></span>
							</form>
						</td>
						<td><c:out value="${mtRoom.start_Time}"/> ~ <c:out value="${mtRoom.end_Time}"/></td>
						<td><c:out value="${mtRoom.capacity}"/>명</td>
						<td><c:out value="${mtRoom.location}"/></td>
						<td><c:out value="${mtRoom.building}"/> &nbsp; <c:out value="${mtRoom.roomNo}"/></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</body>
</html>