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

<table>
    <thead>
    <tr>
        <th>메뉴 이름</th>
        <th>판매 수량</th>
        <th>판매 금액</th>
    </tr>
    </thead>
    <tbody>

    <tr>
        <td>불고기 버거</td>
        <td>50</td>
        <td>₩250,000</td>
    </tr>
    <tr>
        <td>치즈 피자</td>
        <td>30</td>
        <td>₩300,000</td>
    </tr>
    <tr>
        <td>감자튀김</td>
        <td>80</td>
        <td>₩160,000</td>
    </tr>
    </tbody>
</table>

<hr>

<div class="total">
    <h3>총 판매 금액: ₩710,000</h3>
</div>

</body>
</html>
