<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<title>회의실 등록</title>
<script type="text/javascript">
	function fncMtRoomClear(){
		mtRoomForm.mr_Name.value = "";
    	mtRoomForm.capacity.value = 5;
    	mtRoomForm.start_Time.value = "08:00";
    	mtRoomForm.end_Time.value = "21:00";
    	mtRoomForm.location.value = "";
    	mtRoomForm.building.value = "";
    	mtRoomForm.roomNo.value = "";
	}

	function fncInsertMtRoom(){
		if(mtRoomForm.start_Time.value == ""){
			alert("개방 오픈 시간을 선택하세요");
			return false;
		}
		if(mtRoomForm.end_Time.value == ""){
			alert("개방 오픈 시간을 선택하세요");
			return false;
		}
		if(parseInt(mtRoomForm.start_Time.value.substring(0,2)) >= parseInt(mtRoomForm.end_Time.value.substring(0,2))){
			alert("개방 오픈 시간이 개방 종료 시간보다 늦거나 같습니다. 개방시간을 확인하세요.");
			return false;
		}
	
		return true;
	}
</script>
</head>
<body>
<form:form modelAttribute="mtRoomVO" name="mtRoomForm" method="post" action="updateMtRoom" onsubmit="return fncUpdateMtRoom()" enctype="multipart/form-data">
<input type="hidden" name="picture" value = "<c:out value='${mtRoomVO.picture}'/>">
<input type="hidden" name="mrNo" value = "<c:out value='${mtRoomVo.mrNO}'/>">
<div>
	<h2>회의실 수정</h2>
	<table>
		<colgroup>
			<col style="width:25%"/>
			<col style="width:34%"/>
			<col style="width:16%"/>
			<col style=""/>
		</colgroup>
		<tr>
			<th>회의실 명<span class="pilsu">*</span></th>
			<td colspan="3">
				<form:input path="mr_Name" title="${mrRoomVo.mr_Name}" required="required"/>
			</td>
		</tr>
		<tr>
			<th>수용가능인원<span class="pilsu">*</span></th>
			<td>
				<select name="capacity" title="수용가능인원">
					<option value="5" <c:if test="${mtRoomVO.capacity == '5'}"> selected </c:if>>5명</option>
					<option value="10" <c:if test="${mtRoomVO.capacity == '10'}"> selected </c:if>>10명</option>	
					<option value="15" <c:if test="${mtRoomVO.capacity == '15'}"> selected </c:if>>15명</option>	
					<option value="20" <c:if test="${mtRoomVO.capacity == '20'}"> selected </c:if>>20명</option>	
					<option value="25" <c:if test="${mtRoomVO.capacity == '25'}"> selected </c:if>>25명</option>	
					<option value="30" <c:if test="${mtRoomVO.capacity == '30'}"> selected </c:if>>30명</option>	
					<option value="50" <c:if test="${mtRoomVO.capacity == '50'}"> selected </c:if>>50명</option>	
					<option value="70" <c:if test="${mtRoomVO.capacity == '70'}"> selected </c:if>>70명</option>	
					<option value="100" <c:if test="${mtRoomVO.capacity == '100'}"> selected </c:if>>100명</option>	
				</select>
			</td>
			<th>개방시간<span class="pilsu">*</span></th>
			<td>
				<select name="start_Time" title="개방시작시간">
					<option value="08:00" <c:if test="${mtRoomVO.start_Time == '08:00'}"> selected </c:if>>08:00</option>
					<option value="09:00" <c:if test="${mtRoomVO.start_Time == '09:00'}"> selected </c:if>>09:00</option>
					<option value="10:00" <c:if test="${mtRoomVO.start_Time == '10:00'}"> selected </c:if>>10:00</option>
					<option value="11:00" <c:if test="${mtRoomVO.start_Time == '11:00'}"> selected </c:if>>11:00</option>
					<option value="12:00" <c:if test="${mtRoomVO.start_Time == '12:00'}"> selected </c:if>>12:00</option>
					<option value="13:00" <c:if test="${mtRoomVO.start_Time == '13:00'}"> selected </c:if>>13:00</option>
					<option value="14:00" <c:if test="${mtRoomVO.start_Time == '14:00'}"> selected </c:if>>14:00</option>
					<option value="15:00" <c:if test="${mtRoomVO.start_Time == '15:00'}"> selected </c:if>>15:00</option>
					<option value="16:00" <c:if test="${mtRoomVO.start_Time == '16:00'}"> selected </c:if>>16:00</option>
					<option value="17:00" <c:if test="${mtRoomVO.start_Time == '17:00'}"> selected </c:if>>17:00</option>
					<option value="18:00" <c:if test="${mtRoomVO.start_Time == '18:00'}"> selected </c:if>>18:00</option>
					<option value="19:00" <c:if test="${mtRoomVO.start_Time == '19:00'}"> selected </c:if>>19:00</option>
					<option value="20:00" <c:if test="${mtRoomVO.start_Time == '20:00'}"> selected </c:if>>20:00</option>
					<option value="21:00" <c:if test="${mtRoomVO.start_Time == '21:00'}"> selected </c:if>>21:00</option>
				</select>
				~
				<select name="end_Time" title="개방종료시간">
					<option value="08:00" <c:if test="${mtRoomVO.end_Time == '08:00'}"> selected </c:if>>08:00</option>
					<option value="09:00" <c:if test="${mtRoomVO.end_Time == '09:00'}"> selected </c:if>>09:00</option>
					<option value="10:00" <c:if test="${mtRoomVO.end_Time == '10:00'}"> selected </c:if>>10:00</option>
					<option value="11:00" <c:if test="${mtRoomVO.end_Time == '11:00'}"> selected </c:if>>11:00</option>
					<option value="12:00" <c:if test="${mtRoomVO.end_Time == '12:00'}"> selected </c:if>>12:00</option>
					<option value="13:00" <c:if test="${mtRoomVO.end_Time == '13:00'}"> selected </c:if>>13:00</option>
					<option value="14:00" <c:if test="${mtRoomVO.end_Time == '14:00'}"> selected </c:if>>14:00</option>
					<option value="15:00" <c:if test="${mtRoomVO.end_Time == '15:00'}"> selected </c:if>>15:00</option>
					<option value="16:00" <c:if test="${mtRoomVO.end_Time == '16:00'}"> selected </c:if>>16:00</option>
					<option value="17:00" <c:if test="${mtRoomVO.end_Time == '17:00'}"> selected </c:if>>17:00</option>
					<option value="18:00" <c:if test="${mtRoomVO.end_Time == '18:00'}"> selected </c:if>>18:00</option>
					<option value="19:00" <c:if test="${mtRoomVO.end_Time == '19:00'}"> selected </c:if>>19:00</option>
					<option value="20:00" <c:if test="${mtRoomVO.end_Time == '20:00'}"> selected </c:if>>20:00</option>
					<option value="21:00" <c:if test="${mtRoomVO.end_Time == '21:00'}"> selected </c:if>>21:00</option>
				</select>
			</td>
		</tr>
		<tr>
			<th>위치<span class="pilsu">*</span></th>
			<td colspan="3">
				<form:input path="location" title="${mtRoomVO.location}" cssStyle="width:509px" required="required"/>
				<form:input path="building" title="${mtRoomVO.building}" cssStyle="width:509px" required="required"/>
				<form:input path="roomNo" title="${mtRoomVO.roomNo}" cssStyle="width:509px" required="required"/>
			</td>
		</tr>
		<!-- 첨부파일 테이블 레이아웃 설정 -->
		<c:if test="${!empty mtRoomVO.picture}">
			<tr>
				<th height="23" class="required_text" scope="row">이미지 파일</th>
				<td colspan="3">
					<img src="<c:url value='/resources/images/${mtRoomVO.picture}'/>" width="200" height="150" alt="">
				</td>
			</tr>
		<!-- 첨부파일 테이블 레이아웃 End. /cmm/fms/selectFileInfs.do -->
		</c:if>
		<tr>
			<th>이미지 파일수정</th>
			<td colspan="3">
				<input name="file_1" id="egovComFileUpLoader" type="file" title="첨부파일"/>
				<div id="egovComFileUpLoader"></div>
			</td>
		</tr>
	</table>
	
	<!-- 하단 버튼 -->
	<div>
		<input type="submit" value="저장"/>
		<span><a href="<c:url value='/mtRoomList'/>?searchCondition=1">목록</a></span>
		<div style="clear:both;"></div>
	</div>
	
</form:form>	
</div>
</body>
</html>