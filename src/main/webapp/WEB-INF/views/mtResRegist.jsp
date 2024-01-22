<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<title>회의실 예약 등록</title>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.9.2/i18n/jquery.ui.datepicker-ko.min.js"></script>
<script type="text/javaScript">
	function initCalender(){
		$("#reserve_Day").daypicker(
			{	dateFormat :'yy-mm-dd'
				, showOn : 'button'
				, buttonImageOnly : false
				, showMonthAfterYear : true
				, showOtherMonths : true
				, selectOherMonths : true
				, changeMonth : true		// 월 선택 select box
				, changeYear : true			// 년 선택 select box
				, showButtonPanel : true	// 하단 today, done 버튼 기능 추가 표시
		});
	}
	
	function fncMrReserve(){
		mtgPlaceResve.action = "<c:url value='insertReserve'/>";
		
		if(mtgPlaceResve.dupCheck.value){
			if(confirm("예약하시겠습니까?")){
				mtgPlaceResve.submit();
			}else{
				return false;
			}
		}else if(mtgPlaceResve.dupCheck.value == false){alert("에약 중복되었습니다. 확인 후 예약을 해주세요. ");}
		 else {alert("회의실 예약 중복확인을 하신 후 회의실 예약을 해주세요.");}
	}
	
	/* 회의실 중복여부 확인 Ajax */
	function resDupCheck(){
		var mrNo = mtgPlaceResve.mrNo.value;
		var beginTm = mtgPlaceResve.reserve_Start.value;
		var endTm = mtgPlaceResve.reserve_End.value;
		var res_Day = mtgPlaceResve.reserve_Day.value;
		
		if((endTm-beginTm)<0){
			alert("예약시작 시간이 예약종료 시간보다 빨라야 합니다.");
			return false;
		}
		
		var sTempValue = "reserve_Day=" + res_Day + "&reserve_Start="+ beginTm + "&reserve_End=" + endTm + "&mrNo=" + mrNo; 
		var access = $("#dupMsg");
			$.ajax({
				url:"/resDupCheck?" + sTempValue,
				type:'get',
				dataType:'json',
				success:function(result){
					if(result.dup=="true"){
						access.html("<font color='green' size='2px;'><i>&nbsp;:예약 가능한 시간입니다.</i></font>");
						$("#dupCheck").val("true");
					}else{
						access.html("<font color='red' size='2px;'><i>&nbsp;:예약 시간이 중복되었습니다.</i></font>");
						$("#dupCheck").val("false");
					}
				}
			});
	}
