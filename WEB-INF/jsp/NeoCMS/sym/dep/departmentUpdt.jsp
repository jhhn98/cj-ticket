<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>


<script src="<c:url value='/cmm/validator.do'/>"></script>
<validator:javascript formName="department" staticJavascript="false" xhtml="true" cdata="false"/>
<spring:hasBindErrors name="department">
<script nonce="NEOCMSSCRIPT">
<c:forEach items="${errors.allErrors}" var="error" varStatus="status">
	<c:if test="${status.first}">
				<c:set var="errMsg"><spring:message code="${error.code}" arguments="${error.arguments}" /></c:set>
		alert("<c:out value="${errMsg}"/>");
	</c:if>
</c:forEach>
</script>
</spring:hasBindErrors>
<c:if test="${!empty message}">
<script nonce="NEOCMSSCRIPT">
 	function fn_check_message() {
 		alert("<c:out value='${message}'/>");
    <c:if test="${!empty fieldName}">
	    $("#<c:out value="${fieldName}"/>").focus();
    </c:if>
 	}
	$(window).on("load", function() {
		fn_check_message();
	});
</script>
 </c:if>

<script nonce="NEOCMSSCRIPT">
	function fn_ajax_submit_department(frm){
		var validate = validateDepartment(frm);
		if(validate == true){
			fn_ajax_submit(frm.id);
			return false;
		}else{
			return false;
		}
	}

	function fn_ajax_submit(form_id){
		if(typeof validateDepartment !== 'undefined' && $.isFunction(validateDepartment)){
			try{
				if(!validateDepartment(document.getElementById(form_id))){
					return false;
				}
			}catch(Exception){ console.log('empty vilidator'); }
		}
		var formData = $("#"+form_id).serialize();
		var url = $("#"+form_id).attr("action");
		jQuery(spinner).css('display', '');
		$.ajax({
			cache: false,
			url: url, // 요기에
			type: 'POST',
			data: formData,
			success: function (res) {
				//console.log(res);
				jQuery(spinner).css('display', 'none');
				$(".treeView_content").html(res);
			}, // success
			error: function (request,xhr, status) {
				//alert(request.responseText);
                alert("에러가 발생하였습니다.");
				//$(".treeView_content").html(request.responseText);
				jQuery(spinner).css('display', 'none');
			},
			complete: function () {
				jQuery(spinner).css('display', 'none');
				downloadLinkPass();
			}
		});
	}
