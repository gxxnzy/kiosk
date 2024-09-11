<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>당일 판매량</title>
    <style>
        body {
            text-align: center;
        }
        table {
            margin: 0 auto;
            border-collapse: collapse;
            width: 80%;
        }
        th, td {
            border: 1px solid black;
            padding: 8px;
        }
        th {
            background-color: #f2f2f2;
        }
        .total {
            text-align: right;
            margin-right: 20%;
        }
        .header {
            position: relative;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 60px;
        }
        .logout {
            position: absolute;
            right: 20px;
            top: 50%;
            transform: translateY(-50%);
        }
    </style>
</head>
<body>

<div class="header">
    <h2>당일 판매량</h2>
    <a href="/store/loginform" class="logout">로그아웃</a>
</div>

<hr>

<!-- 주문 내역 테이블 -->
<table>
    <thead>
    <tr>
        <th>메뉴 이름</th>
        <th>판매 수량</th>
        <th>판매 금액</th>
    </tr>
    </thead>
    <tbody>
    <!-- 서버에서 전달된 orderDetails 리스트를 출력합니다. -->
    <c:forEach var="detail" items="${orderDetails}">
        <tr>
            <td><c:out value="${detail.menuName}"/></td>
            <td><c:out value="${detail.quantity}"/></td>
            <td>₩<c:out value="${detail.quantity * detail.quantityPrice}"/></td>
        </tr>
    </c:forEach>
    </tbody>
</table>

<hr>

<div class="total">
    <h3>총 판매 금액: ₩<c:out value="${dailySales}"/></h3>
</div>

</body>
</html>
