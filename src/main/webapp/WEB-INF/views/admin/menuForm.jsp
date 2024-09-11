<%--
  Created by IntelliJ IDEA.
  User: woori
  Date: 2024-09-05
  Time: 오후 3:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%><!-- JSTL -->

<html>
<head>
    <title>Menu</title>
</head>
<body>
메뉴 조회
<hr>
<br>
<form action="menuResult" method="post">
    <fieldset>
        <legend>&nbsp;검색 조건&nbsp;</legend>
        <table>
            <tr>
                <th>이름</th>
                <td>
                    <input type="text" name="name" value=${param.name} >
                </td>
                <th>카테고리</th>
                <td>
                    <input type="text" name="category" value="${param.category}">
                </td>
            </tr>
            <tr>
                <th>활성여부</th>
                <td>
                    <select name="active">
                        <option value=1 <c:out value="${param.active == 1 ? 'selected' : ''}"/>>1</option>
                        <option value=0 <c:out value="${param.active == 0 ? 'selected' : ''}"/>>0</option>
                    </select>
                <td rowspan="2">
                    <input type="submit" value="검색" >
                    <input type="button" id="init" value="취소" onclick="init()" >
                </td>
            </tr>
        </table>
    </fieldset>
    <br>
    <table>
        <tr>
            <th>번호</th>
            <th>이름</th>
            <th>가격</th>
        </tr>
        <tr>
            <td>1</td>
            <td>안심스테이크</td>
            <td>40000원</td>
        </tr>
    </table>
</form>
</body>
</html>