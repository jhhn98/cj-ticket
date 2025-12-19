<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="tsu" uri="http://www.hanshinit.co.kr/jstl/tagStringUtil"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>

<jsp:include page="/repository/common/search/searchTop.jsp" />
            
			<section class="searchDetailResult">
                <div class="titleArea">
                    <h4>게시판</h4>
                    <span class="resultCount">총 <c:out value="${totCntMap['BORD']}"/>건</span>
                </div>
		<c:if test="${!empty nttList}">
                <ul class="textList-searchResult">
			<c:forEach var="item" items="${nttList}">
                    <li>
                        <a href="<c:out value="${item.nttLink}"/>" target="_blank">
                            <span class="title">
                                <em class="titleText"><c:out value="${item.nttSj}"/></em><em class="date"><c:out value="${tsu:toDateFormat(item.rgsde,'yyyyMMddHHmmss','yyyy.MM.dd')}"/></em>
                            </span>
                            <span class="text"><c:out value="${item.nttCn}"/></span>
                            <span class="url"><c:out value="${item.nttLink}"/></span>
                        </a>
                    </li>
			</c:forEach>
                </ul>
		</c:if>

                <div class="p-pagination">
                    <div class="p-page">
					<ui:pagination paginationInfo="${paginationInfo}" type="board" jsFunction="./searchList.do?${searchInfoVO.paramsExclPi}&amp;pageIndex=" />
                    </div>
                </div>
				
            </section>
			
<jsp:include page="/repository/common/search/searchBottom.jsp" />