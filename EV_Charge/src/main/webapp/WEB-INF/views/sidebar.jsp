<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div id="station-sidebar" class="station-sidebar active">
    <div class="sidebar-header">
        <div class="sidebar-title">
            <i class="fas fa-charging-station"></i>
            <h3>충전소 목록</h3>
        </div>
        <div class="sidebar-actions">
            <button id="refresh-stations" class="action-btn" title="새로고침">
                <i class="fas fa-sync-alt"></i>
            </button>
            <button id="close-sidebar" class="action-btn" title="닫기">
                <i class="fas fa-times"></i>
            </button>
        </div>
    </div>

    <form id="station_searchfrm">
        <div class="sidebar-search">
            <div class="search-container">
                <i class="fas fa-search search-icon"></i>
                <!-- <input type="text" id="station-search" placeholder="충전소 검색..." class="search-input"> -->
                <input type="search" name="address" id="station-search" placeholder="충전소 검색" class="search-input">
                <input type="hidden" name="radiusKm" value="3">
                <button class="search-clear" id="clear-search">
                    <i class="fas fa-times-circle"></i>
                </button>
            </div>
            <input type="button" class="ev-search-button" value="검색" onclick="search()">
        </div>
    </form>
    
    <div class="sidebar-filters">
        <div class="filter-chips">
            <button class="filter-chip active" data-filter="all">
                <span>전체</span>
                <span class="count">${stationList.size()}</span>
            </button>
            <button class="filter-chip" data-filter="available">
                <span>사용가능</span>
                <span class="count" id="available-count">0</span>
            </button>
            <button class="filter-chip" data-filter="favorite">
                <span>즐겨찾기</span>
                <i class="fas fa-star"></i>
            </button>
        </div>
    </div>
    
    <div class="sidebar-results">
        <h4 class="results-title">
            검색 결과 <span class="results-count">${stationList.size()}개</span>
        </h4>
    </div>
    
    <div class="sidebar-content">
        <div id="station-list" class="station-list">
            <c:choose>
                <c:when test="${not empty stationList}">
                    <c:forEach var="station" items="${stationList}" varStatus="status">
                        <div class="station-item" data-id="${station.stationId}" data-lat="${station.evseLocationLatitude}" data-lng="${station.evseLocationLongitude}">
                            <div class="station-status ${status.index % 3 == 0 ? 'available' : (status.index % 3 == 1 ? 'busy' : 'offline')}">
                                <i class="fas ${status.index % 3 == 0 ? 'fa-check-circle' : (status.index % 3 == 1 ? 'fa-clock' : 'fa-exclamation-circle')}"></i>
                                <span>${status.index % 3 == 0 ? '사용가능' : (status.index % 3 == 1 ? '사용중' : '점검중')}</span>
                            </div>
                            
                            <div class="station-content">
                                <div class="station-header">
                                    <h4 class="station-name">${station.stationName}</h4>
                                    <button class="favorite-btn ${status.index % 5 == 0 ? 'active' : ''}" title="즐겨찾기">
                                        <i class="fas fa-star"></i>
                                    </button>
                                </div>
                                
                                <div class="station-address">
                                    <i class="fas fa-map-marker-alt"></i>
                                    <span>${station.stationAddress}</span>
                                </div>
                                
                                <div class="station-details">
                                    <div class="detail-item">
                                        <i class="fas fa-bolt"></i>
                                        <span>DC콤보 (100kW)</span>
                                    </div>
                                    <div class="detail-item">
                                        <i class="fas fa-plug"></i>
                                        <span>${status.index % 2 == 0 ? '2/4' : '1/2'} 사용가능</span>
                                    </div>
                                    <div class="detail-item">
                                        <i class="fas fa-route"></i>
                                        <span>${status.index * 0.5 + 0.5}km</span>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="station-actions">
                                <button class="action-button primary" onclick="navigateToStation('${station.evseLocationLatitude}', '${station.evseLocationLongitude}')">
                                    <i class="fas fa-directions"></i>
                                    <span>길찾기</span>
                                </button>
                                <button class="action-button secondary" onclick="showStationDetail('${station.stationId}')">
                                    <i class="fas fa-info-circle"></i>
                                    <span>상세정보</span>
                                </button>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="empty-state">
                        <div class="empty-icon">
                            <i class="fas fa-search"></i>
                        </div>
                        <h4>검색 결과가 없습니다</h4>
                        <p>검색 반경을 넓히거나 다른 위치에서 검색해보세요.</p>
                        <button class="action-button primary" onclick="resetSearch()">
                            <i class="fas fa-redo"></i>
                            <span>검색 초기화</span>
                        </button>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
    
    <div class="sidebar-footer">
        <div class="footer-info">
            <p>마지막 업데이트: <span id="last-updated">2023-10-25 14:30</span></p>
        </div>
        <button id="load-more" class="load-more-btn">
            <i class="fas fa-plus"></i>
            <span>더 보기</span>
        </button>
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

    .station-sidebar {
        position: absolute;
        top: 64px;
        left: 0;
        width: 380px;
        height: 880px;
        background-color: var(--white);
        box-shadow: var(--shadow-lg);
        z-index: 1020;
        display: flex;
        flex-direction: column;
        transition: transform 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        transform: translateX(-100%);
        font-family: 'Noto Sans KR', sans-serif;
    }

    .station-sidebar.active {
        transform: translateX(0);
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

    .sidebar-search {
        padding: 1rem;
        background-color: var(--white);
        border-bottom: 1px solid var(--gray-200);
    }

    .search-container {
        position: relative;
        display: flex;
        align-items: center;
    }

    .search-icon {
        position: absolute;
        left: 1rem;
        color: var(--gray-500);
    }

    .search-input {
        width: 100%;
        padding: 0.75rem 2.5rem;
        border: 1px solid var(--gray-300);
        border-radius: var(--border-radius);
        font-size: 0.875rem;
        transition: var(--transition);
    }

    .search-input:focus {
        outline: none;
        border-color: var(--primary-color);
        box-shadow: 0 0 0 3px var(--primary-light);
    }

    .search-clear {
        position: absolute;
        right: 1rem;
        background: none;
        border: none;
        color: var(--gray-400);
        cursor: pointer;
        display: none;
    }

    .search-input:not(:placeholder-shown) + .search-clear {
        display: block;
    }

    .sidebar-filters {
        padding: 0.75rem 1rem;
        background-color: var(--white);
        border-bottom: 1px solid var(--gray-200);
    }

    .filter-chips {
        display: flex;
        gap: 0.5rem;
        overflow-x: auto;
        scrollbar-width: none;
        -ms-overflow-style: none;
    }

    .filter-chips::-webkit-scrollbar {
        display: none;
    }

    .filter-chip {
        display: flex;
        align-items: center;
        gap: 0.5rem;
        padding: 0.5rem 0.75rem;
        background-color: var(--gray-100);
        border: 1px solid var(--gray-200);
        border-radius: 9999px;
        font-size: 0.75rem;
        font-weight: 500;
        color: var(--gray-700);
        cursor: pointer;
        transition: var(--transition);
        white-space: nowrap;
    }

    .filter-chip:hover {
        background-color: var(--gray-200);
    }

    .filter-chip.active {
        background-color: var(--primary-light);
        border-color: var(--primary-color);
        color: var(--primary-dark);
    }

    .filter-chip .count {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        min-width: 1.5rem;
        height: 1.5rem;
        padding: 0 0.375rem;
        background-color: var(--white);
        border-radius: 9999px;
        font-size: 0.75rem;
        font-weight: 600;
    }

    .filter-chip.active .count {
        background-color: var(--primary-color);
        color: var(--white);
    }

    .sidebar-results {
        padding: 0.75rem 1rem;
        background-color: var(--gray-50);
        border-bottom: 1px solid var(--gray-200);
    }

    .results-title {
        margin: 0;
        font-size: 0.875rem;
        font-weight: 600;
        color: var(--gray-700);
        display: flex;
        align-items: center;
        justify-content: space-between;
    }

    .results-count {
        font-weight: 700;
        color: var(--primary-color);
    }

    .sidebar-content {
        flex: 1;
        overflow-y: auto;
        padding: 1rem;
        background-color: var(--gray-50);
    }

    .station-list {
        display: flex;
        flex-direction: column;
        gap: 1rem;
    }

    .station-item {
        background-color: var(--white);
        border-radius: var(--border-radius);
        box-shadow: var(--shadow);
        overflow: hidden;
        transition: var(--transition);
        border: 1px solid var(--gray-200);
        position: relative;
    }

    .station-item:hover {
        transform: translateY(-2px);
        box-shadow: var(--shadow-md);
    }

    .station-status {
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        padding: 0.25rem 1rem;
        font-size: 0.75rem;
        font-weight: 600;
        display: flex;
        align-items: center;
        gap: 0.375rem;
    }

    .station-status.available {
        background-color: var(--primary-light);
        color: var(--primary-dark);
    }

    .station-status.busy {
        background-color: #fef3c7;
        color: #92400e;
    }

    .station-status.offline {
        background-color: #fee2e2;
        color: #b91c1c;
    }

    .station-content {
        padding: 2.5rem 1rem 1rem;
    }

    .station-header {
        display: flex;
        justify-content: space-between;
        align-items: flex-start;
        margin-bottom: 0.5rem;
    }

    .station-name {
        margin: 0;
        font-size: 1rem;
        font-weight: 600;
        color: var(--gray-800);
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
    }

    .favorite-btn:hover {
        color: #f59e0b;
    }

    .favorite-btn.active {
        color: #f59e0b;
    }

    .station-address {
        display: flex;
        align-items: flex-start;
        gap: 0.5rem;
        margin-bottom: 0.75rem;
        font-size: 0.875rem;
        color: var(--gray-600);
        line-height: 1.4;
    }

    .station-address i {
        margin-top: 0.2rem;
        color: var(--gray-500);
    }

    .station-details {
        display: flex;
        flex-wrap: wrap;
        gap: 0.75rem;
        margin-bottom: 1rem;
    }

    .detail-item {
        display: flex;
        align-items: center;
        gap: 0.375rem;
        font-size: 0.75rem;
        color: var(--gray-700);
        background-color: var(--gray-100);
        padding: 0.25rem 0.5rem;
        border-radius: 0.25rem;
    }

    .detail-item i {
        color: var(--primary-color);
    }

    .station-actions {
        display: flex;
        gap: 0.5rem;
        padding: 0.75rem 1rem;
        background-color: var(--gray-50);
        border-top: 1px solid var(--gray-200);
    }

    .action-button {
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 0.5rem;
        padding: 0.5rem 0.75rem;
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

    .empty-state {
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        text-align: center;
        padding: 3rem 1rem;
        color: var(--gray-500);
    }

    .empty-icon {
        font-size: 3rem;
        margin-bottom: 1rem;
        color: var(--gray-400);
    }

    .empty-state h4 {
        margin: 0 0 0.5rem;
        font-size: 1.125rem;
        font-weight: 600;
        color: var(--gray-700);
    }

    .empty-state p {
        margin: 0 0 1.5rem;
        font-size: 0.875rem;
        color: var(--gray-500);
        max-width: 20rem;
    }

    .sidebar-footer {
        padding: 1rem;
        background-color: var(--white);
        border-top: 1px solid var(--gray-200);
        display: flex;
        flex-direction: column;
        gap: 0.75rem;
    }

    .footer-info {
        font-size: 0.75rem;
        color: var(--gray-500);
        text-align: center;
    }

    .load-more-btn {
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 0.5rem;
        padding: 0.625rem;
        background-color: var(--gray-100);
        border: 1px solid var(--gray-200);
        border-radius: var(--border-radius);
        font-size: 0.875rem;
        font-weight: 500;
        color: var(--gray-700);
        cursor: pointer;
        transition: var(--transition);
    }

    .load-more-btn:hover {
        background-color: var(--gray-200);
    }

    /* 모바일 대응 */
    @media (max-width: 768px) {
        .station-sidebar {
            width: 100%;
            height: 70%;
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
        
        .station-actions {
            padding: 0.75rem;
        }
        
        .action-button {
            padding: 0.625rem;
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

    .station-item {
        animation: slideIn 0.3s ease-out forwards;
    }

    .station-item:nth-child(1) { animation-delay: 0.05s; }
    .station-item:nth-child(2) { animation-delay: 0.1s; }
    .station-item:nth-child(3) { animation-delay: 0.15s; }
    .station-item:nth-child(4) { animation-delay: 0.2s; }
    .station-item:nth-child(5) { animation-delay: 0.25s; }
</style>