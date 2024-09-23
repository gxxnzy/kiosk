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
    <style>
      body {
        font-family: Arial, sans-serif;
        margin: 20px;
        padding: 0;
        background-color: #f9f9f9;
        text-align: center;
      }

      hr {
        border: 1px solid #F87C7CFC;
        margin-bottom: 20px;
      }

      h1 {
        text-align: center;
        position: relative;
      }

      h1 a {
        position: absolute;
        right: 0;
        top: 50%;
        transform: translateY(-50%);
      }

      fieldset {
        border: 1px solid rgba(166, 162, 162, 0.99);
        padding: 10px;
        border-radius: 8px;
        background-color: #fafafa;
      }

      legend {
        font-weight: bold;
        color: rgba(2, 2, 2, 0.97);
      }

      table {
        width: 100%;
        border-collapse: collapse;
        margin: 20px 0;
      }

      table, th, td {
        border: 1px solid #ccc;
      }

      th, td {
        padding: 10px;
        text-align: center;
      }

      th {
        background-color: rgba(248, 124, 124, 0.99);
        color: white;
      }

      tr:nth-child(even) {
        background-color: #f9f9f9;
      }

      tr:nth-child(odd) {
        background-color: #fff;
      }

      input[type="submit"], input[type="reset"], input[type="button"], button {
        background-color: rgba(248, 124, 124, 0.99);
        color: white;
        padding: 10px 50px;
        margin: 5px;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        text-decoration: none;
        display: inline-block;
      }

      input[type="submit"]:hover, input[type="reset"]:hover, input[type="button"]:hover, button:hover {
        background-color: #ec0303;
      }

      input[type="text"], select {
        width: 100%;
        padding: 10px;
        margin-bottom: 15px;
        border: 1px solid #ddd;
        border-radius: 5px;
        box-sizing: border-box;
      }

      select {
        padding: 5px;
        border-radius: 4px;
        border: 1px solid #ccc;
      }
    </style>
    <!-- jQuery-->
    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
    <script>
      // ==================================================
      // 화면 초기화
      // ==================================================
      $(document).ready(function() {
        $("#init").click(function() {
          //alert("init()");
          $("#storeName").val("");
          $("#storeStatus").val("");
          $("#sortOrder").val("asc");
          $("#sex0").prop("checked", true);
        });
      });
    </script>
</head>
<body>

<h1>매장 리스트</h1>

<form action="searchStoreList" method="post">
    <fieldset>
        <legend>&nbsp;검색 조건&nbsp;</legend>
        <table>
            <tr>
                <th>지점명</th>
                <td>
                    <input type="text" name="storeName" id="storeName" value="${storeName}">
                </td>

            </tr>
            <tr>
                <th>상태</th>
                <td>
                    <select name="storeStatus" id="storeStatus">
                        <option value="" ${storeStatus == '' ? 'selected' : ''}>전체</option> <!-- 선택하지 않으면 모든 상태 -->
                        <option value="영업중" ${storeStatus == '영업중' ? 'selected' : ''}>영업중</option>
                        <option value="폐점" ${storeStatus == '폐점' ? 'selected' : ''}>폐점</option>
                    </select>
                </td>
                <th>정렬 기준</th>
                <td>
                    <select name="sortOrder" id="sortOrder">
                        <option value="asc" ${sortOrder == 'asc' ? 'selected' : ''}>오래된 순</option>
                        <option value="desc" ${sortOrder == 'desc' ? 'selected' : ''}>최근 순</option>
                    </select>
                </td>
                <td rowspan="2">
                    <input type="submit" value="검색" >
                    <input type="button" id="init" value="초기화" onclick="init()" >
                </td>
            </tr>
        </table>
    </fieldset>
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
            <td><a href="storeDetail/${store.storeId}">${store.storeName}</a></td>
            <td>${store.roadAddress}</td>
            <td>${store.storeStatus}</td>
            <td>${store.storeOpenDate}</td>
        </tr>
    </c:forEach>
    </tbody>
</table>
<form action="createStore" method="get">
    <button type="submit" class="button">지점 추가</button>
</form>
</body>
</html>
