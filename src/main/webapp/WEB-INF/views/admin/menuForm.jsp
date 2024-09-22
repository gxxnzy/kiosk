<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%><!-- JSTL -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %><!-- 숫자 포맷 -->

<html>
<head>
    <title>Menu</title>
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
        text-align: center;  /* 제목을 가운데 정렬 */
        position: relative;
      }

      h1 a {
        position: absolute;
        right: 0;
        top: 50%;
        transform: translateY(-50%);  /* 뒤로 가기 버튼을 h1의 중간에 수직 정렬 */
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

      input[type="submit"], input[type="reset"], input[type="button"] {
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

      input[type="submit"]:hover, input[type="reset"]:hover, input[type="button"]:hover {
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

      a {
        text-decoration: none;
        color: black;
      }

      select {
        padding: 5px;
        border-radius: 4px;
        border: 1px solid #ccc;
      }

      a input[type="submit"] {
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

      a input[type="submit"]:hover {
        background-color: #ec0303;
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
                    <input type="text" name="menuName">
                </td>
                <th>카테고리</th>
                <td>
                    <select name="category">
                        <option value="">--전체--</option>
                        <c:forEach var="category" items="${categories}">
                            <option value="${category.categoryName}">${category.categoryName}</option>
                        </c:forEach>
                    </select>
                </td>
            </tr>
            <tr>
                <th>판매 여부</th>
                <td>
                    <select name="menuActive">
                        <option value="">--전체--</option>
                        <option value="1">판매</option>
                        <option value="0">미판매</option>
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
            <th>번호</th>
            <th>카테고리</th>
            <th>이름</th>
            <th>가격</th>
        </tr>
        <c:forEach var="menu" items="${menus}">
            <tr>
                <td>${menu.menuId}</td>
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
