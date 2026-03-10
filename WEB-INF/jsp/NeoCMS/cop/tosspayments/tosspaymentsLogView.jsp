<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="tsu" uri="http://www.hanshinit.co.kr/jstl/tagStringUtil"%>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="decorator" content="${menuInfo.siteId}" />
    <link rel="stylesheet" type="text/css" href="/common/css/default.css" />
    <link rel="stylesheet" type="text/css" href="/common/css/program.css" />
    <script src="/common/js/program.js"></script>
    <title>${menuInfo.cntntsNm} 목록</title>
    
</head>
<body>

<div class="p-wrap">

    <div class="toss-log-wrapper" style="display: flex;">
        <c:forEach var="result" items="${tosspaymentsLogList}">
            <div class="toss-log-card">
                <div>기본정보</div>
                <div><strong>결제이력번호:</strong> ${result.tossLogNo}</div>
                <div><strong>신청번호:</strong> ${result.applNo}</div>
                <div><strong>신청자명:</strong> ${result.applNm}</div>
                <div><strong>연락처:</strong> ${result.mobileNo}</div>
                <div><strong>프로그램구분:</strong> ${result.prgSe}</div>

                <div>공통필드</div>
                <div><strong>paymentKey:</strong> ${result.paymentKey}</div>
                <div><strong>orderId:</strong> ${result.orderId}</div>
                <div><strong>status:</strong> ${result.status}</div>
                <div><strong>requestedAt:</strong> ${result.requestedAt}</div>

                <div>카드</div>
                <div><strong>cardAmount:</strong> ${result.cardAmount}</div>
                <div><strong>issuer:</strong> ${result.cardIssuerCode}</div>

                <div>가상계좌</div>
                <div><strong>vaNumber:</strong> ${result.vaAccountNumber}</div>

                <div>취소</div>
                <div><strong>cancelAmount:</strong> ${result.cancelAmount}</div>

                <div>현금영수증</div>
                <div><strong>receiptKey:</strong> ${result.cashReceiptReceiptKey}</div>

            </div>
        </c:forEach>
    </div>


</div>

</body>
</html>
