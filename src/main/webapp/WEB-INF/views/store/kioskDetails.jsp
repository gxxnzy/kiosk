<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Kiosk Order Details</title>
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
            text-align: center;
        }
        header h1 {
            margin: 0;
            font-size: 24px;
        }
        .container {
            width: 80%;
            margin: 20px auto;
            background: white;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            position: relative; /* Added to help position the button at the bottom */
            min-height: 400px; /* Ensure enough space for the button at the bottom */
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
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
        tbody tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        tbody tr:hover {
            background-color: #e9ecef;
        }
        .total-amount {
            text-align: right;
            margin-top: 20px;
        }
        .btn-submit {
            display: block;
            padding: 10px 20px;
            font-size: 16px;
            color: white;
            background-color: #28a745;
            border: none;
            border-radius: 3px;
            cursor: pointer;
            text-decoration: none;
            margin-top: 20px;
            text-align: center;
            position: absolute;
            bottom: 20px; /* Position the button at the bottom of the container */
            right: 20px; /* Align button to the right */
        }
        .btn-submit:hover {
            background-color: #218838;
        }
    </style>
</head>
<body>
<header>
    <h1>테이블 ${kioskNum}번 키오스크 주문 내역</h1>
</header>
<div class="container">
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
                    <c:if test="${not empty detail.order.orderId}">
                        <input type="hidden" name="orderIds" value="${detail.order.orderId}"/>
                    </c:if>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <input type="hidden" name="kioskNum" value="${kioskNum}"/>
        <div class="total-amount">
            <h2>총 결제 금액 : ${totalAmount}원</h2>
        </div>
        <button type="submit" class="btn-submit">결제 완료</button>
    </form>
</div>
</body>
</html>

