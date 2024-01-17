<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<title>회의실예약관리 목록</title>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.9.2/i18n/jquery.ui.datepicker-ko.min.js"></script>
<script type="text/javaScript" defer="defer">
	function initCalendar(){
		$("#resveDeView").datepicker(
			{	dateFormat:'yy-mm-dd'
				, showOn : 'both'
				, buttonImageOnly : true
				
				, showMonthAfterYear : true
				, showOtherMonths : true
				, selectOtherMonths : true
				
				, changeMonth : true	// 월 선택 select box 표시 (기본은 false)
				, changeYear : true		// 년 선택 select box 표시
				, showButtonPanel : true	// 하단 today, done 버튼기능 추가 표시				
			});
		$("#resveDeView").change(function(){
			$("#reserve_Day").val($(this).val().replace(/-/gi,"/"));
		});
	}
	/* 회의실 예약목록 조회 */
	function fncMtResveList(pageNo){
		document.listForm.searchCondition.value = "1";
		document.listForm.pageIndex.value = pageNo;
		document.listForm.action = "<c:url value='/mtList'/>";
		document.listForm.submit();
	}
</script>
</head>
<body onload="initCalender();">
<div>
	<h1>회의실 예약관리 수정</h1><!-- 회의실 예약관리 목록 -->
	<form name="listForm" action="<c:url value='mtResList'/>" method="post">
		<div title="회의일자">
			<ul>
				<li>
					<label for="">회의일자 :</label><!-- 회의 일자 -->
					<input id="reserve_Day" name="reserve_Day" type="hidden" value="<c:url value='${reserve_Day}'/>"/>
					<input id="resveDeView" name="resveDeView" type="text" value="${reserve_Day}" readonly="readonly" title="조회" style="width:80px; margin-right:-8px"/>
					<input type="submit" value="조회" title="조회" onclick="fncMtResveList('1'); return false;"/>
				</li>
			</ul>
		</div>
	</form>
	<p>※회의일자 변경시 조회 버튼 클릭하셔야 예약 리스트가 조회됩니다.<br>
	※회의실 예약은 회의실의 색이 없는 반 시간을 클릭하시면 예약신청화면으로 이동합니다.(그래프 클릭시 상세화면 이동)</p>
	
	<table class="table-line" style="style:border-spacing:0" summary="회의실 예약관리 목록"><!-- 회의실 예약관리 목록 -->
		<caption>회의실 예약관리 목록</caption>
		<thead>
			<colgroup>
				<col style="width:200px"/>
				<col style=""/>
				<col style=""/>
				<col style=""/>
				<col style=""/>
				<col style=""/>
				<col style=""/>
				<col style=""/>
				<col style=""/>
				<col style=""/>
				<col style=""/>
				<col style=""/>
				<col style=""/>
				<col style=""/>
			</colgroup>
			<tr>
				<th scope="col">회의실명</th>
				<th colspan="2" scope="col">08</th>
				<th colspan="2" scope="col">09</th>
				<th colspan="2" scope="col">10</th>
				<th colspan="2" scope="col">11</th>
				<th colspan="2" scope="col">12</th>
				<th colspan="2" scope="col">13</th>
				<th colspan="2" scope="col">14</th>
				<th colspan="2" scope="col">15</th>
				<th colspan="2" scope="col">16</th>
				<th colspan="2" scope="col">17</th>
				<th colspan="2" scope="col">18</th>
				<th colspan="2" scope="col">19</th>
				<th colspan="2" scope="col">20</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="mtResTable" items="${mrResTimeList}" varStatus="status">
				<tr>
					<td><c:out value="${mtResTable.mr_Name}"/></td>
				<c:forEach var="i" begin="0800" end="2050" step="50">
					<c:if test="${(i%100)>30}">
						<c:set var="num" value="${i-20}"/>
					</c:if>
					<c:if test="${(i%100)<30}">
						<c:set var="num" value="${i}"/>
					</c:if>
					<c:set var="resveTn" value="resveTemp${num}"/>
					<c:set var="resveTm" value="${mtResTable[resveTn]}"/>
					
					<c:if test="${resveTm != '0'}">
						<td bgcolor="#FFFFFF">
							<form name="item" method="post" action="<c:url value='updateResView'/>">
								<input type="hidden" name="mrNo" value="<c:url value='${mtResTable.mrNo}'/>">
								<input type="hidden" name="mr_Name" value="<c:out value='${mtResTable.mr_Name}'/>">
								<input type="hidden" name="reserve_Day" value="<c:out value='${mtResTable.reserve_Day}'/>">
								<input type="hidden" name="reserve_Start" value="${num}">
								<span style="background:pink;">
								<input type="submit" value=" " style="width:100%; height:100%;" ></span>
							</form>
						</td>
					</c:if>
					
					<c:if test="${resveTm == '0'}">
						<td bgcolor="#431508">
							<form name="item" method="post" action="<c:url value='mtResRegist'/>">
								<input type="hidden" name="mrNo" value="<c:url value='${mtResTable.mrNo}'/>">
								<input type="hidden" name="mr_Name" value="<c:out value='${mtResTable.mr_Name}'/>">
								<input type="hidden" name="reserve_Day" value="<c:out value='${mtResTable.reserve_Day}'/>">
								<input type="hidden" name="reserve_Start" value="${num}">
								<span style="background:#FFFFFF;">
								<input type="submit" value=" " style="width:100%; height:100%;" ></span>
							</form>
						</td>
					</c:if>
				</c:forEach>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>
</body>
</html>