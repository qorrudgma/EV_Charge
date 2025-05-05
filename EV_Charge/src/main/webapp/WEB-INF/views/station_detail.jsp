<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div id="station-detail-sidebar" class="station-sidebarA">
    <div class="sidebar-header">
        <div class="sidebar-title">
            <i class="fas fa-charging-station"></i>
            <h3>충전소 상세 정보</h3>
        </div>
        <div class="sidebar-actions">
            <button id="back-to-list" class="action-btn" title="목록으로">
                <i class="fas fa-arrow-left"></i>
            </button>
            <button id="close-detail-sidebar" class="action-btn" title="닫기">
                <i class="fas fa-times"></i>
            </button>
        </div>
    </div>
    
    <div class="sidebar-content">
        <div class="station-detail-container">
            <!-- 충전소 상태 배지 -->
<!--            <div class="status-badge available">-->
<!--                <i class="fas fa-check-circle"></i>-->
<!--                <span>사용가능</span>-->
<!--            </div>-->
            
            <!-- 충전소 기본 정보 -->
            <div class="detail-section">
                <div id="station_lat"></div>
                <div id="station_lng"></div>

                <div class="station-header">
                    <h2 id="station-name" class="station-title"></h2>
                    <button id="toggle-favorite" class="favorite-btn" title="즐겨찾기">
                        <i class="fas fa-star"></i>
                    </button>
                </div>
                
                <div class="station-address-container">
                    <i class="fas fa-map-marker-alt"></i>
                    <p id="station-address" class="station-address"></p>
                </div>
                
                <div class="action-buttons">
                    <button class="action-button primary" onclick="navigateToStation()">
                        <i class="fas fa-directions"></i>
                        <span>길찾기</span>
                    </button>
                    <button class="action-button secondary" onclick="shareStation()">
                        <i class="fas fa-share-alt"></i>
                        <span>공유하기</span>
                    </button>
                </div>
            </div>
            
            <!-- 충전기 정보 -->
            <div class="detail-section">
                <h3 class="section-title">
                    <i class="fas fa-plug"></i>
                    <span>충전기 정보</span>
                </h3>
                
                <div class="charger-info">
                    <div class="charger-type">
                        <div class="charger-icon fast">
                            <i class="fas fa-bolt"></i>
                        </div>
                        <div class="charger-details">
                            <h4>급속 충전기</h4>
                            <p id="fast-charger-count"><strong id="strong_rapid"></strong>대</p>
                        </div>
                    </div>
                    
                    <div class="charger-type">
                        <div class="charger-icon slow">
                            <i class="fas fa-battery-half"></i>
                        </div>
                        <div class="charger-details">
                            <h4>완속 충전기</h4>
                            <p id="slow-charger-count"><strong id="strong_slow"></strong>대</p>
                        </div>
                    </div>
                </div>
                
				<!-- 충전기 현황 -->
<!--                <div class="charger-status">-->
<!--                    <div class="status-item available">-->
<!--                        <span class="status-dot"></span>-->
<!--                        <span class="status-label">사용가능</span>-->
<!--                        <span id="available-count" class="status-count">3</span>-->
<!--                    </div>-->
<!--                    <div class="status-item charging">-->
<!--                        <span class="status-dot"></span>-->
<!--                        <span class="status-label">충전중</span>-->
<!--                        <span id="charging-count" class="status-count">2</span>-->
<!--                    </div>-->
<!--                    <div class="status-item offline">-->
<!--                        <span class="status-dot"></span>-->
<!--                        <span class="status-label">점검중</span>-->
<!--                        <span id="offline-count" class="status-count">1</span>-->
<!--                    </div>-->
<!--                </div>-->
            </div>
            
            <!-- 지원 차종 정보 -->
            <div class="detail-section">
                <h3 class="section-title">
                    <i class="fas fa-car"></i>
                    <span>지원 차종</span>
                </h3>
                
                <div id="supported-vehicles" class="supported-vehicles">
                    <!-- <div class="vehicle-chip">현대</div>
                    <div class="vehicle-chip">기아</div>
                    <div class="vehicle-chip">테슬라</div>
                    <div class="vehicle-chip">BMW</div>
                    <div class="vehicle-chip">벤츠</div> -->
                </div>
            </div>
            
            <!-- 충전기 상세 목록 -->
