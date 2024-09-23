<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %><!-- 숫자 포맷 -->

<html>
<head>
    <meta charset="UTF-8">
    <title>Checkout</title>
    <style>
      body {
        font-family: Arial, sans-serif;
        background-color: rgba(255, 255, 255, 0.97); /* 연한 파란색 배경 */
        margin: 0;
        padding: 20px;
      }

      h1, h2, h3 {
        color: #333; /* 검은색 */
        text-align: center;
      }

      .order-summary {
        margin-top: 20px;
        border: 1px solid #ddd;
        padding: 20px;
        border-radius: 8px;
        background-color: #fff; /* 흰색 배경 */
        max-width: 600px;
        margin-left: auto;
        margin-right: auto;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
      }

      .order-item {
        margin-bottom: 20px;
        border-bottom: 1px solid #ddd;
        padding-bottom: 10px;
      }

      .order-item p {
        margin: 5px 0;
        color: #333; /* 검은색 */
      }

      .order-item p strong {
        color: #c3bef0; /* 연한 보라색 */
      }

      button {
        background-color: #c3bef0; /* 연한 보라색 */
        color: white;
        border: none;
        padding: 10px 20px;
        font-size: 16px;
        cursor: pointer;
        border-radius: 4px;
        display: block;
        width: 200px;
        margin: 20px auto 0 auto;
        text-align: center;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
      }

      button:hover {
        background-color: #afc5ff; /* 더 연한 보라색 */
      }

      table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
        max-width: 600px;
        margin-left: auto;
        margin-right: auto;
      }

      th, td {
        padding: 10px;
        text-align: left;
        border: 1px solid #ddd;
      }

      th {
        background-color: #c3bef0; /* 연한 보라색 */
        color: white;
      }

      td {
        color: #333; /* 검은색 */
      }
      a {
        text-decoration: none;
      }
    </style>
</head>
<body>
<h1>주문 내역서</h1>
<h2>${kiosks.storeName}</h2>
<h3>${kiosks.kioskNum}번 테이블</h3>

<div class="order-summary">
    <c:forEach var="item" items="${cartItems}">
        <div class="order-item">
            <p><strong>메뉴 이름:</strong> <c:out value="${item.menuName}"/></p> <!-- 메뉴 이름 -->
            <p><strong>가격:</strong> <fmt:formatNumber value="${item.menuPrice}" type="number"/>원</p> <!-- 단가 -->
            <p><strong>수량:</strong> <c:out value="${item.quantity}"/></p> <!-- 수량 -->
            <p><strong>총 가격:</strong> <fmt:formatNumber value="${item.menuPrice * item.quantity}" type="number"/>원</p> <!-- 총 가격 -->
        </div>
    </c:forEach>

    <c:if test="${not empty cartItems}">
        <div class="order-summary">
            <p><strong>결제 금액:</strong> <fmt:formatNumber value="${totalAmount}" type="number"/>원</p> <!-- 총 결제 금액 -->
        </div>
    </c:if>
</div>
<a href="menu"><button>뒤로 가기</button></a>
<form action="/kiosk/order" method="post">
    <button type="submit">주문 완료</button>
</form>
</body>
</html>
