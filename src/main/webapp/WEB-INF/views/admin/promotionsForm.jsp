<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Promotions List</title>
    <style>
      body {
        font-family: Arial, sans-serif;
        margin: 20px;
        padding: 0;
        background-color: #f9f9f9;
        text-align: center;
      }

      hr {
        border: 1px solid #c3bef0; /* Light purple hr */
        margin-bottom: 20px;
      }

      h1 {
        text-align: center;
        position: relative;
        color: rgba(2, 2, 2, 0.97); /* Light purple heading */
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
        background-color: #c3bef0; /* Light purple table header */
        color: white;
      }

      tr:nth-child(even) {
        background-color: #f9f9f9;
      }

      tr:nth-child(odd) {
        background-color: #fff;
      }

      input[type="submit"], input[type="reset"], input[type="button"] {
        background-color: #c3bef0; /* Light purple button */
        color: white;
        padding: 10px 50px;
        margin: 5px;
        border: none;
        border-radius: 4px;
        cursor: pointer;
      }

      input[type="submit"]:hover, input[type="reset"]:hover, input[type="button"]:hover {
        background-color: #b3a1e2; /* Slightly darker light purple on hover */
      }

      input[type="text"], select, input[type="date"] {
        width: 100%;
        padding: 10px;
        margin-bottom: 15px;
        border: 1px solid #ddd;
        border-radius: 5px;
        box-sizing: border-box;
      }

      a {
        text-decoration: none;
        color: black;
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

      td img {
        width: 100px; /* Desired width */
        height: 100px; /* Desired height */
        object-fit: cover; /* Maintain aspect ratio */
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
          $("#promotionActive").val("");
          $("#sortOrder").val("asc");
        });
      });
    </script>
</head>
<body>


<h1>프로모션 리스트</h1>
<a href="adminMain" class="back-button">뒤로가기</a> <!-- 뒤로가기 버튼 추가 -->

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
        <th>광고명</th>
        <th>광고 이미지</th>
        <th>시작 날짜</th>
        <th>종료 날짜</th>
        <th>활성 여부</th>
        <th>수정</th>
    </tr>
    </thead>
    <tbody>
    <!-- promotions 리스트를 반복하며 각 광고 정보를 테이블에 표시 -->
    <c:forEach var="promotion" items="${promotions}">
        <tr>
            <td>${promotion.promotionName}</td>
            <td>
                <!-- 광고 이미지가 있으면 출력, 없으면 '이미지 없음' 텍스트 -->
                <c:choose>
                    <c:when test="${!empty promotion.promotionImage}">
                        <img src="${promotion.promotionImage}" alt="광고 이미지">
                    </c:when>
                    <c:otherwise>
                        이미지 없음
                    </c:otherwise>
                </c:choose>
            </td>
            <td>${promotion.startDate}</td>
            <td>${promotion.endDate}</td>
            <td>${promotion.promotionActive == 1 ? '활성' : '비활성'}</td>
            <td>
                <form action="editPromotion" method="get">
                    <input type="hidden" name="promotionId" value="${promotion.promotionId}">
                    <button type="submit" style="background-color: #c3bef0; color: white; padding: 10px 20px; border: none; border-radius: 4px; cursor: pointer;">수정</button>
                </form>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
<form action="createPromotion" method="get">
    <input type="submit" value="광고 추가">
</form>

</body>
</html>
