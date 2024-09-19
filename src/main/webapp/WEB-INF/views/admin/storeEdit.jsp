<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>지점 수정</title>
    <style>
      body {
        text-align: center;
        margin: 0;
        padding: 0;
      }

      form {
        margin: 20px auto;
        width: 100%;
        max-width: 600px;
      }

      table {
        margin: 0 auto;
        border-collapse: collapse;
        width: 100%;
      }

      th, td {
        padding: 10px;
        text-align: left;
        border: 1px solid #ddd;
      }

      th {
        background-color: #f4f4f4;
      }
    </style>
</head>
<body>

<h1>지점 수정</h1>

<form action="updateStore" method="post">
    <table>
        <tr>
            <th>지점명</th>
            <td>
                <!-- 수정할 수 없도록 readonly 속성 추가 -->
                <input type="text" name="storeName" value="${store.storeName}" readonly>
            </td>
        </tr>
        <tr>
            <th>지점 아이디</th>
            <td>
                <input type="text" name="storeId" value="${store.storeId}" readonly>
            </td>
        </tr>
        <tr>
            <th>비밀번호</th>
            <td>
                <!-- 비밀번호는 수정할 경우에만 입력 -->
                <input type="password" name="password" placeholder="비밀번호를 변경하려면 입력">
            </td>
        </tr>
        <tr>
            <th>도로명 주소</th>
            <td>
                <input type="text" name="roadAddress" value="${store.roadAddress}" required>
            </td>
        </tr>
        <tr>
            <th>시/구/동</th>
            <td>
                <input type="text" name="storeAddress1" value="${store.storeAddress1}">
            </td>
        </tr>
        <tr>
            <th>상세 주소</th>
            <td>
                <input type="text" name="storeAddress2" value="${store.storeAddress2}">
            </td>
        </tr>
        <tr>
            <th>오픈 날짜</th>
            <td>
                <input type="date" name="storeOpenDate" value="${store.storeOpenDate}" required>
            </td>
        </tr>
        <tr>
            <th>매장 전화번호</th>
            <td>
                <input type="text" name="storePhonenumber" value="${store.storePhonenumber}">
            </td>
        </tr>
        <tr>
            <th>영업 상태</th>
            <td>
                <select name="storeStatus" required>
                    <option value="영업중" ${store.storeStatus == '영업중' ? 'selected' : ''}>영업중</option>
                    <option value="폐점" ${store.storeStatus == '폐점' ? 'selected' : ''}>폐점</option>
                </select>
            </td>
        </tr>
        <tr>
            <td colspan="2" style="text-align: center;">
                <input type="submit" value="수정">
                <input type="button" value="취소" onclick="location.href='${store.storeId}'">
            </td>
        </tr>
    </table>
</form>

</body>
</html>
