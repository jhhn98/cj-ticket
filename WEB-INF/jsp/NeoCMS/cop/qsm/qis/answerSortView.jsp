<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta name="decorator" content="${menuInfo.siteId}" />
	<link rel="stylesheet" href="/common/css/board.css" />
	<script src="/common/js/calendar.js"></script>
	<title>${menuInfo.cntntsNm} 신청</title>
</head>
<body>
<script type="text/javascript">

	function fn_index_ups(){
		var opt = $("#sort option:selected");
		if(opt.size() > 0) {
			opt.insertBefore($("#sort option:first"));
		}
	}

	function fn_index_up(){
		var opt = $("#sort option:selected");
		if(opt.size() > 0) {
			opt.insertBefore(opt.prev());
		}
	}

	function fn_index_dn(){
		var opt = $("#sort option:selected");
		if(opt.size() > 0) {
			opt.insertAfter(opt.next());
		}
	}

	function fn_index_dns(){
		var opt = $("#sort option:selected");
		if(opt.size() > 0) {
			opt.insertAfter($("#sort option:last"));
		}
	}

	function fn_updateSort(){

		$("#sort option").each(function(){

			var newHiddn = $("#sortId").clone();
			newHiddn.val($(this).val());
			newHiddn.attr("name","sortId");
			newHiddn.insertBefore($("#add_input"));
		});

		return true;
	}

</script>

<div class="p-wrap">
	<div class="col-15">
		<table class="p-table">
			<tr><td>

				<div style="margin-bottom:20px; border-bottom:solid 2px #F1F1F1; font-weight:bold">
					답변 순서변경
				</div>

				<form:form modelAttribute="qestnarAnswer" name="qestnarAnswer" action="updateAnswerSort.do?key=${key}&siteId=${searchVO.siteId}&amp;${searchVO.params}"  onsubmit="return fn_updateSort(this)">

					<input type="hidden" name="qestnarNo" value="${searchVO.qestnarNo}"/>
					<form:hidden path="qestnarQestnNo"/>

					<select id="sort"  style="height:260px; width:100%; border:solid 1px #528ED8" size="16" class="p-input p-input--auto">
						<c:forEach var="result" items="${resultList}" varStatus="status">
							<option value="${result.qestnarAnswerNo}">${result.answer}</option>
						</c:forEach>
					</select>

					<br/>
					<br/>
					<div id="add_input"><input type="hidden" id="sortId" /> </div>

					<div class="row p-relative">
						<div class="col-15 margin_t_5">
							<a href="#n" onclick="fn_index_ups()" class="p-button p-button--small">
								<svg width="16" height="15" focusable="false"><title>맨위로</title><use xlink:href="/common/images/program/p-icon.svg#angle-double-up"></use></svg>맨위로
							</a>
							<a href="#n" onclick="fn_index_up()" class="p-button p-button--small">
								<svg width="16" height="15" focusable="false"><title>위로</title><use xlink:href="/common/images/program/p-icon.svg#angle-up"></use></svg>위로
							</a>
							<a href="#n" onclick="fn_index_dn()" class="p-button p-button--small">
								<svg width="16" height="15" focusable="false"><title>아래로</title><use xlink:href="/common/images/program/p-icon.svg#angle-down"></use></svg>아래로
							</a>
							<a href="#n" onclick="fn_index_dns()" class="p-button p-button--small">
								<svg width="16" height="15" focusable="false"><title>맨아래로</title><use xlink:href="/common/images/program/p-icon.svg#angle-double-down"></use></svg>맨아래로
							</a>
						</div>
						<div class="col-9 right">
							<a href="./addQestnarQestnMngView.do?key=${key}&qestnarNo=${qestnarQestn.qestnarNo}&amp;siteId=${searchVO.siteId}&amp;${searchVO.params}" class="p-button write"><span>돌아가기</span></a>
							<span class="button red"><input type="submit" value="순서변경" class="p-button write"/></span>
						</div>
					</div>

				</form:form>

			</td></tr>
		</table>

	</div>
</div>
</body>
</html>