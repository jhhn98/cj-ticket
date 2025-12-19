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
    <%--
<h1 class="subHeader">
	<img src="./images/tree_mode.gif" width="16px" height="16px"/> <c:out value="${upperDept.deptNm}"/>(<span class="em_red"><c:out value="${upperDept.deptCode}"/></span>)
	&gt;
	<img src="./images/btn_menu_add.gif"/> 하위메뉴 등록
</h1>
--%>
<jsp:include page="./subMenu.jsp" />
<div class="dataWrap">
    <form:form modelAttribute="department" name="departmentAddForm" action="addDepartment.do" id="departmentAddForm" onsubmit="return fn_ajax_submit_department(this)">
	<form:hidden path="upperDeptCode"/>
	<table>
	<colgroup>
		<col class="specWidth120px"/>
		<col/>
	</colgroup>
	<tbody>
		<tr>
			<th scope="row">상위부서</th>
			<td><c:out value="${upperDept.deptNm}"/></td>
		</tr>
		<tr>
			<th scope="row" class="essential_input"><form:label path="deptCode">부서코드</form:label></th>
			<td>
                <div class="form_element">
                    <span class="element_wrap"><form:input path="deptCode" size="20" maxlength="9"/></span>
                </div>
            </td>
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
            <button type="submit" class="iconTextButton write"><span>등록</span></button>
		</div>
	</div>
    </form:form>
</div>