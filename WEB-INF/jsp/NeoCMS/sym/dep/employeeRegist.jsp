<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<script src="<c:url value='/cmm/validator.do'/>"></script>
<validator:javascript formName="employee" staticJavascript="false" xhtml="true" cdata="false"/>
<spring:hasBindErrors name="employee">
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
    function fn_ajax_submit_employee(frm){
        var validate = validateEmployee(frm);
        if(validate == true){
            fn_ajax_submit(frm.id);
            return false;
        }else{
            return false;
        }
    }

    function fn_ajax_submit(form_id){
        if(typeof validateEmployee !== 'undefined' && $.isFunction(validateEmployee)){
            try{
                if(!validateEmployee(document.getElementById(form_id))){
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
    $(document).ready(function(){
        formLabelText();
    })
    $(document).ready(function(){
        formLabelText();
    })
</script>
<%-- <jsp:include page="./subMenu.jsp" /> --%>
<div class="marginLeft_30 marginRight_30">
    <h2 class="marginTop_0">직원등록</h2>
    <form:form modelAttribute="employee" name="employeeForm" action="addEmployee.do" onsubmit="return fn_ajax_submit_employee(this)">

        <form:hidden path="deptCode"/>

        <table>
            <colgroup>
                <col class="specWidth120px"/>
                <col/>
            </colgroup>
            <tbody>
            <tr>
                <th scope="row" class="essential_input"><form:label path="emplCode">직원코드</form:label></th>
                <td>
                    <div class="form_element">
                        <span class="element_wrap"><form:input path="emplCode" size="20" maxlength="9"/></span>
                    </div>
                </td>
            </tr>
            <tr>
                <th scope="row" class="essential_input"><form:label path="emplNm">직원이름</form:label></th>
                <td>
                    <div class="form_element">
                        <span class="element_wrap"><form:input path="emplNm" size="20" maxlength="25"/></span>
                    </div>
                </td>
            </tr>
            <tr>
                <th scope="row"><form:label path="rspofc">직책</form:label></th>
                <td>
                    <div class="form_element">
                        <span class="element_wrap"><form:input path="rspofc" size="20" maxlength="25"/></span>
                    </div>
                </td>
            </tr>
            <tr>
                <th scope="row"><form:label path="clsf">직급</form:label></th>
                <td>
                    <div class="form_element">
                        <span class="element_wrap"><form:input path="clsf" size="20" maxlength="25"/></span>
                    </div>
                </td>
            </tr>
            <tr>
                <th scope="row"><form:label path="emplEmail">이메일</form:label></th>
                <td>
                    <div class="form_element">
                        <span class="element_wrap"><form:input path="emplEmail" size="20" maxlength="60"/></span>
                    </div>
                </td>
            </tr>
            <tr>
                <th scope="row"><form:label path="emplTelno">연락처</form:label></th>
                <td>
                    <div class="form_element">
                        <span class="element_wrap"><form:input path="emplTelno" size="20" maxlength="14"/></span>
                    </div>
                </td>
            </tr>
            <tr>
                <th scope="row"><form:label path="emplFax">팩스</form:label></th>
                <td>
                    <div class="form_element">
                        <span class="element_wrap"><form:input path="emplFax" size="20" maxlength="14"/></span>
                    </div>
                </td>
            </tr>
            <tr>
                <th scope="row"><form:label path="emplJob">담당업무</form:label></th>
                <td>
                    <div class="form_element">
                        <span class="element_wrap el_textarea"><form:textarea path="emplJob" cols="60" rows="8"/></span>
                    </div>
                </td>
            </tr>
            <tr>
                <th scope="row" class="essential_input"><form:label path="emplSttus">상태</form:label></th>
                <td>
                    <div class="form_element">
                            <span class="element_wrap">
                                <form:select path="emplSttus">
                                    <form:option value="" label="--선택하세요--" />
                                    <c:forEach var="opt" items="${emplSttusList}">
                                        <option value="<c:out value="${opt.code}"/>" <c:out value="${opt.code eq employee.emplSttus ? 'selected=true':''}"/>><c:out value="${opt.codeNm}"/></option>
                                    </c:forEach>
                                </form:select>
                                <form:errors path="emplSttus"/>
                            </span>
                    </div>
                </td>
            </tr>
            </tbody>
        </table>

        <div class="arrangementWrap marginTop_20">
            <div class="arrLeft">
                <a onclick="moveTreeContents(this.href);return false;" href="./selectEmployeeList.do?deptCode=<c:out value="${department.deptCode}"/>" class="iconTextButton list"><span>목록</span></a>
            </div>
            <div class="arrRight">
                <button type="submit" class="iconTextButton write"><span>등록</span></button>
            </div>
        </div>

    </form:form>
</div>