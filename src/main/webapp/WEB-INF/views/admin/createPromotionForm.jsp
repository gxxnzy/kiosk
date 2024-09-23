<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>광고 추가</title>
  <style>
    body {
      text-align: center;
    }

    table {
      margin: 0 auto;
      border-collapse: collapse;
    }
  </style>
</head>
<body>

<h1>광고 추가</h1>

<form action="createPromotion" method="post" enctype="multipart/form-data">
  <table>
    <tr>
      <th>광고명</th>
      <td><input type="text" name="promotionName" required></td>
    </tr>
    <tr>
      <th>시작 날짜</th>
      <td><input type="date" name="startDate" required></td>
    </tr>
    <tr>
      <th>종료 날짜</th>
      <td><input type="date" name="endDate" required></td>
    </tr>
    <tr>
      <th>광고 이미지</th>
      <td><input type="file" name="promotionImage" accept="image/*" required></td>
    </tr>
    <tr>
      <td colspan="2" style="text-align: center;">
        <input type="submit" value="추가">
        <input type="button" value="취소" onclick="location.href='promotions'">
      </td>
    </tr>
  </table>
</form>


</body>
</html>
