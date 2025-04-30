<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>충전소 검색 결과</title>
    <style>
        .station-box {
            border: 1px solid #ddd;
            padding: 15px;
            margin-bottom: 10px;
            border-radius: 8px;
        }
        .station-name {
            font-weight: bold;
            font-size: 1.2em;
        }
        .station-info {
            margin-top: 5px;
        }
    </style>
</head>
<body>

<h2>검색 결과 (${stationList.size()}개 충전소)</h2>

<c:choose>
    <c:when test="${not empty stationList}">
        <c:forEach var="station" items="${stationList}">
            <div class="station-box">
                <div class="station-name">${station.stationName}</div>
                <div class="station-info">주소: ${station.stationAddress}</div>
                <div class="station-info">위도: ${station.evseLocationLatitude}</div>
                <div class="station-info">경도: ${station.evseLocationLongitude}</div>
                <div><button>즐겨찾기</button></div>
            </div>
        </c:forEach>
    </c:when>
    <c:otherwise>
        <p>반경 내 충전소가 없습니다.</p>
    </c:otherwise>
</c:choose>

</body>
</html>