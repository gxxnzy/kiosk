<%--
  Created by IntelliJ IDEA.
  User: KOSA
  Date: 24. 9. 13.
  Time: 오전 11:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
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
<h1>Order Summary</h1>
<table>
    <thead>
    <tr>
        <th>Menu Name</th>
        <th>Price</th>
        <th>Quantity</th>
        <th>Total</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="item" items="${cartItems}">
        <tr>
            <td><c:out value="${item.menuName}"/></td>
            <td><c:out value="${item.menuPrice}"/>원</td>
            <td><c:out value="${item.quantity}"/></td>
            <td><c:out value="${item.menuPrice * item.quantity}"/>원</td>
        </tr>
    </c:forEach>
    </tbody>
</table>
</body>
</html>
