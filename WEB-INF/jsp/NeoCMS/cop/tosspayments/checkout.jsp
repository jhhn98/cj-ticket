<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:if test="${!empty tossConfig}">
    <c:set var="payMethod" value="${tossConfig.payMethod}" />
    <c:set var="payMethodArr" value="${fn:split(payMethod, '|')}" />
<!-- 주문서 영역 -->
<div class="editFormPayWrap">
    <c:if test="${fn:contains(payMethod, 'C')}">
    <label for="payType1" class="customRadioButton">
        <input type="radio" id="payType1" name="payType" onclick="selectPaymentMethod('C')"<c:if test="${fn:contains(payMethod, 'C') && fn:length(payMethodArr) == 1}"> checked</c:if>>
        <span class="customStyle">
            <i class="radioButton"></i>
            <span>신용카드</span>
        </span>
    </label>
    </c:if>
    <c:if test="${fn:contains(payMethod, 'V')}">
    <label for="payType2" class="customRadioButton">
        <input type="radio" id="payType2" name="payType" onclick="selectPaymentMethod('V')"<c:if test="${fn:contains(payMethod, 'V') && fn:length(payMethodArr) == 1}"> checked</c:if>>
        <span class="customStyle">
            <i class="radioButton"></i>
            <span>가상계좌</span>
        </span>
    </label>
    </c:if>
    <c:if test="${fn:contains(payMethod, 'T')}">
    <label for="payType3" class="customRadioButton">
        <input type="radio" id="payType3" name="payType" onclick="selectPaymentMethod('T')"<c:if test="${fn:contains(payMethod, 'T') && fn:length(payMethodArr) == 1}"> checked</c:if>>
        <span class="customStyle">
            <i class="radioButton"></i>
            <span>계좌이체</span>
        </span>
    </label>
    </c:if>
    <a href="" class="payButton" onclick="requestPayment(); return false;"><span>결제하기</span></a>
</div>

<!-- SDK 추가 -->
<script src="https://js.tosspayments.com/v2/standard"></script>
<script>
    const amount = {
        currency: "KRW",
        value: <c:out value="${tosspayments.totalPayAmt}"/>,
    };

    let selectedPaymentMethod = '<c:if test="${fn:length(payMethodArr) == 1}"><c:out value="${payMethod}"/></c:if>';

    function selectPaymentMethod(method) {
    selectedPaymentMethod = method;
    }

    // ------  SDK 초기화 ------
    // TODO: clientKey는 개발자센터의 API 개별 연동 키 > 결제창 연동에 사용하려할 MID > 클라이언트 키로 바꾸세요.
    // TODO: server.js 의 secretKey 또한 결제위젯 연동 키가 아닌 API 개별 연동 키의 시크릿 키로 변경해야 합니다.
    // TODO: 구매자의 고유 아이디를 불러와서 customerKey로 설정하세요. 이메일・전화번호와 같이 유추가 가능한 값은 안전하지 않습니다.
    // @docs https://docs.tosspayments.com/sdk/v2/js#토스페이먼츠-초기화
    const clientKey = '<c:out value="${tossConfig.clientKey}"/>';
    const customerKey = '<c:out value="${tosspayments.orderId}"/>';
    const tossPayments = TossPayments(clientKey);
    // 회원 결제
    // @docs https://docs.tosspayments.com/sdk/v2/js#tosspaymentspayment
    const payment = tossPayments.payment({
      customerKey,
    });

    // ------ '결제하기' 버튼 누르면 결제창 띄우기 ------
    // @docs https://docs.tosspayments.com/sdk/v2/js#paymentrequestpayment
    async function requestPayment() {
        // 결제를 요청하기 전에 orderId, amount를 서버에 저장하세요.
        // 결제 과정에서 악의적으로 결제 금액이 바뀌는 것을 확인하는 용도입니다.
        switch (selectedPaymentMethod) {
            case "C":
                await payment.requestPayment({
                    method: "CARD", // 카드 및 간편결제
                    amount,
                    orderId: "<c:out value="${tosspayments.orderId}"/>",
                    orderName: "<c:out value="${tosspayments.orderName}"/>",
                    successUrl: window.location.origin + "/tosspaymentsSuccess.do", // 결제 요청이 성공하면 리다이렉트되는 URL
                    failUrl: window.location.origin + "/tosspaymentsFail.do", // 결제 요청이 실패하면 리다이렉트되는 URL
                    customerName: "<c:out value="${tosspayments.applNm}"/>",
                    // 가상계좌 안내, 퀵계좌이체 휴대폰 번호 자동 완성에 사용되는 값입니다. 필요하다면 주석을 해제해 주세요.
                    // customerMobilePhone: "01012341234",
                    card: {
                        useEscrow: false,
                        flowMode: "DEFAULT",
                        useCardPoint: false,
                        useAppCardOnly: false,
                    },
                });
            case "T":
                await payment.requestPayment({
                    method: "TRANSFER", // 계좌이체 결제
                    amount,
                    orderId: "<c:out value="${tosspayments.orderId}"/>",
                    orderName: "<c:out value="${tosspayments.orderName}"/>",
                    successUrl: window.location.origin + "/tosspaymentsSuccess.do",
                    failUrl: window.location.origin + "/tosspaymentsFail.do",
                    customerName: "<c:out value="${tosspayments.applNm}"/>",
                    // 가상계좌 안내, 퀵계좌이체 휴대폰 번호 자동 완성에 사용되는 값입니다. 필요하다면 주석을 해제해 주세요.
                    // customerMobilePhone: "01012341234",
                    transfer: {
                        cashReceipt: {
                            type: "소득공제",
                        },
                        useEscrow: false,
                    },
                });
            case "V":
                await payment.requestPayment({
                    method: "VIRTUAL_ACCOUNT", // 가상계좌 결제
                    amount,
                    orderId: "<c:out value="${tosspayments.orderId}"/>",
                    orderName: "<c:out value="${tosspayments.orderName}"/>",
                    successUrl: window.location.origin + "/tosspaymentsSuccess.do",
                    failUrl: window.location.origin + "/tosspaymentsFail.do",
                    customerName: "<c:out value="${tosspayments.applNm}"/>",
                    // 가상계좌 안내, 퀵계좌이체 휴대폰 번호 자동 완성에 사용되는 값입니다. 필요하다면 주석을 해제해 주세요.
                    // customerMobilePhone: "01012341234",
                    virtualAccount: {
                        cashReceipt: {
                            type: "소득공제",
                        },
                        useEscrow: false,
                        validHours: 24,
                    },
                });
            default :
                alert("결제수단을 선택해주세요.");
        }
    }

</script>
</c:if>

<c:if test="${empty tossConfig}">
    <div class="editFormPayWrap">
        전자결제를 사용할 수 없습니다. 운영기관에 문의해주세요.
    </div>
</c:if>