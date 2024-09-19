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
      }

      h1 {
        text-align: center;
      }

      .container {
        max-width: 900px;
        margin: 0 auto;
        background-color: #ffffff;
        padding: 20px;
        border-radius: 8px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
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
        border: 1px solid #ddd;
      }

      th, td {
        padding: 10px;
        text-align: left;
      }

      th {
        background-color: #f4f4f4;
      }

      tr:nth-child(even) {
        background-color: #f9f9f9;
      }

      input[type="submit"], input[type="reset"], input[type="button"] {
        background-color: #4CAF50;
        color: white;
        padding: 10px 20px;
        margin: 5px;
        border: none;
        border-radius: 4px;
        text-decoration: none;
        display: inline-block;
        cursor: pointer;
      }

      input[type="submit"]:hover, input[type="reset"]:hover, input[type="button"] {
        background-color: #45a049;
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
메뉴 조회
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
                        <option value="스테이크">스테이크</option>
                        <option value="파스타">파스타</option>
                        <option value="리조또">리조또</option>
                        <option value="사이드">사이드</option>
                        <option value="음료">음료</option>
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
                <td rowspan="2">
                    <input type="submit" value="검색">
                    <input type="reset" value="취소">
                </td>
                <td>
                    <a href="reset" ><input type="button" value="키오스크 초기화"></a>
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
<table>
    <tr>
        <td>
            <a href="menuInsert"><input type="submit" value="추가"></a>
        </td>
    </tr>
</table>
</body>
</html>