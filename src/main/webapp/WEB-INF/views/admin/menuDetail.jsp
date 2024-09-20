<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%><!-- JSTL -->

<html>
<head>
    <title>메뉴 상세보기</title>
    <style>
      body {
        background-color: #f0f0f0;
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 0;
        display: flex;
        justify-content: center;
        align-items: flex-start;
        min-height: 100vh;
      }

      .container {
        background-color: #fff;
        padding: 40px;
        border-radius: 10px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        width: 600px;
        max-width: 100%;
        border-top: 8px solid rgba(248, 124, 124, 0.99);
      }

      h2 {
        font-size: 28px;
        color: rgba(2, 2, 2, 0.97);
        text-align: center;
        margin-bottom: 20px;
      }

      hr {
        border: none;
        border-bottom: 1px solid rgba(248, 124, 124, 0.99);
        margin: 20px 0;
      }

      table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
      }

      th, td {
        padding: 15px;
        text-align: left;
      }

      td:first-child {
        width: 30%;
        font-weight: bold;
        color: #555;
      }

      input[type="text"], input[type="file"], input[type="number"], textarea, select {
        width: 100%;
        padding: 12px;
        margin-bottom: 15px;
        border: 1px solid #ddd;
        border-radius: 5px;
        box-sizing: border-box;
      }

      .button-container {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-top: 30px;
      }

      input[type="submit"], input[type="button"] {
        width: 48%;
        padding: 15px;
        font-size: 16px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        box-sizing: border-box;
      }

      input[type="submit"] {
        background-color: rgba(248, 124, 124, 0.99);
        color: white;
      }

      input[type="button"] {
        background-color: #f4f4f4;
        color: #333;
      }

      input[type="submit"]:hover {
        background-color: #ec0303;
      }

      input[type="button"]:hover {
        background-color: #e0e0e0;
      }

      /* 이미지 스타일링 */
      img {
        max-width: 300px;
        max-height: 200px;
        border-radius: 8px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
      }

      /* 추가된 스타일 */
      select, textarea, input[type="number"], input[type="text"] {
        background-color: #f9f9f9;
      }

      label {
        color: #bb2528;
      }
    </style>
</head>
<body>
<div class="container">
    <h2>메뉴 상세보기</h2>
    <hr>
    <form action="updateMenu" method="post">
        <table>
            <tr>
                <td><label for="menuImage">이미지</label></td>
                <td><img src="${menu.menuImage}" alt="${menu.menuName}"></td>
            </tr>
            <tr>
                <td><label for="categoryName">카테고리</label></td>
                <td>
                    <select name="categoryName" id="categoryName">
                        <c:forEach var="category" items="${categories}">
                            <option value="${category.categoryName}" ${menu.categoryName == category.categoryName ? 'selected' : ''}>${category.categoryName}</option>
                        </c:forEach>
                    </select>
                </td>
            </tr>
            <tr>
                <td><label for="menuId">번호</label></td>
                <td><input type="text" name="menuId" id="menuId" value="${menu.menuId}" readonly></td>
            </tr>
            <tr>
                <td><label for="menuName">이름</label></td>
                <td><input type="text" name="menuName" id="menuName" value="${menu.menuName}"></td>
            </tr>
            <tr>
                <td><label for="menuPrice">가격</label></td>
                <td><input type="number" name="menuPrice" id="menuPrice" value="${menu.menuPrice}" /></td>
            </tr>
            <tr>
                <td><label for="menuActive">판매 여부</label></td>
                <td>
                    <select name="menuActive" id="menuActive">
                        <option value="1" ${menu.menuActive == 1 ? 'selected' : ''}>판매</option>
                        <option value="0" ${menu.menuActive == 0 ? 'selected' : ''}>미판매</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td><label for="info">설명</label></td>
                <td><textarea name="info" id="info">${menu.info}</textarea></td>
            </tr>
        </table>
        <div class="button-container">
            <input type="submit" value="수정">
            <input type="button" value="취소" onclick="window.location.href='menu'">
        </div>
    </form>
</div>
</body>
</html>