<!--            <div class="detail-section">-->
<!--                <h3 class="section-title">-->
<!--                    <i class="fas fa-list"></i>-->
<!--                    <span>충전기 목록</span>-->
<!--                </h3>-->
                
<!--                <div class="charger-list">-->
<!--                    <div class="charger-item available">-->
<!--                        <div class="charger-header">-->
<!--                            <div class="charger-name">-->
<!--                                <span class="charger-number">01</span>-->
<!--                                <span class="charger-type">DC콤보</span>-->
<!--                            </div>-->
<!--                            <div class="charger-status">사용가능</div>-->
<!--                        </div>-->
<!--                        <div class="charger-specs">-->
<!--                            <div class="spec-item">-->
<!--                                <i class="fas fa-bolt"></i>-->
<!--                                <span>100kW</span>-->
<!--                            </div>-->
<!--                            <div class="spec-item">-->
<!--                                <i class="fas fa-dollar-sign"></i>-->
<!--                                <span>292.9원/kWh</span>-->
<!--                            </div>-->
<!--                        </div>-->
<!--                    </div>-->
<!--                </div>-->
            </div>
            
            <!-- 운영 정보 -->
            <div class="detail-section">
                <h3 class="section-title">
                    <i class="fas fa-info-circle"></i>
                    <span>운영 정보</span>
                </h3>
                
<!--                <div class="operation-info">-->
<!--                    <div class="info-item">-->
<!--                        <div class="info-label">운영 시간</div>-->
<!--                        <div id="operation-hours" class="info-value">24시간</div>-->
<!--                    </div>-->
<!--                    <div class="info-item">-->
<!--                        <div class="info-label">운영 기관</div>-->
<!--                        <div id="operation-agency" class="info-value">한국전력공사</div>-->
<!--                    </div>-->
<!--                    <div class="info-item">-->
<!--                        <div class="info-label">연락처</div>-->
<!--                        <div id="contact-number" class="info-value">1588-0000</div>-->
<!--                    </div>-->
<!--                    <div class="info-item">-->
<!--                        <div class="info-label">최근 업데이트</div>-->
<!--                        <div id="last-updated" class="info-value">2023-10-25 14:30</div>-->
<!--                    </div>-->
<!--                </div>-->
            </div>
        </div>
    <div class="sidebar-footer">
        <button id="report-issue" class="report-btn">
            <i class="fas fa-exclamation-triangle"></i>
            <span>오류 신고하기</span>
        </button>
    </div>
    </div>
</div>

