<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <meta charset="UTF-8">
  <title>광고 추가</title>
  <style>
    body {
      background-color: #f4f4f9; /* Light grayish purple background */
      font-family: Arial, sans-serif;
      display: flex;
      justify-content: center;
      align-items: flex-start;
      height: 100vh;
      margin: 0;
      padding: 20px;
    }

    .container {
      background-color: #ffffff; /* White background */
      padding: 40px;
      border-radius: 10px;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
      width: 600px;
      max-width: 100%;
      border-top: 8px solid #c3bef0; /* Light purple top border */
    }

    h2 {
      margin-bottom: 20px;
      font-size: 28px;
      font-weight: bold;
      color: rgba(2, 2, 2, 0.97); /* Light purple heading */
      text-align: center;
    }

    hr {
      border: none;
      border-bottom: 1px solid #c3bef0; /* Light purple divider line */
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
      background-color: #c3bef0; /* Light purple button background */
      color: white;
    }

    input[type="button"] {
      background-color: #cadefc; /* Light gray button background */
      color: #333;
    }

    input[type="submit"]:hover {
      background-color: #b3a1e2; /* Slightly darker light purple on hover */
    }

    input[type="button"]:hover {
      background-color: #e0e0e0; /* Lighter gray hover background */
    }

    label {
      color: rgba(2, 2, 2, 0.97); /* Muted purple for labels */
    }
  </style>
</head>
<body>

<div class="container">
  <h2>광고 추가</h2>
  <hr>
  <form action="createPromotion" method="post" enctype="multipart/form-data">
    <table>
      <tr>
        <td><label for="promotionName">광고명</label></td>
        <td><input type="text" name="promotionName" id="promotionName" required></td>
      </tr>
      <tr>
        <td><label for="startDate">시작 날짜</label></td>
        <td><input type="date" name="startDate" id="startDate" required></td>
      </tr>
      <tr>
        <td><label for="endDate">종료 날짜</label></td>
        <td><input type="date" name="endDate" id="endDate" required></td>
      </tr>
      <tr>
        <td><label for="promotionImage">광고 이미지</label></td>
        <td><input type="file" name="promotionImage" id="promotionImage" accept="image/*" required></td>
      </tr>
      <tr>
        <td colspan="2" style="text-align: center;">
          <input type="submit" value="추가">
          <input type="button" value="취소" onclick="location.href='promotions'">
        </td>
      </tr>
    </table>
  </form>
</div>

</body>
</html>
