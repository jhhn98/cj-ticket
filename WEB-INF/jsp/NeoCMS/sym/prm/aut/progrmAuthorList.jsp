<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="tsu" uri="http://www.hanshinit.co.kr/jstl/tagStringUtil"%>
<%-- 좌측 메뉴 에서 현재 메뉴 체크에 사용되는 값 --%>
<c:set var="active_menu" value="PRG_1" scope="request"/>

<!DOCTYPE html>
<html lang="ko">
<head>

	<title>NEO Administrator - 프로그램권한관리</title>
	<meta name="decorator" content="neo" />


	<script src="/common/js/jquery-ui.js"></script>

	<script nonce="NEOCMSSCRIPT">

		function fn_deleteProgrmAuthor( url ) {
			if( confirm("삭제하시겠습니까?") ) {
				window.location = url;
			}
		}

	</script>
</head>
<body>

<div class="page_location">
	<span class="depth1_title icon_code">컴포넌트관리</span>
	<i class="sign_gt">메뉴 위치 구분 기호 ></i>
	<span class="depth2_title">컴포넌트 권한 관리</span>
</div>

<div class="contents">
	<div class="arrangementWrap data_info">
		<div class="arrLeft">
			<span class="table_text">총 : <c:out value="${paginationInfo.totalRecordCount}"/> 건</span>
			<span class="table_text">Page : <c:out value="${paginationInfo.currentPageNo}"/> / <c:out value="${paginationInfo.totalPageCount}"/></span>
		</div>

		<div class="arrRight">
		</div>
	</div>

	<div class="table_fixed_wrap is_topBottom_wrap">
		<div id="tableScroll" class="data_table">
			<div class="scroll_view">
				<table>
					<colgroup>
						<col class="specWidth40px"/>
						<col class="specWidth100px"/>
						<col/>
						<col class="specWidth100px"/>
						<col class="specWidth100px"/>
					</colgroup>
					<thead>
					<tr>
						<th scope="col">번호</th>
						<th scope="col">사용자아이디</th>
						<th scope="col">사용자이름</th>
						<th scope="col">등록일</th>
						<th scope="col">삭제</th>
					</tr>
					</thead>
					<tbody>
					<c:set var="currentPageStartNo" value="${paginationInfo.currentPageStartNo}" />
					<c:forEach var="result" items="${resultList}" varStatus="status">
						<tr>
							<td class="textARight"><c:out value="${currentPageStartNo}"/></td>
							<td class="textACenter"><c:out value="${result.userId}"/></td>
							<td><c:out value="${result.userNm}"/></td>
							<td class="textACenter"><c:out value="${result.frstRegisterPnttmYMD}"/></td>
							<td class="textACenter"><a href="./deleteProgrmAuthor.do?progrmNo=<c:out value="${result.progrmNo}"/>&amp;userId=<c:out value="${result.userId}"/>" class="iconTextButton delete small" onclick="fn_deleteProgrmAuthor(this.href); return false;"><span>삭제</span></a></td>
						</tr>
						<c:set var="currentPageStartNo" value="${currentPageStartNo-1}" />
					</c:forEach>
					<c:if test="${fn:length(resultList) == 0}">
						<tr>
							<td colspan="6" class="textACenter">검색된 프로그램 권한이 없습니다.</td>
						</tr>
					</c:if>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<div class="arrangementWrap data_button">
		<div class="arrLeft">
			<ui:pagination paginationInfo="${tsu:xssPagingFilter(paginationInfo)}" type="text" jsFunction="./selectProgrmAuthorList.do?progrmAuthorCode=${tsu:xssLinkFilter(searchVO.progrmNo)}&amp;${tsu:xssLinkFilter(searchVO.paramsExclPi)}&amp;pageIndex=" />

		</div>
		<div class="arrRight">
			<a href="./selectProgramList.do" class="iconTextButton list"><span>목록</span></a>
			<button type="button" class="iconTextButton write emplSearch marginLeft_10"><span>등록</span></button>
		</div>
	</div>
</div>


