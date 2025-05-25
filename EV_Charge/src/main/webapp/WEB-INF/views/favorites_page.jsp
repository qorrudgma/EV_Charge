<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<script src="${pageContext.request.contextPath}/js/jquery.js"></script>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><c:out value="${pageTitle != null ? pageTitle : '나의 즐겨찾기'}"/> - EV Charge</title>
    <%-- 공통 CSS 및 Font Awesome --%>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
	
	<c:if test="${not empty sessionScope.user && not empty sessionScope.user.user_no}">
			    <script>
			        // 이전에 window.myApp.userNo 등으로 사용하셨다면 해당 변수명 유지
			        window.APP_USER_NO = parseInt(${sessionScope.user.user_no});
			        // console.log('[Header/Common JSP] 로그인된 사용자 번호 (window.APP_USER_NO):', window.APP_USER_NO);

			        // 즐겨찾기 ID 목록도 여기서 초기화 (세션에 "favoriteStationIds"가 저장되어 있다는 가정 하에)
			        window.userFavoriteStationIds = new Set();
			        <c:if test="${not empty sessionScope.favoriteStationIds}">
			            <c:forEach var="statId" items="${sessionScope.favoriteStationIds}">
			                window.userFavoriteStationIds.add("${fn:escapeXml(statId)}");
			            </c:forEach>
			        </c:if>

			        // window.myApp.contextPath 설정 (이미 있다면 유지)
			        window.myApp = window.myApp || {}; // myApp 객체가 없다면 생성
			        window.myApp.contextPath = '${pageContext.request.contextPath}';
			    </script>
			</c:if>

			<c:if test="${empty sessionScope.user || empty sessionScope.user.user_no}">
			    <script>
			        window.APP_USER_NO = null;
			        window.userFavoriteStationIds = new Set(); // 비로그인 시 빈 Set으로 초기화

			        window.myApp = window.myApp || {};
			        window.myApp.contextPath = '${pageContext.request.contextPath}';
			    </script>
			</c:if>
</head>
<body>
    <jsp:include page="/WEB-INF/views/header.jsp" />

    <main class="favorites-container">
        <h1><i class="fas fa-heart" style="color: #e74c3c;"></i> 나의 즐겨찾기</h1>

        <c:if test="${not empty errorMessage}">
            <p class="error-message"><c:out value="${errorMessage}"/></p>
        </c:if>

        <c:choose>
            <c:when test="${not empty favoritesList}">
                <ul class="favorite-items-grid">
                    <c:forEach var="fav" items="${favoritesList}">
                        <li class="favorite-item-card" id="fav-item-${fn:escapeXml(fav.stat_name)}">
                            <div class="favorite-card-header">
                                <h3 class="station-name">충전소: <c:out value="${fav.stat_name}"/></h3>
                            </div>
                            <div class="favorite-card-body">
                                <p class="address">
                                    <i class="fas fa-map-marker-alt"></i>
                                    <c:out value="${fav.addr}"/>
                                    <c:if test="${not empty fav.addr_detail && fav.addr_detail ne 'null'}">
                                        <br/><c:out value="${fav.addr_detail}"/>
                                    </c:if>
                                    <c:if test="${not empty fav.location && fav.location ne 'null' && fav.location ne fav.addr_detail}">
                                        <br/>(<c:out value="${fav.location}"/>)
                                    </c:if>
                                </p>
                                <p class="coordinates" style="display:none;">
                                    위도: <c:out value="${fav.lat}"/>, 경도: <c:out value="${fav.lng}"/>
                                </p>
                            </div>
                            <div class="favorite-card-actions">
                                <a href="${pageContext.request.contextPath}/main?lat=${fav.lat}&lng=${fav.lng}&statId=${fn:escapeXml(fav.stat_id)}&openDetail=true" class="action-btn view-map-btn">
                                    <i class="fas fa-map-marked-alt"></i> 지도에서 보기
                                </a>
                                <button class="action-btn remove-fav-btn" 
                                        data-stat-id="${fn:escapeXml(fav.stat_id)}"
                                        data-user-no="${fav.user_no}"
                                        data-addr="${fn:escapeXml(fav.addr)}"
                                        data-addr-detail="${fn:escapeXml(fav.addr_detail)}"
                                        data-location="${fn:escapeXml(fav.location)}"
                                        data-lat="${fav.lat}"
                                        data-lng="${fav.lng}">
                                    <i class="fas fa-trash-alt"></i> 삭제
                                </button>
                            </div>
                        </li>
                    </c:forEach>
                </ul>
            </c:when>
            <c:otherwise>
                <c:if test="${empty errorMessage}">
                    <p class="no-favorites-info">즐겨찾기한 충전소가 없습니다. <br/>지도에서 충전소를 찾아 <i class="fas fa-star"></i> 아이콘을 클릭하여 즐겨찾기에 추가해보세요!</p>
                </c:if>
            </c:otherwise>
        </c:choose>
    </main>


    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const removeButtons = document.querySelectorAll('.remove-fav-btn');
            removeButtons.forEach(button => {
                button.addEventListener('click', function() {
                    const statId = this.dataset.statId;
                    const userNoFromData = parseInt(this.dataset.userNo);

                    if (!window.APP_USER_NO) {
                        alert("로그인이 필요합니다.");
                        window.location.href = (window.myApp && window.myApp.contextPath ? window.myApp.contextPath : '') + '/login';
                        return;
                    }
                    
                    if (window.APP_USER_NO !== userNoFromData) {
                        alert("잘못된 접근입니다. 본인의 즐겨찾기만 삭제할 수 있습니다.");
                        return;
                    }

                    if (confirm("이 충전소를 즐겨찾기에서 삭제하시겠습니까?")) {
                        const payload = {
                            user_no: window.APP_USER_NO,
                            stat_id: statId,
                            addr: this.dataset.addr,
                            addr_detail: this.dataset.addrDetail === 'null' ? null : this.dataset.addrDetail,
                            location: this.dataset.location === 'null' ? null : this.dataset.location,
                            lat: parseFloat(this.dataset.lat),
                            lng: parseFloat(this.dataset.lng)
                        };

                        $.ajax({
                            url: (window.myApp && window.myApp.contextPath ? window.myApp.contextPath : '') + "/favorites/toggle", // 기존 토글 API 사용
                            method: "POST",
                            contentType: "application/json",
                            data: JSON.stringify(payload),
                            success: function(response) {
                                alert(response.message);
                                if (response.status === 'success' && response.action === 'removed') {
                                    // 페이지에서 해당 항목 즉시 제거
                                    const itemToRemove = document.getElementById('fav-item-' + statId);
                                    if (itemToRemove) {
                                        itemToRemove.remove();
                                    }
                                    if (window.userFavoriteStationIds) {
                                        window.userFavoriteStationIds.delete(statId);
                                    }
                                    if (document.querySelectorAll('.favorite-item-card').length === 0) {
                                        const noFavsMsg = document.querySelector('.no-favorites-info');
                                        if (noFavsMsg) noFavsMsg.style.display = 'block';
                                    }
                                }
                                history.go(0);
                            },
                            error: function(jqXHR) {
                                let errorMsg = "즐겨찾기 삭제 중 오류가 발생했습니다.";
                                if (jqXHR.responseJSON && jqXHR.responseJSON.message) {
                                    errorMsg = jqXHR.responseJSON.message;
                                }
                                alert(errorMsg);
                            }
                        });
                    }
                });
            });

        });
    </script>
