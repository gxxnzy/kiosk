<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <meta charset="UTF-8">
  <title>프로모션 수정</title>
  <style>
    body {
      background-color: #f0f0f0;
      font-family: Arial, sans-serif;
      display: flex;
      justify-content: center;
      align-items: flex-start;
      height: 100vh;
      margin: 0;
      padding: 20px;
    }

    .container {
      background-color: #fff;
      padding: 40px;
      border-radius: 10px;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
      width: 600px;
      max-width: 100%;
      border-top: 8px solid #c3bef0; /* Light purple border-top */
    }

    h1 {
      margin-bottom: 20px;
      font-size: 28px;
      font-weight: bold;
      color: rgba(2, 2, 2, 0.97);
      text-align: center;
    }

    hr {
      border: none;
      border-bottom: 1px solid #c3bef0; /* Light purple hr */
      margin: 20px 0;
    }

    table {
      width: 100%;
      border-collapse: collapse;
      margin-top: 20px;
    }

    th, td {
      padding: 10px;
      text-align: left;
    }

    td:first-child {
      width: 30%;
      font-weight: bold;
      color: #555;
    }

    input[type="text"], input[type="date"], input[type="file"] {
      width: 100%;
      padding: 12px;
      margin-bottom: 15px;
      border: 1px solid #ddd;
      border-radius: 5px;
      box-sizing: border-box;
      background-color: #f9f9f9;
    }

    .button-container {
      display: flex;
      justify-content: space-between;
      text-align: center;
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
      background-color: #c3bef0; /* Light purple button */
      color: white;
    }

    input[type="button"] {
      background-color: #cadefc; /* Light gray button for cancel */
      color: #333;
    }

    input[type="submit"]:hover {
      background-color: #b3a1e2; /* Darker light purple on hover */
    }

    input[type="button"]:hover {
      background-color: #d0d0d0; /* Slightly darker gray on hover */
    }

    label {
      color: rgba(2, 2, 2, 0.97); /* Dark red label color */
    }
  </style>
</head>
<body>

<div class="container">
  <h1>프로모션 수정</h1>
  <hr>
  <form action="updatePromotion" method="post" enctype="multipart/form-data">
    <input type="hidden" name="promotionId" value="${promotion.promotionId}">
    <table>
      <tr>
        <td><label for="promotionName">광고명:</label></td>
        <td><input type="text" name="promotionName" id="promotionName" value="${promotion.promotionName}" required></td>
      </tr>
      <tr>
        <td><label for="startDate">시작 날짜:</label></td>
        <td><input type="date" name="startDate" id="startDate" value="${promotion.startDate}" required></td>
      </tr>
      <tr>
        <td><label for="endDate">종료 날짜:</label></td>
        <td><input type="date" name="endDate" id="endDate" value="${promotion.endDate}" required></td>
      </tr>
      <tr>
        <td><label>현재 이미지:</label></td>
        <td>
          <c:if test="${not empty promotion.promotionImage}">
            <img src="${promotion.promotionImage}" alt="Promotion Image" width="150" height="120">
          </c:if>
        </td>
      </tr>
      <tr>
        <td><label for="promotionImage">새 이미지 업로드:</label></td>
        <td><input type="file" name="promotionImage" id="promotionImage"></td>
      </tr>
      <tr>
        <td colspan="2" >
          <input type="submit" value="저장">
          <input type="button" value="취소" onclick="location.href='promotions'">
        </td>
      </tr>
    </table>
  </form>
</div>

</body>
</html>