</script>
<jsp:include page="./subMenu.jsp" />
<div class="dataWrap">
<form:form modelAttribute="department" name="departmentAddForm" action="updateDepartment.do" id="departmentAddForm" onsubmit="return fn_ajax_submit_department(this)">

	<form:hidden path="deptCode"/>
	<form:hidden path="upperDeptCode"/>
	<input type="hidden" name="prevUpperDeptCode" id="prevUpperDeptCode" value="<c:out value="${department.upperDeptCode}"/>"/>
	<table>
	<colgroup>
		<col class="specWidth120px"/>
		<col/>
	</colgroup>
	<tbody>
		<tr>
			<th scope="row">상위부서</th>
			<td>
				<span id="deptNm"><c:out value="${upperDept.deptNm}"/>(<span class="em_red"><c:out value="${upperDept.deptCode}"/></span>)</span>
				<a href="#n" class="textButton small search emplSearch"><span id="deptSpanNm">상위부서변경</span></a>
				<p class="info_text" id="info_dept_text" style="display: none;">이동할 부서를 좌측 부서목록에서 선택하여주세요.</p>
				<%--<a href="./popupDeptTreeSmallView.do?mode=upperDeptCode&amp;deptSortCode=<c:out value="${department.deptSortCode}"/>" class="iconTextButton small edit marginLeft_10" onclick="fn_popWindow(this.href,'departmentSmallSearchPop','toolbors=no,scrollbars=no,width=285px,height=418px'); return false;"><span>상위부서변경</span></a>--%>
			</td>
		</tr>
		<tr>
			<th scope="row">부서코드</th>
			<td><c:out value="${department.deptCode}"/></td>
		</tr>
		<tr>
			<th scope="row" class="essential_input"><form:label path="deptNm">부서이름</form:label></th>
			<td>
                <div class="form_element">
                    <span class="element_wrap"><form:input path="deptNm" size="20" maxlength="25"/></span>
                </div>
            </td>
		</tr>
		<tr>
			<th scope="row" ><form:label path="deptMainTel">부서대표번호</form:label></th>
			<td>
				<div class="form_element">
					<span class="element_wrap"><form:input path="deptMainTel" /></span>
				</div>
			</td>
		</tr>
		<tr>
			<th scope="row"><form:label path="deptTelno">연락처</form:label></th>
			<td>
                <div class="form_element">
                    <span class="element_wrap"><form:input path="deptTelno" size="20" maxlength="14"/></span>
                </div>
            </td>
		</tr>
		<tr>
			<th scope="row"><form:label path="deptFax">팩스</form:label></th>
			<td>
                <div class="form_element">
                    <span class="element_wrap"><form:input path="deptFax" size="20" maxlength="14"/></span>
                </div>
            </td>
		</tr>
		<tr>
			<th scope="row" ><form:label path="deptInfo">부서설명</form:label></th>
			<td>
				<div class="form_element">
					<span class="element_wrap"><form:textarea path="deptInfo" style="height:100px"/></span>
				</div>
			</td>
		</tr>
		<tr>
			<th scope="row" ><form:label path="deptPosition">부서위치</form:label></th>
			<td>
				<div class="form_element">
					<span class="element_wrap"><form:textarea path="deptPosition" style="height:100px" /></span>
				</div>
			</td>
		</tr>
		<tr>
			<th scope="row" class="essential_input"><form:label path="deptSttus">상태</form:label></th>
			<td>
                <div class="form_element">
                    <span class="element_wrap">
                        <form:select path="deptSttus">
                            <form:option value="" label="--선택하세요--" />
                            <c:forEach var="opt" items="${deptSttusList}">
                                <option value="<c:out value="${opt.code}"/>" <c:out value="${opt.code eq department.deptSttus ? 'selected=true':''}"/>><c:out value="${opt.codeNm}"/></option>
                            </c:forEach>
                        </form:select>
                        <form:errors path="deptSttus"/>
                    </span>
                </div>
			</td>
		</tr>
	</tbody>
	</table>

    <div class="arrangementWrap marginTop_20">
        <div class="arrLeft">
            <a onclick="moveTreeContents(this.href);return false;" href="./selectEmployeeList.do?deptCode=<c:out value="${department.upperDeptCode}"/>" class="iconTextButton list"><span>목록</span></a>
        </div>
        <div class="arrRight">
            <button type="submit" class="iconTextButton edit"><span>수정</span></button>
        </div>
    </div>
</form:form>
</div>


<script nonce="NEOCMSSCRIPT">

	var effect = 'slide';
	var options = { direction: 'right' };
	var duration = 500;

	function fn_ajax_search_submit_depart(form_id){
		var formData = $("#"+form_id).serialize();
		var url = $("#"+form_id).attr("action");
		jQuery(spinner).css('display', '');
		$.ajax({
			cache: false,
			url: url, // 요기에
			type: 'POST',
			data: formData,
			async:false,
			success: function (res) {
				jQuery(spinner).css('display', 'none');
				$("#slide_right_view").html(res);;
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

	$(document).ready(function(){

		/** 직원 검색 버튼에 대한 액션 */
		$(".emplSearch").click(function (e) {
			if(isDeptSelectMode == true){
				$(".dept_selector").removeClass("flag_on");
				$("#info_dept_text").hide();
				isDeptSelectMode = false;
				$("#deptSpanNm").html("부서변경");
			}else{
				$(".dept_selector").addClass("flag_on");
				$("#info_dept_text").show();
				$("#deptSpanNm").html("변경취소");
				isDeptSelectMode = true;
			}
		});
	});
</script>