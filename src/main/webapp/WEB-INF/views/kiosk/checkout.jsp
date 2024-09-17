<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Checkout</title>
    <style>
      table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
      }
      th, td {
        padding: 10px;
        text-align: left;
        border: 1px solid #ddd;
      }
      th {
        background-color: #f4f4f4;
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
            <p><strong>가격:</strong> <c:out value="${item.menuPrice}"/>원</p> <!-- 단가 -->
            <p><strong>수량:</strong> <c:out value="${item.quantity}"/></p> <!-- 수량 -->
            <p><strong>총 가격:</strong> <c:out value="${item.menuPrice * item.quantity}"/>원</p> <!-- 총 가격 -->
            <hr>
        </div>
    </c:forEach>

    <c:if test="${not empty cartItems}">
        <div class="order-summary">
            <p><strong>결제 금액:</strong> <c:out value="${totalAmount}"/> 원</p> <!-- 총 결제 금액 -->
        </div>
    </c:if>
</div>
<form action="/kiosk/order" method="post">
    <button type="submit">주문 완료</button></a>
</form>
</body>
</html>
