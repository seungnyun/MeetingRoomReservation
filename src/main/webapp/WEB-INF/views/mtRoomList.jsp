<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회의실관리 목록</title>
<script type="text/javascript" language="javascript" defer="defer">
	
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
<div class="board">
<form name="listForm" action="<c:url value='mtRoomlist'/>" method="post">
<h1>회의실 관리목록</h1><!-- 회의실 관리목록 -->
<div class="search_box" title="회의실명">
<ul>
<li>
<label for="">회의실명</label><!-- 회의실명 -->
<input class="s_input2 vat" name="searchKeyword" type="text" value='' size="25" onkeypress="press();" title="" />
<input type="submit" class="s_btn" value='검색' title='"button.inquire" ' onclick="fncSelectMtrList('1'); return
false;" />
<span class="btn_b"><a href="/insertMtRoom?searchCondition=1" onclick="fncInsertMtRoom(); return false;"
title='등록'>등록</a></span>
</li>
</ul>
</div>
</form>
</body>