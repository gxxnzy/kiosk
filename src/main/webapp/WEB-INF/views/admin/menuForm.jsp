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
                    <select name="category">
                        <option value="">--전체--</option>
                        <option value="스테이크" <c:out value="${param.category == '스테이크' ? 'selected' : ''}"/>>스테이크</option>
                        <option value="파스타" <c:out value="${param.category == '파스타' ? 'selected' : ''}"/>>파스타</option>
                        <option value="리조또" <c:out value="${param.category == '리조또' ? 'selected' : ''}"/>>리조또</option>
                        <option value="리조또" <c:out value="${param.category == '리조또' ? 'selected' : ''}"/>>리조또</option>
                        <option value="사이드" <c:out value="${param.category == '사이드' ? 'selected' : ''}"/>>사이드</option>
                        <option value="음료" <c:out value="${param.category == '음료' ? 'selected' : ''}"/>>음료</option>
                    </select>
                </td>
            </tr>
            <tr>
                <th>활성여부</th>
                <td>
                    <select name="active">
                        <option value="">--전체--</option>
                        <option value=판매 <c:out value="${param.active == '판매' ? 'selected' : ''}"/>>판매</option>
                        <option value=미판매 <c:out value="${param.active == '미판매' ? 'selected' : ''}"/>>미판매</option>
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