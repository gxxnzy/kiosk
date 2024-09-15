<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Store Sales</title>
    <style>
        h1 {
            text-align: center;
        }
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
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
        form {
            margin-bottom: 20px;
            text-align: right; /* Align form elements to the right */
        }
        .total-sales {
            text-align: right; /* Align total sales to the right */
            margin-top: 20px;
        }
        .logout {
            display: inline-block;
            margin-left: 20px;
            text-decoration: none;
            color: #007BFF;
        }
        .store-name {
            display: inline-block;
            margin-right: 20px; /* Add space between store name and logout link */
        }
    </style>
</head>
<body>
<h1>점포 관리</h1>
<form action="/store/sales" method="post">
    <c:if test="${not empty selectedStore}">
        <span class="store-name">현재 지점: ${selectedStore}</span> <!-- Display selected store name -->
    </c:if>
    <a href="/logout" class="logout">로그아웃</a> <!-- Logout link -->
</form>
<hr>
<table>
    <thead>
    <tr>
        <th>메뉴 이름</th>
        <th>주문 수</th>
        <th>가격</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="detail" items="${orderDetails}">
        <tr>
            <td><c:out value="${detail.menuName}"/></td>
            <td><c:out value="${detail.quantity}개"/></td>
            <td><c:out value="${detail.quantityPrice}원"/></td>
        </tr>
    </c:forEach>
    </tbody>
</table>
<hr>
<div class="total-sales">
    <c:if test="${not empty totalSales}">
        <h2>총 결제 금액 : ${totalSales}원</h2>
    </c:if>
</div>
</body>
</html>
