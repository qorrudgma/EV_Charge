<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<html>
<head>
    <title>경로 리스트</title>
    <style>
        :root {
            --naver-green: #11BF85;
            --naver-green-dark: #029e48;
            --gray-light: #f7f9fa;
            --gray-medium: #666666;
            --gray-dark: #333333;
            --border-color: #d1d9d6;
            --bg-route: #EBFFF6;
        }

        body {
            font-family: 'Noto Sans KR', 'Arial', sans-serif;
            background-color: var(--gray-light);
            margin: 0;
            color: var(--gray-dark);
        }

        #findpath_list {
            max-width: 400px;
            margin: 0 auto;
            background: white;
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
            padding: 12px 20px;
            overflow-y: auto;
            max-height: 600px;
            z-index: 1010;
            flex-direction: column;
            transform: translateX(100%);
            transition: transform 0.3s ease-in-out;
            display: flex;
        }

        #findpath_list .active {
            display: flex;
            transform: translateX(0);
        }

        #findpath_list h2 {
            text-align: center;
            color: var(--naver-green);
            font-weight: 700;
            font-size: 1.8rem;
            margin-bottom: 28px;
            border-bottom: 3px solid var(--naver-green);
            padding-bottom: 8px;
            letter-spacing: -0.02em;
        }

        .route-content {
            background-color: var(--bg-route);
            margin-bottom: 24px;
            padding-bottom: 12px;
            border-radius: 12px;
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.08);
            transition: box-shadow 0.3s ease;
            cursor: default;
        }
        .route-content:hover {
            box-shadow: 0 4px 16px rgba(0, 0, 0, 0.12);
        }

        .route-title {
            text-align: center;
            font-size: 1.1rem;
            font-weight: 700;
            border-top-left-radius: 12px;
            border-top-right-radius: 12px;
            color: white;
            background-color: #10B981;
            margin-bottom: 14px;
            padding-top: 4px;
            padding-bottom: 4px;
            user-select: none;
        }

        .route-item {
            font-size: 0.8rem;
            margin: 8px 8px 8px 8px;
            padding: 2px auto;
            display: flex;
            align-items: center;
        }

        .route-label {
            font-weight: 600;
            color: var(--naver-green-dark);
            flex: 0 0 140px;
            user-select: none;
        }

        .route-value {
            color: var(--gray-medium);
            word-break: break-word;
            flex: 1;
        }

        p.no-data {
            text-align: center;
            color: var(--gray-medium);
            font-style: italic;
            margin-top: 80px;
            font-size: 1.1rem;
            user-select: none;
        }
    </style>
</head>
<div id="findpath_list" role="region" aria-label="경로 정보 리스트">
    <c:if test="${not empty routeInfoList}">
        <h2>경로 정보 리스트</h2>
        <button type="button" onclick="history.back()">길찾기 취소</button>
        <c:forEach var="route" items="${routeInfoList}">
            <c:if test="${not empty route.name}">
                <div class="route-content" tabindex="0" aria-label="${route.name} 경로 정보">
                    <div class="route-title">${route.name}</div>
                    <c:if test="${route.distance != -1}">
                        <div class="route-item">
                            <span class="route-label">거리:</span> 
                            <span class="route-value">${route.distance} m</span>
                        </div>
                    </c:if>
                    <c:if test="${route.duration != -1}">
                        <div class="route-item">
                            <span class="route-label">소요시간:</span> 
                            <span class="route-value">${route.duration} 초</span>
                        </div>
                    </c:if>
                    <c:if test="${route.turnType != -1}">
                        <div class="route-item">
                            <span class="route-label">턴 유형:</span> 
                            <span class="route-value">${route.turnType}</span>
                        </div>
                    </c:if>
                    <c:if test="${route.roadType != -1}">
                        <div class="route-item">
                            <span class="route-label">도로 유형:</span> 
                            <span class="route-value">${route.roadType}</span>
                        </div>
                    </c:if>
                    <c:if test="${route.guidance != -1}">
                        <div class="route-item">
                            <span class="route-label">안내 문구:</span> 
                            <span class="route-value">${route.guidance}</span>
                        </div>
                    </c:if>
                    <c:if test="${route.trafficSpeed != -1}">
                        <div class="route-item">
                            <span class="route-label">교통 속도:</span> 
                            <span class="route-value">${route.trafficSpeed} km/h</span>
                        </div>
                    </c:if>
                    <c:if test="${route.trafficState != -1}">
                        <div class="route-item">
                            <span class="route-label">교통 상태:</span> 
                            <span class="route-value">${route.trafficState}</span>
                        </div>
                    </c:if>
                </div>
            </c:if>
        </c:forEach>
    </c:if>
</div>
</html>
