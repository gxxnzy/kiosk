<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%><!-- JSTL -->

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

      h1 {
        text-align: center;
      }

      fieldset {
        border: 1px solid #ccc;
        padding: 10px;
        border-radius: 8px;
      }

      legend {
        font-weight: bold;
      }

      table {
        width: 100%;
        border-collapse: collapse;
        margin: 20px 0;
      }

      table, th, td {
        border: 1px solid dimgray;
      }

      th, td {
        padding: 10px;
        text-align: center;
      }

      th {
        background-color: #b8dde8;
      }

      tr:nth-child(even) {
        background-color: #f9f9f9;
      }

      input[type="submit"], input[type="reset"] {
        background-color: #4c95af;
        color: white;
        padding: 10px 50px;
        margin: 5px;
        border: none;
        border-radius: 4px;
        text-decoration: none;
        display: inline-block;
        cursor: pointer;
      }

      input[type="text"], select {
        width: 100%;
        padding: 10px;
        margin-bottom: 15px;
        border: 1px solid #ddd;
        border-radius: 5px;
        box-sizing: border-box;
      }

      input[type="submit"]:hover, input[type="reset"]:hover{
        background-color: #4c95af;
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
    </style>
</head>
<body>
<h2>메뉴 조회</h2>
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
<table>
    <tr>
        <th>번호</th>
        <th>카테고리</th>
        <th>이름</th>
        <th>가격</th>
    </tr>
    <c:forEach var="menu" items="${Menus}">
        <tr>
            <td>${menu.menuId}</td>
            <td>${menu.categoryName}</td>
            <td><a href="/admin/menuDetail?menuId=${menu.menuId}">${menu.menuName}</a></td>
            <td>${menu.menuPrice}원</td>
        </tr>
    </c:forEach>
</table>
<a href="reset" ><input type="submit" value="키오스크 초기화"></a>
<a href="menuInsert"><input type="submit" value="메뉴 추가"></a>
</body>
</html>