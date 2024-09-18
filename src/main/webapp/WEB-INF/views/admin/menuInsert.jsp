<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>메뉴 추가</title>
</head>
<body>
<h2>메뉴 추가</h2>
<hr>
<br>
<form action="menuInsertResult" method="post" enctype="multipart/form-data">
    <table>
        <tr>
            <td>카테고리</td>
            <td>
                <select name="categoryName">
                    <option value="스테이크">스테이크</option>
                    <option value="파스타">파스타</option>
                    <option value="필라프">필라프</option>
                </select>
            </td>
        </tr>
        <tr>
            <td>이름</td>
            <td><input type="text" name="menuName" required></td>
        </tr>
        <tr>
            <td>가격</td>
            <td><input type="text" name="menuPrice" required></td>
        </tr>
        <tr>
            <td>설명</td>
            <td><textarea id="info" name="info" required></textarea></td>
        </tr>
        <tr>
            <td>이미지</td>
            <td><input type="file" name="menuImage" accept="image/*"></td>
        </tr>
        <tr>
            <td>
                <input type="submit" value="등록">
                <input type="reset" value="취소">
            </td>
        </tr>
    </table>
</form>
</body>
</html>
