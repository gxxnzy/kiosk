<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%><!-- JSTL -->

<html>
<head>
    <title>메뉴 상세보기</title>
    <style>
      body {
        background-color: #ffffff;
        font-family: Arial, sans-serif;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        margin: 0;
      }

      h2 {
        margin-bottom: 10px;
        font-size: 24px;
        font-weight: bold;
      }

      hr {
        border: none;
        border-bottom: 1px solid #ddd;
        margin: 20px 0;
      }

      table {
        width: 100%;
        border-collapse: collapse;
      }

      th, td {
        padding: 5px;
        text-align: left;
      }

      td:first-child {
        width: 30%;
        font-weight: bold;
      }

      input[type="text"], input[type="file"], input[type="number"], textarea, select {
        width: 100%;
        padding: 10px;
        margin-bottom: 15px;
        border: 1px solid #ddd;
        border-radius: 5px;
        box-sizing: border-box;
      }

      .button-container {
        display: flex; /* 버튼들을 가로로 배치 */
        justify-content: space-between; /* 버튼 사이에 공간 */
        align-items: center; /* 수직 가운데 정렬 */
        margin-top: 20px; /* 위와 여백 추가 */
      }

      input[type="submit"], input[type="button"] {
        width: 48%; /* 두 버튼이 나란히 48%씩 차지하도록 */
        padding: 15px;
        font-size: 16px;
        border: none;
        border-radius: 5px;
        box-sizing: border-box;
        cursor: pointer;
      }

      input[type="submit"] {
        background-color: #4c95af;
        color: white;
      }

      input[type="button"] {
        background-color: #f4f4f4;
        color: #333;
      }

      input[type="submit"]:hover {
        background-color: #4c95af;
      }

      input[type="button"]:hover {
        background-color: #e0e0e0;
      }
    </style>
</head>
<body>
<form action="updateMenu" method="post">
    <table>
        <tr>
            <td>이미지</td>
            <td><img src="${menu.menuImage}" alt="${menu.menuName}" style="max-width: 300px; max-height: 200px;">
            </td>
        </tr>
        <tr>
            <td>카테고리</td>
            <td>
                <select name="categoryName">
                    <c:forEach var="category" items="${categories}">
                        <option value="${category.categoryName}" ${menu.categoryName == category.categoryName ? 'selected' : ''}>${category.categoryName}</option>
                    </c:forEach>
                </select>
            </td>
        </tr>
        <tr>
            <td>번호</td>
            <td><input type="text" name=menuId value="${menu.menuId}" readonly></td>
        </tr>
        <tr>
            <td>이름</td>
            <td><input type="text" name="menuName" value="${menu.menuName}"></td>
        </tr>
        <tr>
            <td>가격</td>
            <td><input type="number" name="menuPrice" value="${menu.menuPrice}" /></td>
        </tr>
        <tr>
            <td>판매 여부</td>
            <td>
                <select name="menuActive">
                    <option value="1" ${menu.menuActive == 1 ? 'selected' : ''}>판매</option>
                    <option value="0" ${menu.menuActive == 0 ? 'selected' : ''}>미판매</option>
                </select>
            </td>
        </tr>
        <tr>
            <td>설명</td>
            <td><textarea name="info">${menu.info}</textarea></td>
        </tr>
        <tr>
            <td>
                <div class="button-container">
                    <input type="submit" value="수정">
                    <input type="button" value="취소" onclick="window.location.href='menu'">
                </div>
            </td>
        </tr>
    </table>
</form>
</body>
</html>
