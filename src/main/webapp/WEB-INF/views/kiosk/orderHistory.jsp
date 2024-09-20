<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Order History</title>
    <style>
        body {
            background-color: #f0f0f0;
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
            background-color: #fff;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        h2 {
            font-size: 28px;
            color: rgba(248, 124, 124, 0.99);
            text-align: center;
            margin-bottom: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
        }

        table, th, td {
            border: 1px solid #ddd;
        }

        th, td {
            padding: 12px;
            text-align: left;
        }

        th {
            background-color: rgba(248, 124, 124, 0.99);
            color: white;
        }

        tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        tr:hover {
            background-color: #ddd;
        }

        .order-summary {
            margin-top: 20px;
            font-size: 18px;
            text-align: right;
        }

        .order-summary p {
            color: #333;
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
            background-color: rgba(248, 124, 124, 0.99);
            border-radius: 8px;
            border: none;
            cursor: pointer;
            color: white;
            text-align: center;
        }

        a button:hover {
            background-color: #ec0303;
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
                <td>${item[0].quantityPrice} 원</td>

                <td>${fn:substring(item[1], 0, 19)}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <c:if test="${not empty orderList}">
        <div class="order-summary">
            <p><strong>결제 예정 금액:</strong> <c:out value="${totalPrice}"/> 원</p>
        </div>
    </c:if>

    <div class="button-container">
        <a href="menu"><button>메뉴판</button></a>
    </div>
</div>
</body>
</html>
