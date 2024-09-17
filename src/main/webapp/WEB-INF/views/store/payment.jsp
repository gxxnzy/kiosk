<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Payment Management</title>
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
        .total-sales {
            text-align: right;
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
            margin-right: 20px;
        }
        .nav-links {
            margin-left: 20px;
            text-decoration: none;
            color: #007BFF;
        }
    </style>
</head>
<body>
<h1>결제 관리 / <a href="/store/main" class="nav-links">점포 관리</a></h1>
<form action="/store/payment" method="get">
    <c:if test="${not empty selectedStore}">
        <span class="store-name">현재 지점: ${selectedStore}</span>
    </c:if>
    <a href="/logout" class="logout">로그아웃</a>
</form>
<hr>
<table>
    <thead>
    <tr>
        <th>키오스크 ID</th>
        <th>키오스크 번호</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="kiosk" items="${kiosksList}">
        <tr>
            <td><c:out value="${kiosk.kioskId}"/></td>
            <td><c:out value="${kiosk.kioskNum}"/></td>
        </tr>
    </c:forEach>
    </tbody>
</table>
</body>
</html>
