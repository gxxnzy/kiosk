<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!-- 추가된 fmt 태그 라이브러리 -->
<!DOCTYPE html>
<html>
<head>
    <title>Kiosk Order Details</title>
    <style>
      body {
        font-family: 'Arial', sans-serif;
        margin: 0;
        padding: 0;
        background-color: #f4f4f4;
      }

      header {
        background-color: rgba(248, 124, 124, 0.99); /* 헤더 색상 변경 */
        color: white;
        padding: 10px 20px;
        text-align: center;
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
      }

      header h1 {
        margin: 0;
        font-size: 24px;
      }

      .container {
        width: 80%;
        margin: 20px auto;
        background: white;
        padding: 20px;
        border-radius: 5px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        position: relative;
        min-height: 400px;
      }

      table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
      }

      th, td {
        padding: 15px;
        text-align: left;
        border: 1px solid #ddd;
      }

      th {
        background-color: rgba(248, 124, 124, 0.99); /* 테이블 헤더 색상 변경 */
        color: white;
      }

      tbody tr:nth-child(even) {
        background-color: #f9f9f9;
      }

      tbody tr:hover {
        background-color: #e9ecef;
      }

      .total-amount {
        text-align: right;
        margin-top: 20px;
      }

      .btn-submit {
        display: block;
        padding: 10px 20px;
        font-size: 16px;
        color: white;
        background-color: rgba(248, 124, 124, 0.99); /* 버튼 색상 변경 */
        border: none;
        border-radius: 3px;
        cursor: pointer;
        text-decoration: none;
        margin-top: 20px;
        text-align: center;
        position: absolute;
        bottom: 20px;
        right: 20px;
      }

      .btn-submit:hover {
        background-color: #ec0303; /* 버튼 호버 색상 변경 */
      }

      .store-name {
        color: black; /* 현재 지점 글씨 색을 검은색으로 설정 */
        font-weight: bold;
        font-size: 18px;
      }
    </style>
</head>
<body>
<header>
    <h1>테이블 ${kioskNum}번 키오스크 주문 내역</h1>
</header>
<div class="container">
    <!-- 현재 지점 표시 -->
    <c:if test="${not empty selectedStore}">
        <div class="store-name">현재 지점: ${selectedStore}</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/store/updatePaymentStatus" method="post">
        <table>
            <thead>
            <tr>
                <th>메뉴 이름</th>
                <th>수량</th>
                <th>가격</th>
            </tr>
            </thead>
            <tbody>
            <c:set var="processedMenus" value=""/>
            <c:set var="currentMenu" value=""/>
            <c:set var="currentQuantity" value="0"/>
            <c:set var="currentPrice" value="0"/>

            <!-- 메뉴별 수량과 가격을 합산 -->
            <c:forEach var="detail" items="${orderDetailsList}">
                <c:if test="${not fn:contains(processedMenus, detail.menuName)}">
                    <!-- 메뉴 이름, 수량, 가격을 초기화 -->
                    <c:set var="currentMenu" value="${detail.menuName}"/>
                    <c:set var="currentQuantity" value="0"/>
                    <c:set var="currentPrice" value="0"/>

                    <!-- 동일한 메뉴의 수량과 가격을 합산 -->
                    <c:forEach var="sameMenuDetail" items="${orderDetailsList}">
                        <c:if test="${sameMenuDetail.menuName == currentMenu}">
                            <c:set var="currentQuantity"
                                   value="${currentQuantity + sameMenuDetail.quantity}"/>
                            <c:set var="currentPrice"
                                   value="${currentPrice + sameMenuDetail.quantityPrice}"/>
                        </c:if>
                    </c:forEach>

                    <!-- 합산된 메뉴 출력 -->
                    <tr>
                        <td><c:out value="${currentMenu}"/></td>
                        <td><c:out value="${currentQuantity}"/></td>
                        <td><fmt:formatNumber value="${currentPrice}" type="number"/> 원</td>
                        <!-- 쉼표 처리된 가격 -->
                    </tr>

                    <!-- 처리된 메뉴를 기록 -->
                    <c:set var="processedMenus" value="${processedMenus},${currentMenu}"/>
                </c:if>

                <!-- 각 주문 ID를 hidden input으로 포함시킴 -->
                <input type="hidden" name="orderIds" value="${detail.order.orderId}"/>
            </c:forEach>
            </tbody>
        </table>
        <input type="hidden" name="kioskNum" value="${kioskNum}"/>
        <div class="total-amount">
            <h2>총 결제 금액 : <fmt:formatNumber value="${totalAmount}" type="number"/> 원</h2>
            <!-- 총 금액도 쉼표 처리 -->
        </div>
        <button type="submit" class="btn-submit">결제 완료</button>
    </form>
</div>
</body>
</html>
