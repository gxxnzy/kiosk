<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %><!-- 숫자 포맷 -->

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Order History</title>
    <style>
      body {
        background-color: #ffffff; /* 흰색 배경 */
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 20px;
        display: flex;
        justify-content: center;
        align-items: flex-start;
        min-height: 100vh;
      }

      .container {
        width: 80%;
        max-width: 1000px;
        background-color: #fff; /* 흰색 배경 */
        padding: 40px;
        border-radius: 10px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
      }

      h2 {
        font-size: 28px;
        color: rgba(2, 2, 2, 0.97); /* 연한 보라색 */
        text-align: center;
        margin-bottom: 20px;
      }

      table {
        width: 100%;
        border-collapse: collapse;
        margin: 20px 0;
      }

      table, th, td {
        border: 1px solid #ddd; /* 연한 회색 테두리 */
      }

      th, td {
        padding: 12px;
        text-align: left;
      }

      th {
        background-color: #c3bef0; /* 연한 보라색 */
        color: white; /* 흰색 글자 */
      }

      tr:nth-child(even) {
        background-color: #f9f9f9; /* 연한 회색 배경 */
      }

      tr:hover {
        background-color: #e0e0e0; /* 더 연한 회색 배경 */
      }

      .order-summary {
        margin-top: 20px;
        font-size: 18px;
        text-align: right;
      }

      .order-summary p {
        color: #333; /* 검은색 */
        font-weight: bold;
      }

      /* 버튼 스타일 */
      .button-container {
        display: flex;
        justify-content: center;
        margin-top: 20px; /* 버튼과 위 요소 간의 간격 */
      }

      a button {
        width: 200px;
        height: 40px;
        font-size: 20px;
        background-color: #c3bef0; /* 연한 보라색 */
        border-radius: 8px;
        border: none;
        cursor: pointer;
        color: white; /* 흰색 글자 */
        text-align: center;
      }

      a button:hover {
        background-color: #afc5ff; /* 더 연한 보라색 */
      }
    </style>
</head>
<body>
<div class="container">
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
                <td>${item[0].menuName}</td>
                <td>${item[0].quantity}</td>
                <td><fmt:formatNumber value="${item[0].quantityPrice}" type="number"/>원</td>
                <td>${fn:substring(item[1], 0, 19)}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <c:if test="${not empty orderList}">
        <div class="order-summary">
            <p><strong>결제 예정 금액:</strong> <fmt:formatNumber value="${totalPrice}" type="number"/>원</p>
        </div>
    </c:if>

    <div class="button-container">
        <a href="menu"><button>메뉴판</button></a>
    </div>
</div>
</body>
</html>
