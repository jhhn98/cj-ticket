<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="tsu" uri="http://www.hanshinit.co.kr/jstl/tagStringUtil"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>

<jsp:include page="/repository/common/search/searchTop.jsp" />

			<section class="searchDetailResult">
                <div class="titleArea">
                    <h4>공연/영화</h4>
                    <span class="resultCount">총 <c:out value="${totCntMap['MNH']}"/>건</span>
                </div>
                <c:if test="${!empty pblprfrApiList}">
                    <ul class="imageList-searchResult">
                        <c:forEach var="item" items="${pblprfrApiList}">
                            <li>
                                <a href="<c:out value="${item.link}"/>">
                                    <c:choose>
                                        <c:when test="${not empty item.img}">
                                            <c:choose>
                                                <c:when test="${fn:contains(item.img, 'default_poster.jpg')}">
                                                    <span class="image no-image"><img src="/site/www/images/search/img-logo.png" alt="<c:out value="${item.title}"/>"></span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="image"><img src="<c:out value="${item.img}"/>" alt="<c:out value="${item.title}"/>"></span>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="image no-image"><img src="/site/www/images/search/img-logo.png" alt="<c:out value="${item.title}"/>"></span>
                                        </c:otherwise>
                                    </c:choose>
                                    <span class="place"><c:out value="${item.place}"/></span>
                                    <span class="title"><c:out value="${item.title}"/></span>
                                    <span class="date"><c:out value="${item.pubDate}"/></span>
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

</body>
</html>