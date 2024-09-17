<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Payment Management</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }
        header {
            background-color: #007BFF;
            color: white;
            padding: 10px 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        header h1 {
            margin: 0;
            font-size: 24px;
        }
        header .nav-links {
            color: white;
            text-decoration: none;
            font-size: 16px;
            margin-right: 20px;
        }
        .container {
            width: 80%;
            margin: 20px auto;
            background: white;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
        }
        th, td {
            padding: 15px;
            text-align: left;
            border: 1px solid #ddd;
        }
        th {
            background-color: #007BFF;
            color: white;
        }
        tbody tr:hover {
            background-color: #f1f1f1;
        }
        .btn-select, .btn-logout {
            display: inline-block;
            padding: 8px 16px;
            font-size: 14px;
            color: white;
            background-color: #28a745;
            border: none;
            border-radius: 3px;
            cursor: pointer;
            text-decoration: none;
            margin-right: 10px;
            text-align: center;
        }
        .btn-select:hover, .btn-logout:hover {
            background-color: #218838;
        }
        .btn-logout {
            background-color: #dc3545;
        }
        .btn-logout:hover {
            background-color: #c82333;
        }
    </style>
</head>
<body>
<header>
    <h1>결제 관리</h1>
    <div>
        <a href="/store/main" class="nav-links">판매량 관리</a>
        <a href="/logout" class="btn-logout">로그아웃</a>
    </div>
</header>
<div class="container">
    <c:if test="${not empty selectedStore}">
        <span class="store-name">현재 지점: ${selectedStore}</span>
    </c:if>

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
</div>
</body>
</html>