<style>
    :root {
        --primary-color: #10b981;
        --primary-dark: #059669;
        --primary-light: #d1fae5;
        --secondary-color: #6b7280;
        --success-color: #10b981;
        --warning-color: #f59e0b;
        --danger-color: #ef4444;
        --text-color: #1f2937;
        --text-light: #6b7280;
        --white: #ffffff;
        --gray-50: #f9fafb;
        --gray-100: #f3f4f6;
        --gray-200: #e5e7eb;
        --gray-300: #d1d5db;
        --gray-400: #9ca3af;
        --gray-500: #6b7280;
        --gray-600: #4b5563;
        --gray-700: #374151;
        --gray-800: #1f2937;
        --gray-900: #111827;
        --border-radius: 0.5rem;
        --shadow-sm: 0 1px 2px 0 rgba(0, 0, 0, 0.05);
        --shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.1), 0 1px 2px 0 rgba(0, 0, 0, 0.06);
        --shadow-md: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
        --shadow-lg: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
        --transition: all 0.2s ease;
    }

    #station_lat, #station_lng{
        display: none;
    }

    .station-sidebarA { 
        position: absolute;
        top: 80px;
        left: 0;
        width: 380px;
        height: 88%;
        background-color: var(--white);
        box-shadow: var(--shadow-lg);
        z-index: 1010;
        display: flex;
        flex-direction: column;
        transition: transform 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        transform: translateX(-100%);
        font-family: 'Noto Sans KR', sans-serif;
		border-radius: 30px;
        overflow: hidden;
    }

    .station-sidebarA.active {
        transform: translateX(105%);
    }

    .sidebar-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 1rem 1.25rem;
        background-color: var(--primary-color);
        color: var(--white);
        border-bottom: 1px solid rgba(255, 255, 255, 0.1);
    }

    .sidebar-title {
        display: flex;
        align-items: center;
        gap: 0.75rem;
    }

    .sidebar-title i {
        font-size: 1.25rem;
    }

    .sidebar-title h3 {
        margin: 0;
        font-size: 1.125rem;
        font-weight: 600;
    }

    .sidebar-actions {
        display: flex;
        gap: 0.5rem;
    }

    .action-btn {
        background: none;
        border: none;
        color: var(--white);
        width: 2rem;
        height: 2rem;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        cursor: pointer;
        transition: var(--transition);
    }

    .action-btn:hover {
        background-color: rgba(255, 255, 255, 0.2);
    }

    .sidebar-content {
        flex: 1;
        overflow-y: auto;
        padding: 0;
        background-color: var(--gray-50);
    }

    .station-detail-container {
        position: relative;
        padding-bottom: 2rem;
    }

    .status-badge {
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        padding: 0.5rem 1.25rem;
        font-size: 0.875rem;
        font-weight: 600;
        display: flex;
        align-items: center;
        gap: 0.5rem;
        z-index: 1;
    }

    .status-badge.available {
        background-color: var(--primary-light);
        color: var(--primary-dark);
    }

    .status-badge.charging {
        background-color: #fef3c7;
        color: #92400e;
    }

    .status-badge.offline {
        background-color: #fee2e2;
        color: #b91c1c;
    }

    .detail-section {
        padding: 1.25rem;
        background-color: var(--white);
        margin-bottom: 0.75rem;
        border-bottom: 1px solid var(--gray-200);
    }

    .detail-section:first-of-type {
        padding-top: 3rem;
    }

    .station-header {
        display: flex;
        justify-content: space-between;
        align-items: flex-start;
        margin-bottom: 1rem;
    }

    .station-title {
        margin: 0;
        font-size: 1.25rem;
        font-weight: 700;
        color: var(--gray-900);
        line-height: 1.4;
    }

    .favorite-btn {
        background: none;
        border: none;
        color: var(--gray-400);
        cursor: pointer;
        transition: var(--transition);
        padding: 0.25rem;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 1.25rem;
    }

    .favorite-btn:hover {
        color: #f59e0b;
    }

    .favorite-btn.active {
        color: #f59e0b;
    }

    .station-address-container {
        display: flex;
        align-items: flex-start;
        gap: 0.75rem;
        margin-bottom: 1.25rem;
    }

    .station-address-container i {
        color: var(--primary-color);
        margin-top: 0.25rem;
    }

    .station-address {
        margin: 0;
        font-size: 0.875rem;
        color: var(--gray-600);
        line-height: 1.5;
    }

    .action-buttons {
        display: flex;
        gap: 0.75rem;
    }

    .action-button {
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 0.5rem;
        padding: 0.75rem 1rem;
        border-radius: 0.375rem;
        font-size: 0.875rem;
        font-weight: 500;
        cursor: pointer;
        transition: var(--transition);
        border: none;
        flex: 1;
    }

    .action-button.primary {
        background-color: var(--primary-color);
        color: var(--white);
    }

    .action-button.primary:hover {
        background-color: var(--primary-dark);
    }

    .action-button.secondary {
        background-color: var(--white);
        color: var(--gray-700);
        border: 1px solid var(--gray-300);
    }

    .action-button.secondary:hover {
        background-color: var(--gray-100);
    }

    .section-title {
        display: flex;
        align-items: center;
        gap: 0.5rem;
        margin: 0 0 1rem 0;
        font-size: 1rem;
        font-weight: 600;
        color: var(--gray-800);
    }

    .section-title i {
        color: var(--primary-color);
    }

    .charger-info {
        display: flex;
        gap: 1.5rem;
        margin-bottom: 1.25rem;
    }

    .charger-type {
        display: flex;
        align-items: center;
        gap: 0.75rem;
    }

    .charger-icon {
        width: 3rem;
        height: 3rem;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 1.25rem;
    }

    .charger-icon.fast {
        background-color: #fee2e2;
        color: #b91c1c;
    }

    .charger-icon.slow {
        background-color: #e0f2fe;
        color: #0369a1;
    }

    .charger-details h4 {
        margin: 0 0 0.25rem 0;
        font-size: 0.875rem;
        font-weight: 600;
        color: var(--gray-700);
    }

    .charger-details p {
        margin: 0;
        font-size: 1rem;
        color: var(--gray-900);
    }

    .charger-status {
        display: flex;
        justify-content: space-between;
        background-color: var(--gray-50);
        padding: 0.75rem;
        border-radius: 0.375rem;
    }

    .status-item {
        display: flex;
        align-items: center;
        gap: 0.375rem;
    }

    .status-dot {
        width: 0.75rem;
        height: 0.75rem;
        border-radius: 50%;
    }

    .status-item.available .status-dot {
        background-color: var(--success-color);
    }

    .status-item.charging .status-dot {
        background-color: var(--warning-color);
    }

    .status-item.offline .status-dot {
        background-color: var(--danger-color);
    }

    .status-label {
        font-size: 0.75rem;
        color: var(--gray-600);
    }

    .status-count {
        font-size: 0.75rem;
        font-weight: 600;
        color: var(--gray-900);
    }

    .supported-vehicles {
        display: flex;
        flex-wrap: wrap;
        gap: 0.5rem;
    }

    .vehicle-chip {
        padding: 0.375rem 0.75rem;
        background-color: var(--gray-100);
        border-radius: 9999px;
        font-size: 0.75rem;
        color: var(--gray-700);
    }

    .charger-list {
        display: flex;
        flex-direction: column;
        gap: 0.75rem;
    }

    .charger-item {
        padding: 0.75rem;
        border-radius: 0.375rem;
        border-left: 4px solid transparent;
    }

    .charger-item.available {
        background-color: var(--gray-50);
        border-left-color: var(--success-color);
    }

    .charger-item.charging {
        background-color: var(--gray-50);
        border-left-color: var(--warning-color);
    }

    .charger-item.offline {
        background-color: var(--gray-50);
        border-left-color: var(--danger-color);
    }

    .charger-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 0.5rem;
    }

    .charger-name {
        display: flex;
        align-items: center;
        gap: 0.5rem;
    }

    .charger-number {
        font-weight: 600;
        color: var(--gray-800);
    }

    .charger-type {
        font-size: 0.75rem;
        color: var(--gray-600);
    }

    .charger-status {
        font-size: 0.75rem;
        font-weight: 500;
    }

    .charger-item.available .charger-status {
        color: var(--success-color);
    }

    .charger-item.charging .charger-status {
        color: var(--warning-color);
    }

    .charger-item.offline .charger-status {
        color: var(--danger-color);
    }

    .charger-specs {
        display: flex;
        gap: 1rem;
    }

    .spec-item {
        display: flex;
        align-items: center;
        gap: 0.375rem;
        font-size: 0.75rem;
        color: var(--gray-600);
    }

    .spec-item i {
        color: var(--gray-500);
    }

    .operation-info {
        display: grid;
        grid-template-columns: repeat(2, 1fr);
        gap: 1rem;
    }

    .info-item {
        display: flex;
        flex-direction: column;
        gap: 0.25rem;
    }

    .info-label {
        font-size: 0.75rem;
        color: var(--gray-500);
    }

    .info-value {
        font-size: 0.875rem;
        color: var(--gray-800);
        font-weight: 500;
    }

    .sidebar-footer {
        padding: 1rem;
        background-color: var(--white);
        border-top: 1px solid var(--gray-200);
    }

    .report-btn {
        width: 100%;
        padding: 0.75rem;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 0.5rem;
        background-color: var(--white);
        border: 1px solid var(--gray-300);
        border-radius: 0.375rem;
        color: var(--gray-700);
        font-size: 0.875rem;
        font-weight: 500;
        cursor: pointer;
        transition: var(--transition);
    }

    .report-btn:hover {
        background-color: var(--gray-100);
    }

    /* 모바일 대응 */
    @media (max-width: 768px) {
        .station-sidebar {
            width: 100%;
            height: 80%;
            top: auto;
            bottom: 0;
            transform: translateY(100%);
            border-radius: 1rem 1rem 0 0;
        }

        .station-sidebar.active {
            transform: translateY(0);
        }
        
        .sidebar-header {
            border-radius: 1rem 1rem 0 0;
            padding: 1rem;
        }
        
        .sidebar-header::before {
            content: '';
            position: absolute;
            top: 0.5rem;
            left: 50%;
            transform: translateX(-50%);
            width: 4rem;
            height: 0.25rem;
            background-color: rgba(255, 255, 255, 0.3);
            border-radius: 9999px;
        }
    }

    /* 애니메이션 */
    @keyframes fadeIn {
        from { opacity: 0; }
        to { opacity: 1; }
    }

    @keyframes slideIn {
        from { transform: translateY(10px); opacity: 0; }
        to { transform: translateY(0); opacity: 1; }
    }

    .detail-section {
        animation: fadeIn 0.3s ease-out forwards;
    }

    .detail-section:nth-child(1) { animation-delay: 0.05s; }
    .detail-section:nth-child(2) { animation-delay: 0.1s; }
    .detail-section:nth-child(3) { animation-delay: 0.15s; }
    .detail-section:nth-child(4) { animation-delay: 0.2s; }
    .detail-section:nth-child(5) { animation-delay: 0.25s; }
