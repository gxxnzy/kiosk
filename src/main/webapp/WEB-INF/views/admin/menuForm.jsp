<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!-- JSTL -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!-- 숫자 포맷 -->

<html>
<head>
    <title>Menu</title>
    <style>
      body {
        font-family: Arial, sans-serif;
        margin: 20px;
        padding: 0;
        background-color: #ffffff; /* 흰색 배경 */
        text-align: center;
        color: #333; /* 전체 글자 색상: 어두운 회색 */
      }

      hr {
        border: 1px solid #c3bef0; /* 연한 보라색 */
        margin-bottom: 20px;
      }

      h1 {
        text-align: center;
        position: relative;
        color: #333; /* 제목 색상: 검은색 */
      }

      h1 a {
        position: absolute;
        right: 0;
        top: 50%;
        transform: translateY(-50%);
      }

      fieldset {
        border: 1px solid #cadefc; /* 연한 파란색 */
        padding: 10px;
        border-radius: 8px;
        background-color: #ffffff; /* 흰색 배경 */
      }

      legend {
        font-weight: bold;
        color: #333; /* 레전드 색상: 검은색 */
      }

      table {
        width: 100%;
        border-collapse: collapse;
        margin: 20px 0;
      }

      table, th, td {
        border: 1px solid #ddd; /* 연한 회색 */
      }

      th, td {
        padding: 10px;
        text-align: center;
      }

      th {
        background-color: #c3bef0; /* 연한 보라색 */
        color: #333; /* 테이블 헤더 글자 색상: 검은색 */
      }

      tr:nth-child(even) {
        background-color: #f9f9f9; /* 연한 회색 */
      }

      tr:nth-child(odd) {
        background-color: #ffffff; /* 흰색 */
      }

      input[type="submit"], input[type="reset"], input[type="button"] {
        background-color: #cca8e9; /* 연한 보라색 */
        color: #ffffff; /* 버튼 글자 색상: 흰색 */
        padding: 10px 50px;
        margin: 5px;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        text-decoration: none;
        display: inline-block;
      }

      input[type="submit"]:hover, input[type="reset"]:hover, input[type="button"]:hover {
        background-color: #c3bef0; /* 연한 보라색 */
      }

      input[type="text"], select {
        width: 100%;
        padding: 10px;
        margin-bottom: 15px;
        border: 1px solid #ddd;
        border-radius: 5px;
        box-sizing: border-box;
      }

      a {
        text-decoration: none;
        color: #333; /* 링크 색상: 검은색 */
      }

      select {
        padding: 5px;
        border-radius: 4px;
        border: 1px solid #ccc;
      }

      a input[type="submit"] {
        background-color: #cca8e9; /* 연한 보라색 */
        color: #ffffff; /* 버튼 글자 색상: 흰색 */
        padding: 10px 50px;
        margin: 5px;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        text-decoration: none;
        display: inline-block;
      }

      a input[type="submit"]:hover {
        background-color: #c3bef0; /* 연한 보라색 */
      }

    </style>
</head>
<body>
<div>
    <h1>메뉴 조회
        <a href="adminMain">
            <input type="button" value="뒤로가기">
        </a>
    </h1>
</div>
<hr>
<br>
<form action="searchMenu" method="post">
    <fieldset>
        <legend>검색 조건</legend>
        <table>
            <tr>
                <th>이름</th>
                <td>
                    <input type="text" name="menuName", id="menuName" value="${menuName}">
                </td>
                <th>카테고리</th>
                <td>
                    <select name="category">
                        <option value="" ${categoryName == '' ? 'selected' : ''}>--전체--</option>
                        <c:forEach var="category" items="${categories}">
                            <option value="${category.categoryName}" ${category.categoryName == categoryName ? 'selected' : ''}>${category.categoryName}</option>
                        </c:forEach>
                    </select>
                </td>
            </tr>
            <tr>
                <th>판매 여부</th>
                <td>
                    <select name="menuActive">
                        <option value="" ${menuActive == '' ? 'selected' : ''}>--전체--</option>
                        <option value="1" ${menuActive == '1' ? 'selected' : ''}>판매</option>
                        <option value="0" ${menuActive == '0' ? 'selected' : ''}>미판매</option>
                    </select>
                <td colspan="2" style="text-align: center">
                    <input type="submit" value="검색">
                    <input type="reset" value="취소">
                </td>
            </tr>
        </table>
    </fieldset>
</form>
<br>
<c:if test="${not empty message}">
    <p>${message}</p>
</c:if>
<c:if test="${not empty menus}">
    <table>
        <tr>
            <th>카테고리</th>
            <th>이름</th>
            <th>가격</th>
        </tr>
        <c:forEach var="menu" items="${menus}">
            <tr>
                <td>${menu.categoryName}</td>
                <td><a href="/admin/menuDetail?menuId=${menu.menuId}">${menu.menuName}</a></td>
                <td><fmt:formatNumber value="${menu.menuPrice}" type="number"/>원</td>
            </tr>
        </c:forEach>
    </table>
</c:if>
<a href="reset"><input type="submit" value="키오스크 동기화"></a>
<a href="menuInsert"><input type="submit" value="메뉴 추가"></a>
</body>
</html>
