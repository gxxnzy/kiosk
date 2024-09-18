<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%><!-- JSTL -->

<html>
<head>
    <title>Title</title>
</head>
<body>
<form action="updateMenu" method="post">
    <table>
        <tr>
            <td>이미지</td>
            <td><img src="${menu.menuImage}" alt="${menu.menuName}" style="max-width: 300px; max-height: 200px;" />
            </td>
        </tr>
        <tr>
            <td>카테고리</td>
            <td>
                <select name="categoryName">
                    <option value="스테이크" ${menu.categoryName == '스테이크' ? 'selected' : ''}>스테이크</option>
                    <option value="파스타" ${menu.categoryName == '파스타' ? 'selected' : ''}>파스타</option>
                    <option value="필라프" ${menu.categoryName == '필라프' ? 'selected' : ''}>필라프</option>
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
            <td><input type="submit" value="수정"></td>
        </tr>
    </table>
</form>
</body>
</html>