</body>
<style>
body {
    font-family: Arial, sans-serif;
    background-color: #f4f7f6;
    margin: 0;
    padding: 0;
}

.favorites-container {
    max-width: 1200px;
    margin: 20px auto;
    padding: 20px;
}

.favorites-container h1 {
    text-align: center;
    margin-bottom: 30px;
    color: #333;
    font-size: 2em;
}

.favorite-items-grid {
    list-style: none;
    padding: 0;
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(320px, 1fr));
    gap: 25px;
}

.favorite-item-card {
    background-color: #fff;
    border: 1px solid #e0e0e0;
    border-radius: 8px;
    box-shadow: 0 4px 8px rgba(0,0,0,0.08);
    padding: 20px;
    display: flex;
    flex-direction: column;
    transition: box-shadow 0.3s ease;
}

.favorite-item-card:hover {
    box-shadow: 0 6px Px rgba(0,0,0,0.12);
}

.favorite-card-header .station-name {
    font-size: 1.25em;
    color: #007bff;
    margin-top: 0;
    margin-bottom: 12px;
    word-break: keep-all;
}

.favorite-card-body .address {
    font-size: 0.95em;
    color: #555;
    margin-bottom: 15px;
    line-height: 1.5;
}
.favorite-card-body .address .fa-map-marker-alt {
    margin-right: 6px;
    color: #777;
}

.favorite-card-actions {
    margin-top: auto;
    padding-top: 15px;
    border-top: 1px solid #f0f0f0;
    display: flex;
    gap: 10px;
}

.favorite-card-actions .action-btn {
    flex: 1;
    padding: 10px 15px;
    text-decoration: none;
    color: white;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    text-align: center;
    font-size: 0.9em;
    transition: background-color 0.2s ease;
}

.favorite-card-actions .view-map-btn {
    background-color: #17a2b8;
}
.favorite-card-actions .view-map-btn:hover {
    background-color: #138496;
}

.favorite-card-actions .remove-fav-btn {
    background-color: #dc3545;
}
.favorite-card-actions .remove-fav-btn:hover {
    background-color: #c82333;
}

.favorite-card-actions .action-btn .fas {
    margin-right: 5px;
}

.no-favorites-info {
    text-align: center;
    font-size: 1.1em;
    color: #6c757d;
    padding: 50px 20px;
    background-color: #fff;
    border: 1px dashed #ced4da;
    border-radius: 8px;
    margin-top: 20px;
}
.no-favorites-info .fas {
    color: #ffc107;
}
.no-favorites-info .fa-heart {
     color: #e74c3c;
}


.error-message {
    color: #dc3545;
    text-align: center;
    margin: 20px 0;
    padding: 10px;
    background-color: #f8d7da;
    border: 1px solid #f5c6cb;
    border-radius: 5px;
    font-weight: bold;
}
</style>
</html>