<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!-- JSTL -->

<html>
<head>
    <title>메뉴 추가</title>
    <style>
      body {
        background-color: #ffffff; /* 흰색 배경 */
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 0;
        display: flex;
        justify-content: center;
        align-items: flex-start;
        min-height: 100vh;
      }

      .container {
        background-color: #fff; /* 흰색 배경 */
        padding: 40px;
        border-radius: 10px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        width: 600px;
        max-width: 100%;
        border-top: 8px solid #c3bef0; /* 연한 보라색 */
      }

      h2 {
        font-size: 28px;
        color: #333; /* 검은색 */
        text-align: center;
        margin-bottom: 20px;
      }

      hr {
        border: none;
        border-bottom: 1px solid #c3bef0; /* 연한 보라색 */
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
        border: 1px solid #ddd; /* 연한 회색 테두리 */
      }

      td:first-child {
        width: 30%;
        font-weight: bold;
        color: #555; /* 어두운 회색 */
        background-color: #f9f9f9; /* 연한 회색 배경 */
      }

      input[type="text"], input[type="file"], input[type="number"], textarea, select {
        width: 100%;
        padding: 12px;
        margin-bottom: 15px;
        border: 1px solid #ddd; /* 연한 회색 테두리 */
        border-radius: 5px;
        box-sizing: border-box;
        background-color: #f9f9f9; /* 연한 회색 배경 */
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
        background-color: #c3bef0; /* 연한 보라색 */
        color: #333; /* 검은색 */
      }

      input[type="button"] {
        background-color: #cadefc; /* 더 연한 보라색 */
        color: #333; /* 검은색 */
      }

      input[type="submit"]:hover {
        background-color: #b0a8f0; /* 더 진한 보라색 */
      }

      input[type="button"]:hover {
        background-color: #c3bef0; /* 연한 보라색 */
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
        background-color: #f9f9f9; /* 연한 회색 배경 */
      }

      label {
        color: #333; /* 검은색 */
      }
    </style>
</head>
<body>
<div class="container">
    <h2>메뉴 추가</h2>
    <hr>
    <form action="menuInsertResult" method="post" enctype="multipart/form-data">
        <table>
            <tr>
                <td><label for="category">카테고리</label></td>
                <td>
                    <select name="category" id="category">
                        <c:forEach var="category" items="${categories}">
                            <option value="${category.categoryName}">${category.categoryName}</option>
                        </c:forEach>
                    </select>
                </td>
            </tr>
            <tr>
                <td><label for="menuName">이름</label></td>
                <td><input type="text" name="menuName" id="menuName" required></td>
            </tr>
            <tr>
                <td><label for="menuPrice">가격</label></td>
                <td><input type="text" name="menuPrice" id="menuPrice" required></td>
            </tr>
            <tr>
                <td><label for="info">설명</label></td>
                <td><textarea id="info" name="info" required></textarea></td>
            </tr>
            <tr>
                <td><label for="menuImage">이미지</label></td>
                <td><input type="file" name="menuImage" id="menuImage" accept="image/*"></td>
            </tr>
        </table>
        <div class="button-container">
            <input type="submit" value="등록">
            <input type="button" value="취소" onclick="window.location.href='menu'">
        </div>
    </form>
</div>
</body>
</html>
