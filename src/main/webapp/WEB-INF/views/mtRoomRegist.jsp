<%@ page contentType="text/html; charset=utf-8"%>
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
		function checkMsg(){
			var msgCode = "${msgCode}";
			if(msgCode != "") alert(msgcode);
		}
	</script>
</head>
<body onload="checkMsg()">
	<form:form modelAttribute="mtRoomVO" name="mtRoomForm" method="post" action="insertMtRoom" onsubmit="return fncInsertMtRoom()" enctype="multipart/form-data">
		<div>
			<h2>회의실 등록</h2>
			<table>
				<colgroup>
					<col style="width:25%"/>
					<col style="width:34%"/>
					<col style="width:16%"/>
					<col style=""/>
				</colgroup>
				<tr>
					<th>회의실명<span class="pilsu">*</span></th>
					<td class="left" colspan="3"><form:input path="mr_Name" title="회의실명" required="required"/></td>
				</tr>
				<tr>
					<th>수용인원<span class="pilsu">*</span></th>
					<td>
						<select name="capacity" title="수용가능인원">
							<option value="0">선택하세요</option>
							<option value="5" selected>5명</option>
							<option value="10">10명</option>
							<option value="15">15명</option>
							<option value="20">20명</option>
							<option value="25">25명</option>
							<option value="30">30명</option>
							<option value="50">50명</option>
							<option value="70">70명</option>
							<option value="100">100명</option>
						</select>
					</td>
					<th>개방시간<span class="pilsu">*</span>
					<td>
						<select name="start_Time" title="개방시작시간">
							<option value="">선택하세요</option>
							<option value="08:00" selected>08:00</option>
							<option value="09:00">09:00</option>
							<option value="10:00">10:00</option>
							<option value="11:00">11:00</option>
							<option value="12:00">12:00</option>
							<option value="13:00">13:00</option>
							<option value="14:00">14:00</option>
							<option value="15:00">15:00</option>
							<option value="16:00">16:00</option>
							<option value="17:00">17:00</option>
							<option value="18:00">18:00</option>
							<option value="19:00">19:00</option>
							<option value="20:00">20:00</option>
							<option value="21:00">21:00</option>
						</select>
						~
						<select name="end_Time" title="개방종료시간">
							<option value="">선택하세요</option>
							<option value="08:00">08:00</option>
							<option value="09:00">09:00</option>
							<option value="10:00">10:00</option>
							<option value="11:00">11:00</option>
							<option value="12:00">12:00</option>
							<option value="13:00">13:00</option>
							<option value="14:00">14:00</option>
							<option value="15:00">15:00</option>
							<option value="16:00">16:00</option>
							<option value="17:00">17:00</option>
							<option value="18:00">18:00</option>
							<option value="19:00">19:00</option>
							<option value="20:00">20:00</option>
							<option value="21:00" selected>21:00</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>위치<span class="pilsu">*</span></th>
					<td colspan="1">
						<form:input path="location" title="위치" cssStyle="width:509px" placeholder="지역" requried="true"/>
						<form:input path="building" title="건물" cssStyle="width:509px" placeholder="건물" requried="true"/>
						<form:input path="roomNo" title="층: 방번호" cssStyle="width:509px" placeholder="층 또는 방번호" requried="true"/>
					</td>
				</tr>
				<tr>
					<th>이미지 파일첨부</th>
					<td colspan="3">
						<input name="file_1" id="egovComFileUploader" type="file" title="첨부파일"/>
						<div id="egovComFileList"></div>
					</td>
				</tr>
			</table>
			<!-- 하단 버튼 -->
			<div>
				<span><a href="#" onclick="fncMtRoomClear(); return false;">초기화</a></span>
				<input type="submit" value='저장'/>
				<span><a href="<c:url value='/mtRoomList'/>?searchCondition=1">목록</a></span>
			</div>
			<div style="clear:both;"></div>
		</div>		
	</form:form>
</body>
</html>