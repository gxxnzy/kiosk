<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Edit Promotion</title>
</head>
<body>
<h1>Edit Promotion</h1>

<form action="updatePromotion" method="post" enctype="multipart/form-data">
  <input type="hidden" name="promotionId" value="${promotion.promotionId}">
  <table>
    <tr>
      <th>광고명:</th>
      <td><input type="text" name="promotionName" value="${promotion.promotionName}" required></td>
    </tr>
    <tr>
      <th>시작 날짜:</th>
      <td><input type="date" name="startDate" value="${promotion.startDate}" required></td>
    </tr>
    <tr>
      <th>종료 날짜:</th>
      <td><input type="date" name="endDate" value="${promotion.endDate}" required></td>
    </tr>
    <tr>
      <th>현재 이미지:</th>
      <td>
        <c:if test="${not empty promotion.promotionImage}">
          <img src="${promotion.promotionImage}" alt="Promotion Image" width="150" height="120">
        </c:if>
      </td>
    </tr>
    <tr>
      <th>새 이미지 업로드:</th>
      <td><input type="file" name="promotionImage"></td>
    </tr>
  </table>
  <input type="submit" value="저장">
  <input type="button" value="취소" onclick="location.href='promotions'">
</form>

</body>
</html>
