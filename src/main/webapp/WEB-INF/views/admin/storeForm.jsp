<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>매장 리스트</title>
    <style>
      body {
        font-family: Arial, sans-serif;
        margin: 20px;
        padding: 0;
        background-color: #ffffff; /* 흰색 배경 */
        text-align: center;
      }

      hr {
        border: 1px solid #c3bef0; /* 연한 보라색 */
        margin-bottom: 20px;
      }

      h1 {
        text-align: center;
        position: relative;
        color: rgba(2, 2, 2, 0.97); /* 연한 보라색 제목 */
      }

      h1 a {
        position: absolute;
        right: 0;
        top: 50%;
        transform: translateY(-50%);
        color: #c3bef0; /* 연한 보라색 링크 */
        text-decoration: none;
      }

      .back-button {
        position: absolute;
        right: 20px;
        top: 20px;
        background-color: #c3bef0;
        color: white;
        padding: 10px 20px;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        text-decoration: none;
      }

      .back-button:hover {
        background-color: #b3a1e2;
      }

      fieldset {
        border: 1px solid #c3bef0; /* 연한 보라색 테두리 */
        padding: 10px;
        border-radius: 8px;
        background-color: #fafafa; /* 연한 회색 배경 */
      }

      legend {
        font-weight: bold;
        color: #6c5b7b; /* 연한 보라색 레전드 */
      }

      table {
        width: 100%;
        border-collapse: collapse;
        margin: 20px 0;
      }

      table, th, td {
        border: 1px solid #ddd; /* 연한 회색 테두리 */
      }

      th, td {
        padding: 10px;
        text-align: center;
      }

      th {
        background-color: #c3bef0; /* 연한 보라색 헤더 배경 */
        color: white;
      }

      tr:nth-child(even) {
        background-color: #f9f9f9; /* 연한 회색 배경 */
      }

      tr:nth-child(odd) {
        background-color: #ffffff; /* 흰색 배경 */
      }

      input[type="submit"], input[type="reset"], input[type="button"], button {
        background-color: #c3bef0; /* 연한 보라색 버튼 배경 */
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
        background-color: #b0a8f0; /* 더 진한 보라색 호버 배경 */
      }

      input[type="text"], select {
        width: 100%;
        padding: 10px;
        margin-bottom: 15px;
        border: 1px solid #ddd; /* 연한 회색 테두리 */
        border-radius: 5px;
        box-sizing: border-box;
        background-color: #f9f9f9; /* 연한 회색 배경 */
      }

      select {
        padding: 5px;
        border-radius: 4px;
        border: 1px solid #ccc; /* 연한 회색 테두리 */
      }

      a {
        text-decoration: none;
        color: #6c5b7b; /* 연한 보라색 링크 */
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
<a href="javascript:history.back()" class="back-button">뒤로가기</a> <!-- 뒤로가기 버튼 추가 -->

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
                        <option value="" ${storeStatus == '' ? 'selected' : ''}>전체</option>
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
                    <input type="submit" value="검색">
                    <input type="button" id="init" value="초기화">
                </td>
            </tr>
        </table>
    </fieldset>
</form>

<table>
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
    <button type="submit">지점 추가</button>
</form>
</body>
</html>
