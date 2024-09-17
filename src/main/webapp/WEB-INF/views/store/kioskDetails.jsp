<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Kiosk Order Details</title>
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
    </style>
</head>
<body>
<h1>키오스크 ${kioskNum} 주문 내역</h1>
<form action="${pageContext.request.contextPath}/store/updatePaymentStatus" method="post">
    <table>
        <thead>
        <tr>
            <th>주문 ID</th>
            <th>메뉴 이름</th>
            <th>수량</th>
            <th>가격</th>
        </tr>
        </thead>
        <tbody>
        <!-- orderDetailsList를 순회하여 주문 정보를 표시합니다 -->
        <c:forEach var="detail" items="${orderDetailsList}">
            <tr>
                <td><c:out value="${detail.order.orderId}"/></td>
                <td><c:out value="${detail.menuName}"/></td>
                <td><c:out value="${detail.quantity}"/></td>
                <td><c:out value="${detail.quantityPrice}"/></td>
                <!-- 각 주문 ID를 hidden input으로 포함시킵니다 -->
                <input type="hidden" name="orderIds" value="${detail.order.orderId}"/>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    <input type="hidden" name="kioskNum" value="${kioskNum}"/>
    <button type="submit">결제 완료</button>
</form>
</body>
</html>
