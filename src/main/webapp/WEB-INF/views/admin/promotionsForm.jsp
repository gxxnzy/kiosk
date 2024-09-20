<%--
  Created by IntelliJ IDEA.
  User: gd
  Date: 2024. 9. 19.
  Time: 오전 11:23
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Promotions List</title>
    <style>
      body {
        text-align: center;
      }

      table {
        margin: 0 auto;
        border-collapse: collapse;
      }
    </style>
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
    <script>
      // ==================================================
      // 화면 초기화
      // ==================================================
      $(document).ready(function() {
        $("#init").click(function() {
          $("#promotionName").val("");
          $("#promotionStatus").val("");
          $("#promotionActive").val("");
          $("#sortOrder").val("asc");
        });
      });
    </script>
</head>
<body>

<h1>Promotions List</h1>

<form action="searchAdList" method="post">
    <fieldset>
        <legend>&nbsp;검색 조건&nbsp;</legend>
        <table>
            <tr>
                <th>광고명</th>
                <td>
                    <input type="text" name="promotionName" id="promotionName" value="${promotionName}">
                </td>
            </tr>
            <tr>
                <th>광고 활성 여부</th>
                <td>
                    <select name="promotionActive" id="promotionActive">
                        <option value="" ${promotionActive == '' ? 'selected' : ''}>전체</option>
                        <option value="1" ${promotionActive == '1' ? 'selected' : ''}>활성</option>
                        <option value="0" ${promotionActive == '0' ? 'selected' : ''}>비활성</option>
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

<table border="1">
    <thead>
    <tr>
        <th>광고 아이디</th>
        <th>광고명</th>
        <th>시작 날짜</th>
        <th>종료 날짜</th>
        <th>활성 여부</th>
    </tr>
    </thead>
    <tbody>
    <!-- promotions 리스트를 반복하며 각 광고 정보를 테이블에 표시 -->
    <c:forEach var="promotion" items="${promotions}">
        <tr>
            <td>${promotion.promotionId}</td>
            <td>${promotion.promotionName}</td>
            <td>${promotion.startDate}</td>
            <td>${promotion.endDate}</td>
            <td>${promotion.promotionActive == 1 ? '활성' : '비활성'}</td>
        </tr>
    </c:forEach>
    </tbody>
</table>
<form action="createPromotion" method="get">
    <button type="submit" class="button">광고 추가</button>
</form>

</body>
</html>
