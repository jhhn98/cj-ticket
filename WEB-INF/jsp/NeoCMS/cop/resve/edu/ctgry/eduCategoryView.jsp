<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<jsp:useBean id="now" class="java.util.Date"/>
<fmt:formatDate value="${now}" pattern="yyyy" var="year"/>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta name="decorator" content="${menuInfo.siteId}"/>
    <title>카테고리 관리 목록</title>
</head>
<body>

<div class="p-wrap">
    <div class="col-25">
        <form:form id="schCategoryFrm" method="get" action="/${menuInfo.siteId}/selectEduCategoryList.do" modelAttribute="eduCategoryVO">
        <div class="row p-relative margin_b_5">
            <div class="col-6 margin_t_5">
                <span class="p-icon p-icon__info-circle">주의사항</span>
                <span class="p-form__required--icon">필수</span> 표시는 필수 항목 입니다.
            </div>
            <div class="col-18 right">
                <fieldset>
                    <legend>카테고리 검색</legend>
                    <input type="hidden" name="key" value="${key}"/>
                    <input type="hidden" name="prgSe" value="EDU"/>
                    <form:select path="pageUnit" cssClass="p-input p-input--auto" title="목록수" onchange="this.form.submit()">
                        <form:option value="10">10개씩 보기</form:option>
                        <form:option value="20">20개씩 보기</form:option>
                        <form:option value="30">30개씩 보기</form:option>
                        <form:option value="50">50개씩 보기</form:option>
                        <form:option value="100">100개씩 보기</form:option>
                    </form:select>
                    <form:select path="searchInsttNo" cssClass="p-input p-input--auto">
                        <form:option value="">기관선택</form:option>
                        <form:options items="${eduInsttList}" itemValue="insttNo" itemLabel="insttNm"/>
                    </form:select>
                    <form:input path="searchKrwd" cssClass="p-input p-input--auto" placeholder="카테고리명 검색" title="검색어 입력"/>
                    <button type="submit" class="p-button p-button--small primary">검색</button>
                </fieldset>
            </div>
        </div>
        </form:form>
        <table class="p-table">
            <colgroup>
                <col class="w15p">
                <col/>
                <col class="w15p">
                <col/>
                <col class="w15p">
            </colgroup>
            <tbody class="p-table--th-left">
            <tr>
                <th scope="row"><label for="insttNo">기관명</label> <span class="p-form__required--icon">필수</span></th>
                <td>
                    <select id="insttNo" name="insttNo" class="p-input p-input--auto">
                        <option value="">선택하세요</option>
                        <c:choose>
                            <c:when test="${not empty insttMap}">
                                <%-- 기관담당자 또는 강사: 권한 있는 기관만 표시 --%>
                                <c:forEach var="item" items="${insttMap}">
                                    <option value="${item.key}"${item.key eq eduLctreVO.searchInsttNo ? ' selected="true"':''}>
                                            ${item.value}
                                    </option>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <%-- 최고관리자: 전체 기관 표시 --%>
                                <c:forEach var="instt" items="${eduInsttList}">
                                    <option value="${instt.insttNo}"${instt.insttNo eq eduLctreVO.searchInsttNo ? ' selected="true"':''}>
                                        <c:out value="${instt.insttNm}"/>
                                    </option>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </select>
                </td>
                <th scope="row"><label for="ctgryNm">카테고리명</label> <span class="p-form__required--icon">필수</span></th>
                <td>
                    <input type="text" id="ctgryNm" name="ctgryNm" required="required" class="p-input w300"
                           maxlength="50"/>
                </td>
                <th scope="row" class="ta_center">
                    <button type="button" onclick="fn_registCategory();" class="p-button write">등록</button>
                </th>
            </tr>
            </tbody>
        </table>

        <div class="row p-relative margin_t_20">
            <div class="col-6 margin_t_5">
                <p>
                    <span>총 <strong><fmt:formatNumber value="${paginationInfo.totalRecordCount}"
                                                      pattern="#,###"/></strong> 건</span>
                    <span class="division_line">[ <strong><c:out
                            value="${paginationInfo.currentPageNo}"/></strong> / <c:out
                            value="${paginationInfo.totalPageCount}"/> 페이지 ]</span>
                </p>
            </div>
        </div>
        <table class="p-table p-table--bordered">
            <caption><c:out value="${menuInfo.cntntsNm}"/> 목록 - 번호, 기관명, 카테고리명, 사용여부, 관리</caption>
            <colgroup>
                <col class="w60">
                <col>
                <col>
                <col class="w120">
                <col class="w180">
            </colgroup>
            <thead>
            <tr>
                <th scope="col">번호</th>
                <th scope="col">기관명</th>
                <th scope="col">카테고리명</th>
                <th scope="col">사용여부</th>
                <th scope="col">관리</th>
            </tr>
            </thead>
            <tbody class="text_center">
            <c:set var="pageNo" value="${paginationInfo.currentPageStartNo}"/>
            <c:forEach var="result" items="${eduCategoryList}" varStatus="status">
                <tr class="colored">
                    <td><c:out value="${pageNo}"/></td>
                        <%-- 기관명 --%>
                    <td class="text_left"><c:out value="${result.insttNm}"/></td>
                        <%-- 카테고리명 --%>
                    <td class="text_left"><c:out value="${result.ctgryNm}"/></td>
                    <td>
                        <span class="p-switcher p-switcher--single">
                            <input type="checkbox" class="p-switcher__input" id="useYn${result.ctgryNo}"<c:if test="${result.useYn eq 'Y'}"> checked</c:if> value="${result.ctgryNo}" onchange="fn_useYn(this, '${result.ctgryNo}', '${result.useYn}')">
                            <label for="useYn${result.ctgryNo}" class="p-switcher__label"><em class="p-switcher__text blind">사용</em></label>
                        </span>
                    </td>
                    <td>
                        <button type="button" data-button="modal" data-id="${result.insttNo}"
                                data-name="${result.ctgryNm}" data-no="${result.ctgryNo}"
                                class="p-button p-button--xsmall edit update-modal">수정
                        </button>
                        <button type="button" onclick="fn_deleteCategory('${result.ctgryNo}');"
                                class="p-button p-button--xsmall delete">삭제
                        </button>
                    </td>
                </tr>
                <c:set var="pageNo" value="${pageNo-1}"/>
            </c:forEach>
            <c:if test="${fn:length(eduCategoryList) == 0}">
                <tr>
                    <td colspan="5" class="empty">등록된 카테고리가 없습니다</td>
                </tr>
            </c:if>
            </tbody>
        </table>

        <div class="row">
            <div class="col-24 center">
                <div class="p-pagination">
                    <div class="p-page">
                        <ui:pagination paginationInfo="${paginationInfo}" type="board"
                                       jsFunction="./selectEduCategoryList.do?${eduCategoryVO.paramsExclPi}&amp;pageIndex="/>
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>

