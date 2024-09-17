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
        .btn-select {
            display: inline-block;
            padding: 5px 10px;
            font-size: 14px;
            color: #fff;
            background-color: #007BFF;
            border: none;
            border-radius: 3px;
            cursor: pointer;
            text-decoration: none;
        }
        .btn-select:hover {
            background-color: #0056b3;
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

<!-- 결제 완료 상태가 아닌 주문을 리스트 -->
<c:if test="${not empty unpaidOrders}">
    <h2>미결제 주문</h2>
    <table>
        <thead>
        <tr>
            <th>주문 ID</th>
            <th>키오스크 번호</th>
            <th>선택하기</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="order" items="${unpaidOrders}">
            <tr>
                <td><c:out value="${order.orderId}"/></td>
                <td><c:out value="${order.kiosksNum}"/></td>
                <td>
                    <a href="<c:url value='/store/kioskDetails?kioskNum=${order.kiosksNum}&storeName=${selectedStore}'/>" class="btn-select">상세 보기</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</c:if>

</body>
</html>
