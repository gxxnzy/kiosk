<%--
  Created by IntelliJ IDEA.
  User: gd
  Date: 2024. 9. 11.
  Time: 오전 11:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Title</title>
</head>
<body>

<h1>Store List</h1>

<form action="searchStoreList" method="get">
    <label for="storeId">매장 아이디:</label>
    <input type="text" id="storeId" name="storeId"/>

    <label for="storeName">지점명:</label>
    <input type="text" id="storeName" name="storeName"/>

    <label for="roadAddress">도로명 주소:</label>
    <input type="text" id="roadAddress" name="roadAddress"/>

    <label for="storeStatus">상태:</label>
    <input type="text" id="storeStatus" name="storeStatus"/>

    <label for="storeOpenDate">오픈 날짜:</label>
    <input type="date" id="storeOpenDate" name="storeOpenDate"/>

    <input type="submit" value="검색"/>
</form>

<table border="1">
    <thead>
    <tr>
        <th>매장 아이디</th>
        <th>지점명</th>
        <th>매장 주소</th>
        <th>상태</th>
        <th>오픈 날짜</th>
    </tr>
    </thead>
    <tbody>
    <!-- stores 리스트를 반복하며 각 매장 정보를 테이블에 표시 -->
    <c:forEach var="store" items="${stores}">
        <tr>
            <td>${store.storeId}</td>
            <td>${store.storeName}</td>
            <td>${store.roadAddress} ${store.storeAddress1} ${store.storeAddress2}</td>
            <td>${store.storeStatus}</td>
            <td>${store.storeOpenDate}</td>
        </tr>
    </c:forEach>
    </tbody>
</table>
</body>
</html>