<!--//update modal -->
<div class="modal" id="updateCategory" tabindex="0" role="dialog">
    <div class="modal__body">
        <div class="modal__header">
            <div class="modal__title">카테고리 수정</div>
        </div>
        <div class="modal__content" style="text-align:center;">
            <input type="hidden" id="ctgryNo"/>
            <table class="p-table">
                <colgroup>
                    <col class="w20p">
                    <col/>
                </colgroup>
                <tr>
                    <th>기관명</th>
                    <td class="text_left">
                        <select id="insttNoUp" class="p-input p-input--auto" title="기관명 선택">
                            <option value="">선택하세요</option>
                            <c:forEach var="instt" items="${eduInsttList}">
                                <option value="${instt.insttNo}"${instt.insttNo eq eduCategoryVO.searchInsttNo ? ' selected="true"':''}><c:out value="${instt.insttNm}"/></option>
                            </c:forEach>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th>카테고리명</th>
                    <td class="text_left"><input type="text" id="ctgryNmUp" class="p-input" placeholder="카테고리명 입력"/>
                    </td>
                </tr>
            </table>
            <div>
                <button type="button" onclick="fn_updateCategory();" class="p-button write" style="z-index:10001;">수정
                </button>
            </div>
        </div>
        <div class="modal__footer">
            <button type="button" class="p-button default" data-close="modal">닫기</button>
        </div>
        <div class="modal__close">
            <button type="button" data-close="modal" class="modal-button_close"><span>X</span></button>
        </div>
        <!-- <div class="modal__close"><button type="button" data-close="modal" class="modal__close-button"><span>닫기</span></button></div> -->
    </div>
</div>