</script>
</head>
<body>
	<form:form modelAttribute="mrReserveVO" name="mtgPlaceResve" mthod="post">
		<input type="hidden" name="cmd" value="insert">
		<input type="hidden" name="dupCheck" id="dupCheck">
		<input type="hidden" name="mrNo" value="<c:url value='${mtRoomVO.mrNo}'/>">
		<div>
			<h2>회의실 예약 신청</h2>
		</div>
		<table>
			<colgroup>
				<col style="width:16%"/>
				<col style=""/>
				<col style="width:16%"/>
				<col style=""/>
			</colgroup>
			<tr>
				<th>제목<span>*</span></th>
				<td colspan="3">
					<input name="title" type="text" maxlength="70" title="제목" required="required"/>
				</td>
			</tr>
			<tr>
				<th>회의실명<span>*</span></th>
				<td colspan="3">
					<c:out value='${mtRoomVO.mr_Name}'/>
				</td>
			</tr>
			<tr>
				<th>회의실 위치<span>*</span></th>
				<td colspan="3">
					<c:out value='${mtRoomVO.location}'/> <c:out value='${mtRoomVO.building}'/> <c:out value='${mtRoomVO.roomNo}'/>
				</td>
			</tr>
			<tr>
				<th>예약자 ID<span>*</span></th>
				<td>
					<input name="first_Reg_ID" type="text" maxlength="20" value="<c:out value='${sessionScope.userId}'/>"/>
				</td>
				<th>예약자 이름</th>
				<td><c:out value='${resName}'/></td>
			</tr>
			<tr>	
					<th>예약시간<span>*</span></th>
					<td colspan="3">
						<input type="hidden" name="cal_url" id="cal_url" value="<c:url value='/sym/cal/EgovNormalCalPopup.do'/>"/>
						<input name="reserve_Day" id="reserve_Day" type="text" size="10" value="${mrReserveVO.reserve_Day}" title="예약일자" maxlength="10" style="width:78px;"/>
						<select name="reserve_Start" title="예약시작시간">
							<option value="800" <c:if test="${mrReserveVO.reserve_Start == '800' || mrReserveVO.reserve_Start == '0800'}">selected</c:if>>08:00</option>
							<option value="830" <c:if test="${mrReserveVO.reserve_Start == '830' || mrReserveVO.reserve_Start == '0830'}">selected</c:if>>08:30</option>
							<option value="900" <c:if test="${mrReserveVO.reserve_Start == '900' || mrReserveVO.reserve_Start == '0900'}">selected</c:if>>09:00</option>
							<option value="930" <c:if test="${mrReserveVO.reserve_Start == '930' || mrReserveVO.reserve_Start == '0930'}">selected</c:if>>09:30</option>
							<option value="1000" <c:if test="${mrReserveVO.reserve_Start == '1000'}"> selected </c:if>>10:00</option>
							<option value="1030" <c:if test="${mrReserveVO.reserve_Start == '1030'}"> selected </c:if>>10:30</option>
							<option value="1100" <c:if test="${mrReserveVO.reserve_Start == '1100'}"> selected </c:if>>11:00</option>
							<option value="1130" <c:if test="${mrReserveVO.reserve_Start == '1130'}"> selected </c:if>>11:30</option>
							<option value="1200" <c:if test="${mrReserveVO.reserve_Start == '1200'}"> selected </c:if>>12:00</option>
							<option value="1230" <c:if test="${mrReserveVO.reserve_Start == '1230'}"> selected </c:if>>12:30</option>
							<option value="1300" <c:if test="${mrReserveVO.reserve_Start == '1300'}"> selected </c:if>>13:00</option>
							<option value="1330" <c:if test="${mrReserveVO.reserve_Start == '1330'}"> selected </c:if>>13:30</option>
							<option value="1400" <c:if test="${mrReserveVO.reserve_Start == '1400'}"> selected </c:if>>14:00</option>
							<option value="1430" <c:if test="${mrReserveVO.reserve_Start == '1430'}"> selected </c:if>>14:30</option>
							<option value="1500" <c:if test="${mrReserveVO.reserve_Start == '1500'}"> selected </c:if>>15:00</option>
							<option value="1530" <c:if test="${mrReserveVO.reserve_Start == '1530'}"> selected </c:if>>15:30</option>
							<option value="1600" <c:if test="${mrReserveVO.reserve_Start == '1600'}"> selected </c:if>>16:00</option>
							<option value="1630" <c:if test="${mrReserveVO.reserve_Start == '1630'}"> selected </c:if>>16:30</option>
							<option value="1700" <c:if test="${mrReserveVO.reserve_Start == '1700'}"> selected </c:if>>17:00</option>
							<option value="1730" <c:if test="${mrReserveVO.reserve_Start == '1730'}"> selected </c:if>>17:30</option>
							<option value="1800" <c:if test="${mrReserveVO.reserve_Start == '1800'}"> selected </c:if>>18:00</option>
							<option value="1830" <c:if test="${mrReserveVO.reserve_Start == '1830'}"> selected </c:if>>18:30</option>
							<option value="1900" <c:if test="${mrReserveVO.reserve_Start == '1900'}"> selected </c:if>>19:00</option>
							<option value="1930" <c:if test="${mrReserveVO.reserve_Start == '1930'}"> selected </c:if>>19:30</option>
							<option value="2000" <c:if test="${mrReserveVO.reserve_Start == '2000'}"> selected </c:if>>20:00</option>
							<option value="2030" <c:if test="${mrReserveVO.reserve_Start == '2030'}"> selected </c:if>>20:30</option>
							<option value="2100" <c:if test="${mrReserveVO.reserve_Start == '2100'}"> selected </c:if>>21:00</option>
						</select>
						~
						<select name="reserve_End" title="예약종료시간">
							<option value="800" <c:if test="${mrReserveVO.reserve_End == '800' || mrReserveVO.reserve_End == '0800'}">selected</c:if>>08:00</option>
							<option value="830" <c:if test="${mrReserveVO.reserve_End == '830' || mrReserveVO.reserve_End == '0830'}">selected</c:if>>08:30</option>
							<option value="900" <c:if test="${mrReserveVO.reserve_End == '900' || mrReserveVO.reserve_End == '0900'}">selected</c:if>>09:00</option>
							<option value="930" <c:if test="${mrReserveVO.reserve_End == '930' || mrReserveVO.reserve_End == '0930'}">selected</c:if>>09:30</option>
							<option value="1000" <c:if test="${mrReserveVO.reserve_End == '1000'}"> selected </c:if>>10:00</option>
							<option value="1030" <c:if test="${mrReserveVO.reserve_End == '1030'}"> selected </c:if>>10:30</option>
							<option value="1100" <c:if test="${mrReserveVO.reserve_End == '1100'}"> selected </c:if>>11:00</option>
							<option value="1130" <c:if test="${mrReserveVO.reserve_End == '1130'}"> selected </c:if>>11:30</option>
							<option value="1200" <c:if test="${mrReserveVO.reserve_End == '1200'}"> selected </c:if>>12:00</option>
							<option value="1230" <c:if test="${mrReserveVO.reserve_End == '1230'}"> selected </c:if>>12:30</option>
							<option value="1300" <c:if test="${mrReserveVO.reserve_End == '1300'}"> selected </c:if>>13:00</option>
							<option value="1330" <c:if test="${mrReserveVO.reserve_End == '1330'}"> selected </c:if>>13:30</option>
							<option value="1400" <c:if test="${mrReserveVO.reserve_End == '1400'}"> selected </c:if>>14:00</option>
							<option value="1430" <c:if test="${mrReserveVO.reserve_End == '1430'}"> selected </c:if>>14:30</option>
							<option value="1500" <c:if test="${mrReserveVO.reserve_End == '1500'}"> selected </c:if>>15:00</option>
							<option value="1530" <c:if test="${mrReserveVO.reserve_End == '1530'}"> selected </c:if>>15:30</option>
							<option value="1600" <c:if test="${mrReserveVO.reserve_End == '1600'}"> selected </c:if>>16:00</option>
							<option value="1630" <c:if test="${mrReserveVO.reserve_End == '1630'}"> selected </c:if>>16:30</option>
							<option value="1700" <c:if test="${mrReserveVO.reserve_End == '1700'}"> selected </c:if>>17:00</option>
							<option value="1730" <c:if test="${mrReserveVO.reserve_End == '1730'}"> selected </c:if>>17:30</option>
							<option value="1800" <c:if test="${mrReserveVO.reserve_End == '1800'}"> selected </c:if>>18:00</option>
							<option value="1830" <c:if test="${mrReserveVO.reserve_End == '1830'}"> selected </c:if>>18:30</option>
							<option value="1900" <c:if test="${mrReserveVO.reserve_End == '1900'}"> selected </c:if>>19:00</option>
							<option value="1930" <c:if test="${mrReserveVO.reserve_End == '1930'}"> selected </c:if>>19:30</option>
							<option value="2000" <c:if test="${mrReserveVO.reserve_End == '2000'}"> selected </c:if>>20:00</option>
							<option value="2030" <c:if test="${mrReserveVO.reserve_End == '2030'}"> selected </c:if>>20:30</option>
							<option value="2100" <c:if test="${mrReserveVO.reserve_End == '2100'}"> selected </c:if>>21:00</option>
						</select>
						<input id="btn01" type="button" value="중복체크" onclick="resDupCheck(); return false;" title="중복체크" required="required"/>
						<span id="dupMsg"></span>
					</td>
			</tr>
			<tr>
				<th>참석인원</th>
				<td colspan="3">
					<input name="attendees" type="text" value="<c:out value='${mtgPlaceManageVO.atndncNmpr}'/>" maxlength="3" style="width:30px;" title="참석인원" required="required"/>명
				</td>
			</tr>
			<tr>
				<th>회의내용</th>
				<td colspan="3">
					<form:textarea path="contents" rows="4" cols="70" title="회의내용" required="required"/>
				</td>
			</tr>
			<!-- 첨부파일 테이블 레이아웃 설정 -->
			<c:if test="${!empty mtRoomVO.picture}">
				<tr>
					<th height="23" scope="row">이미지 파일</th>
					<td colspan="3">
						<img src="<c:url value='/resources/images/${mtRoomVO.picture}'/>" width="200" height="150" alt=""/>
					</td>
				</tr>
			</c:if>
		</table>
		<!-- 하단 버튼 -->
		<div>
			<input class="s_submit" type="submit" value="저장" onclick="fncMrReserve(); return false;"/>
			<span><a href="<c:url value='/mtRoomList'/>?searchCondition=1">목록</a></span>
		</div>
		<div style="clear:both;"></div>
	</form:form>
</body>
</html>