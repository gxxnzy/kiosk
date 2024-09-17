<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Order History</title>
    <style>
      table {
        width: 100%;
        border-collapse: collapse;
        margin: 20px 0;
      }

      table, th, td {
        border: 1px solid #ddd;
      }

      th, td {
        padding: 8px;
        text-align: left;
      }

      th {
        background-color: #f2f2f2;
      }

      tr:nth-child(even) {
        background-color: #f9f9f9;
      }

      tr:hover {
        background-color: #ddd;
      }
    </style>
</head>
<body>
<h2>주문 내역</h2>

<table>
    <thead>
    <tr>
        <th>메뉴 이름</th>
        <th>수량</th>
        <th>가격</th>
        <th>주문 시간</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="item" items="${orderList}">
        <tr>
            <!-- 첫 번째 요소는 OrderDetails 객체 -->
            <td>${item[0].menuName}</td>
            <td>${item[0].quantity}</td>
            <td>${item[0].quantityPrice}</td>
            <!-- 두 번째 요소는 Order Time -->
            <td>${fn:substring(item[1], 0, 19)}</td>
        </tr>
    </c:forEach>
    </tbody>
</table>
<c:if test="${not empty orderList}">
    <div class="order-summary">
        <p><strong>결제 예정 금액:</strong> <c:out value="${totalPrice}"/> 원</p> <!-- 총 결제 금액 -->
    </div>
</c:if>
<a href="menu"><button style="width: 200px; height: 40px; font-size: 20px; background-color: #cecdcd; border-radius: 8px; border: none; cursor: pointer;">메뉴판</button></a>
</body>
</html>