<script nonce="NEOCMSSCRIPT">
    //카테고리 등록
    function fn_registCategory() {
        var insttNo = $('#insttNo').val();
        var ctgryNm = $('#ctgryNm').val();

        if (!insttNo) {
            alert("기관을 선택해주세요.");
            $('#insttNo').focus();
            return false;
        }
        if (!ctgryNm) {
            alert("카테고리명을 입력해주세요.");
            $('#ctgryNm').focus();
            return false;
        }
        $.ajax({
            url: './ajaxRegistEduCategory.do?key=${key}',
            type: 'POST',
            cache: false,
            data: {'insttNo': insttNo, 'ctgryNm': ctgryNm},
            success: function (res) {
                if (res == 1) {
                    alert("등록되었습니다.");
                    window.location.reload();
                } else if (res == 2) {
                    alert("기관명을 선택하세요.");
                } else if (res == 3) {
                    alert("카테고리명을 입력하세요.");
                } else if (res == 0) {
                    alert("등록에 실패하였습니다. 다시 진행해주세요.");
                }
            },
            error: function (request, xhr, status) {
                alert("에러가 발생하였습니다.");
            }
        });
    }

    //카테고리 수정 폼
    $(".update-modal").on("click", function () {
        $(this).modalPop({
            target: "#updateCategory",
            width: "540",
            height: "170"
        });

        var ctgryNo = $(this).data("no");
        var insttNo = $(this).data("id");
        var ctgryNm = $(this).data("name");
        $("#ctgryNo").val(ctgryNo);
        $("#insttNoUp").val(insttNo);
        $("#ctgryNmUp").val(ctgryNm);
    });

    //카테고리 수정
    function fn_updateCategory() {
        var ctgryNo = $('#ctgryNo').val();
        var insttNo = $('#insttNoUp').val();
        var ctgryNm = $('#ctgryNmUp').val();

        if (!insttNo) {
            alert("기관을 선택해주세요.");
            $('#insttNoUp').focus();
            return false;
        }
        if (!ctgryNm) {
            alert("카테고리명을 입력해주세요.");
            $('#ctgryNmUp').focus();
            return false;
        }
        $.ajax({
            url: './ajaxUpdateEduCategory.do?key=${key}',
            type: 'POST',
            cache: false,
            data: {'ctgryNo': ctgryNo, 'insttNo': insttNo, 'ctgryNm': ctgryNm},
            success: function (res) {
                if (res == 1) {
                    alert("수정되었습니다.");
                    window.location.reload();
                } else if (res == 2) {
                    alert("카테고리 번호가 넘어오지 않았습니다.");
                } else if (res == 3) {
                    alert("기관명을 선택하세요.");
                } else if (res == 4) {
                    alert("카테고리명을 입력하세요.");
                } else if (res == 9) {
                    alert("카테고리 구분값이 넘어오지 않았습니다.");
                } else if (res == 0) {
                    alert("수정에 실패하였습니다. 다시 진행해주세요.");
                }
            },
            error: function (request, xhr, status) {
                alert("에러가 발생하였습니다.");
            }
        });
    }

    //사용여부 변경
    function fn_useYn(el, ctgryNo, useYn){
        var newUseYn = el.checked ? 'Y' : 'N';

        $.ajax({
            url: './ajaxEduCategoryUseYn.do?key=${key}',
            type: 'POST',
            cache: false,
            data: {"ctgryNo":ctgryNo, "useYn":newUseYn},
            success: function (res) {
                if(res == 1) alert("변경되었습니다.");
                else if(res == 2) alert("잘못된 접근입니다.");
                else if(res == 0) alert("변경에 실패하였습니다.");
                $('.p-wrap').load(location.href+' .p-wrap');
            },
            error: function (request,xhr, status) {
                alert("에러가 발생하였습니다.");
                $('.p-wrap').load(location.href+' .p-wrap');
            }
        });
    }

    //삭제
    function fn_deleteCategory(ctgryNo) {
        if (confirm("한 번 삭제한 정보는 복구할 수 없습니다.\n해당 카테고리를 정말 삭제하시겠습니까?")) {
            $.ajax({
                url: './ajaxDeleteEduCategory.do?key=${key}',
                type: 'POST',
                cache: false,
                data: {"ctgryNo": ctgryNo},
                success: function (res) {
                    if (res == 1) {
                        alert("삭제되었습니다.");
                    } else if (res == 2) {
                        alert("해당 카테고리를 사용 중인 과목이 있어 삭제할 수 없습니다.\n먼저 해당 과목을 삭제 후 삭제해주세요.");
                    } else if (res == 3) {
                        alert("해당 카테고리를 사용 중인 강좌가 있어 삭제할 수 없습니다.\n먼저 해당 강좌를 삭제 후 삭제해주세요.");
                    } else if (res == 4) {
                        alert("해당 카테고리를 사용 중인 과목 및 강좌가 있어 삭제할 수 없습니다.\n먼저 해당 과목 및 강좌를 삭제 후 삭제해주세요.");
                    } else if (res == 0) {
                        alert("삭제에 실패하였습니다.");
                    }
                    window.location.reload();
                },
                error: function (request, xhr, status) {
                    alert("에러가 발생하였습니다.");
                    window.location.reload();
                }
            });
        }
    }

</script>

</body>
</html>
