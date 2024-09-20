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

      /* 이미지 크기를 동일하게 고정 */
      img {
        width: 150px;  /* 고정 너비 */
        height: 120px; /* 고정 높이 */
        object-fit: cover; /* 이미지를 고정된 크기에 맞춰 자름 */
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
                    <button type="submit">수정</button>
                </form>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
<form action="createPromotion" method="get">
    <button type="submit" class="button">광고 추가</button>
</form>

</body>
</html>