<script nonce="NEOCMSSCRIPT">

	var effect = 'slide';
	var options = { direction: 'right' };
	var duration = 500;

	$(document).ready(function() {

		/** 직원 검색 버튼에 대한 액션 */
		$(".emplSearch").click(function (e) {
			e.preventDefault();
			fn_ajax_search_submit("departmentForm");
			$('#slide_right_view').show(effect, options, duration);
		});

	});
	function selectEmployee(employee){

		var userid = $(employee).data("userid");
		var userNm = $(employee).data("usernm");

		if(userid == ""){
			alert("선택된 직원은 연동된 사용자 계정이 존재하지 않습니다.");
			return false;
		}

		$("#mngUserId").val(userid);
		$("#mngUserNm").val(userNm);
		$("#manageRegistFrm1").submit();
		closeSlideView();
	}
	function closeEmployeeView (){
		closeSlideView();
	}
	function closeSlideView(){
		$('#slide_right_view').hide(effect, options, duration);
	}

	function fn_ajax_search_submit(form_id){
		var formData = $("#"+form_id).serialize();
		var url = $("#"+form_id).attr("action");
		jQuery(spinner).css('display', '');
		$.ajax({
			cache: false,
			url: url, // 요기에
			type: 'POST',
			data: formData,
			success: function (res) {
				jQuery(spinner).css('display', 'none');
				$("#slide_right_view").html(res);
			}, // success
			error: function (request,xhr, status) {
				//alert(request.responseText);
				alert("에러가 발생하였습니다.");
				jQuery(spinner).css('display', 'none');
			},
			complete: function () {
				jQuery(spinner).css('display', 'none');
			}
		});
		return false;
	}

	function movePopupContents(menuUrl){
		jQuery(spinner).css('display', '');
		$.ajax({
			url: menuUrl,
			method: 'post',
			success: function(res) {
				$("#slide_right_view").html(res);
				jQuery(spinner).css('display', 'none');

			},
			error : function( request, status, error ) {
				if(request.responseText.lastIndexOf("로그인이 만료되었습니다.") != -1){
					alert("로그인이 만료되었습니다. 로그인페이지로 이동합니다.");
					location.href = "/neo/index.do";
				}else{
					//alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				alert("에러가 발생하였습니다. 새로고침 후 다시확인하여주세요");
				}
				jQuery(spinner).css('display', 'none');
			},
			complete: function(){
				jQuery(spinner).css('display', 'none');
			}

		});
		return false;
	}
</script>

<script src="/neo/js/tableHeaderFixed.js"></script>
<script nonce="NEOCMSSCRIPT">
	var dataTable = new fixedTableHead({
		target: "#tableScroll"
	});
</script>

<script type="text/plain" id="employee_info">
	<img src="./images/icon_tree_node_sub.gif" style="vertical-align:middle"> {0} (<span class="em_red">{1}</span>)
	<img src="./images/icon_arrow_r.gif" style="vertical-align:middle; margin:0 5px 0 5px">
	<img src="./images/icon_tree_node_user.gif" style="vertical-align:middle"> {2}(<span class="em_red">{3}</span>)
</script>


<form id="manageRegistFrm1" name="manageRegistFrm1" action="./insertProgrmAuthor.do" method="post">
	<input type="hidden" name="progrmNo" value="<c:out value="${searchVO.progrmNo}"/>"/>
	<input type="hidden" name="userId" id="mngUserId" value=""/>
	<input type="hidden" name="userNm" id="mngUserNm" value=""/>
	<input type="hidden" name="pageUnit" value="${searchVO.pageUnit}"/>
	<input type="hidden" name="searchCnd" value="${searchVO.searchCnd}"/>
	<input type="hidden" name="searchKrwd" value="${searchVO.searchKrwd}"/>
	<input type="hidden" name="pageIndex" value="${searchVO.pageIndex}"/>
</form>
<form id="departmentForm" name="departmentForm" action="selectPopUserInfoList.do" method="post" >
</form>
<div id="slide_right_view" class="employeeView">
</div>
</body>
</html>