</style>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        // 사이드바 토글
        const sidebar = document.getElementById('station-detail-sidebar');
        const closeSidebarBtn = document.getElementById('close-detail-sidebar');
        const backToListBtn = document.getElementById('back-to-list');
        
        // 사이드바 열기 함수 (외부에서 호출 가능)
        window.openDetailSidebar = function(stationData) {
            // 여기에 stationData를 사용하여 사이드바 내용을 채우는 로직 구현
            // 예: document.getElementById('station-name').textContent = stationData.name;
            
            sidebar.classList.add('active');
        };
        
        // 사이드바 닫기
        closeSidebarBtn.addEventListener('click', function() {
            sidebar.classList.remove('active');
        });
        
        // 목록으로 돌아가기
        backToListBtn.addEventListener('click', function() {
            sidebar.classList.remove('active');
            // 목록 사이드바 열기 로직 (필요한 경우)
            if (window.openSidebar) {
                window.openSidebar();
            }
        });
        
        // 즐겨찾기 토글
        const favoriteBtn = document.getElementById('toggle-favorite');
        
        favoriteBtn.addEventListener('click', function() {
            this.classList.toggle('active');
            
            // 즐겨찾기 API 호출 로직 (사용자가 구현)
            const stationId = document.getElementById('station-name').getAttribute('data-id');
            const isFavorite = this.classList.contains('active');
            
            console.log(`충전소 ${stationId} 즐겨찾기 ${isFavorite ? '추가' : '제거'}`);
        });
    });
    
    // 길찾기 함수
    function navigateToStation() {
        // 길찾기 로직 (사용자가 구현)
        const lat = document.getElementById('station-name').getAttribute('data-lat');
        const lng = document.getElementById('station-name').getAttribute('data-lng');
        
        console.log(`길찾기: 위도 ${lat}, 경도 ${lng}`);
    }
    
    // 공유하기 함수
    function shareStation() {
        // 공유하기 로직 (사용자가 구현)
        const stationName = document.getElementById('station-name').textContent;
        const stationAddress = document.getElementById('station-address').textContent;
        
        console.log(`공유하기: ${stationName} (${stationAddress})`);
    }
	
	// 마커 클릭
	function updateStationDetail(markerData) {
        var name = markerData.name;
        var address = markerData.address;
        var lat = markerData.lat;
        var lng = markerData.lng;
        var rapid = markerData.rapid;
        var slow = markerData.slow;
        var cars = markerData.car;

        document.getElementById("station-name").textContent = name;
        document.getElementById("station-address").textContent = address;
        document.getElementById("station_lat").textContent = lat;
        document.getElementById("station_lng").textContent = lng;
        document.getElementById("strong_rapid").textContent = rapid;
        document.getElementById("strong_slow").textContent = slow;
        // document.getElementById("supported-vehicles").textContent = car;
        const car_list = cars.split(",");
        console.log(car_list);
		
        document.getElementById("supported-vehicles").textContent = "";
        for(let car of car_list){
            document.getElementById("supported-vehicles").innerHTML += `<div class="vehicle-chip">`+car+`</div>`;
            //document.getElementById("supported-vehicles").innerHTML += `<div class="vehicle-chip">${car}</div>`;
		}
    }
</script>