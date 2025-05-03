<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>마이페이지 | EV충전소</title>
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-color: #10b981;
            --primary-dark: #059669;
            --primary-light: #d1fae5;
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
            --red-500: #ef4444;
            --red-600: #dc2626;
        }
        
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }
        
        body {
            font-family: 'Noto Sans KR', sans-serif;
            color: var(--text-color);
            background-color: var(--gray-50);
            margin: 0;
            padding: 0;
            line-height: 1.6;
        }
        
        .container {
            max-width: 1200px;
            margin: 2rem auto;
            padding: 0 1.5rem;
        }
        
        .page-header {
            margin-bottom: 2rem;
        }
        
        .page-title {
            font-size: 1.75rem;
            font-weight: 700;
            color: var(--gray-800);
            margin-bottom: 0.5rem;
            display: flex;
            align-items: center;
        }
        
        .page-title i {
            margin-right: 0.75rem;
            color: var(--primary-color);
        }
        
        .page-description {
            color: var(--gray-600);
            font-size: 1rem;
        }
        
        .dashboard {
            display: grid;
            grid-template-columns: 1fr 2fr;
            gap: 2rem;
        }
        
        @media (max-width: 1024px) {
            .dashboard {
                grid-template-columns: 1fr;
            }
        }
        
        .profile-card {
            background-color: var(--white);
            border-radius: 1rem;
            box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.05), 0 8px 10px -6px rgba(0, 0, 0, 0.01);
            overflow: hidden;
            border: 1px solid var(--gray-200);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            height: fit-content;
        }
        
        .profile-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
        }
        
        .profile-header {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--primary-dark) 100%);
            color: var(--white);
            padding: 2.5rem 2rem;
            position: relative;
            text-align: center;
        }
        
        .profile-avatar {
            width: 120px;
            height: 120px;
            background-color: var(--white);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1.5rem;
            box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
            border: 4px solid rgba(255, 255, 255, 0.2);
            position: relative;
            overflow: hidden;
        }
        
        .profile-avatar i {
            font-size: 3.5rem;
            color: var(--primary-color);
        }
        
        .profile-avatar-edit {
            position: absolute;
            bottom: 0;
            left: 0;
            right: 0;
            background-color: rgba(0, 0, 0, 0.5);
            color: var(--white);
            font-size: 0.75rem;
            padding: 0.25rem;
            cursor: pointer;
            transition: all 0.2s ease;
        }
        
        .profile-avatar-edit:hover {
            background-color: rgba(0, 0, 0, 0.7);
        }
        
        .profile-name {
            font-size: 1.75rem;
            font-weight: 700;
            margin: 0;
            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        
        .profile-email {
            font-size: 1rem;
            color: rgba(255, 255, 255, 0.8);
            margin-top: 0.5rem;
        }
        
        .profile-stats {
            display: flex;
            justify-content: space-around;
            padding: 1.5rem;
            background-color: var(--white);
            border-bottom: 1px solid var(--gray-200);
        }
        
        .stat-item {
            text-align: center;
        }
        
        .stat-value {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--primary-color);
            margin-bottom: 0.25rem;
        }
        
        .stat-label {
            font-size: 0.875rem;
            color: var(--gray-600);
        }
        
        .profile-body {
            padding: 2rem;
        }
        
        .section-title {
            font-size: 1.25rem;
            font-weight: 600;
            color: var(--gray-800);
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
        }
        
        .section-title i {
            margin-right: 0.75rem;
            color: var(--primary-color);
        }
        
        .info-list {
            list-style: none;
            padding: 0;
        }
        
        .info-item {
            display: flex;
            padding: 1rem 0;
            border-bottom: 1px solid var(--gray-200);
        }
        
        .info-item:last-child {
            border-bottom: none;
        }
        
        .info-label {
            width: 40%;
            font-weight: 500;
            color: var(--gray-700);
            padding-right: 1rem;
        }
        
        .info-value {
            width: 60%;
            color: var(--gray-800);
        }
        
        .address-badges {
            display: flex;
            flex-wrap: wrap;
            gap: 0.5rem;
        }
        
        .address-badge {
            display: inline-flex;
            align-items: center;
            background-color: var(--primary-light);
            color: var(--primary-dark);
            padding: 0.375rem 0.75rem;
            border-radius: 0.375rem;
            font-size: 0.875rem;
            font-weight: 500;
        }
        
        .address-badge i {
            margin-right: 0.375rem;
            font-size: 0.75rem;
        }
        
        .btn_group {
            display: flex;
            gap: 1rem;
            margin-top: 2rem;
        }
        
        .btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 0.75rem 1.5rem;
            border-radius: 0.5rem;
            font-size: 0.875rem;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.2s ease;
            text-decoration: none;
            border: none;
            box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.1), 0 1px 2px 0 rgba(0, 0, 0, 0.06);
        }
        
        .btn i {
            margin-right: 0.5rem;
        }
        
        .btn-primary {
            background-color: var(--primary-color);
            color: var(--white);
        }
        
        .btn-primary:hover {
            background-color: var(--primary-dark);
            transform: translateY(-1px);
        }
        
        .btn-outline {
            background-color: var(--white);
            color: var(--primary-color);
            border: 1px solid var(--primary-color);
        }
        
        .btn-outline:hover {
            background-color: var(--primary-light);
            color: var(--primary-dark);
            transform: translateY(-1px);
        }
        
        .btn-danger {
            background-color: var(--white);
            color: var(--red-500);
            border: 1px solid var(--red-500);
        }
        
        .btn-danger:hover {
            background-color: var(--red-500);
            color: var(--white);
            transform: translateY(-1px);
        }
        
        .content-card {
            background-color: var(--white);
            border-radius: 1rem;
            box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.05), 0 8px 10px -6px rgba(0, 0, 0, 0.01);
            overflow: hidden;
            border: 1px solid var(--gray-200);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        
        .content-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
        }
        
        .card-header {
            padding: 1.5rem 2rem;
            border-bottom: 1px solid var(--gray-200);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .card-header h2 {
            margin: 0;
            font-size: 1.25rem;
            font-weight: 600;
            color: var(--gray-800);
            display: flex;
            align-items: center;
        }
        
        .card-header h2 i {
            margin-right: 0.75rem;
            color: var(--primary-color);
        }
        
        .card-body {
            padding: 2rem;
        }
        
        .tab-navigation {
            display: flex;
            border-bottom: 1px solid var(--gray-200);
            margin-bottom: 2rem;
            overflow-x: auto;
            scrollbar-width: none; /* Firefox */
        }
        
        .tab-navigation::-webkit-scrollbar {
            display: none; /* Chrome, Safari, Edge */
        }
        
        .tab-button {
            padding: 1rem 1.5rem;
            font-size: 0.875rem;
            font-weight: 500;
            color: var(--gray-600);
            background: none;
            border: none;
            cursor: pointer;
            transition: all 0.2s ease;
            border-bottom: 2px solid transparent;
            white-space: nowrap;
        }
        
        .tab-button.active {
            color: var(--primary-color);
            border-bottom-color: var(--primary-color);
        }
        
        .tab-button:hover:not(.active) {
            color: var(--gray-800);
            background-color: var(--gray-50);
        }
        
        .tab-content {
            display: none;
        }
        
        .tab-content.active {
            display: block;
        }
        
        .favorite-list {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 1.5rem;
        }
        
        .favorite-item {
            background-color: var(--white);
            border-radius: 0.75rem;
            border: 1px solid var(--gray-200);
            overflow: hidden;
            transition: all 0.2s ease;
        }
        
        .favorite-item:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
        }
        
        .favorite-image {
            height: 150px;
            background-color: var(--gray-100);
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--gray-400);
            font-size: 2rem;
        }
        
        .favorite-content {
            padding: 1rem;
        }
        
        .favorite-title {
            font-size: 1rem;
            font-weight: 600;
            color: var(--gray-800);
            margin-bottom: 0.5rem;
        }
        
        .favorite-info {
            font-size: 0.875rem;
            color: var(--gray-600);
            margin-bottom: 0.5rem;
        }
        
        .favorite-actions {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 1rem;
        }
        
        .favorite-status {
            display: inline-flex;
            align-items: center;
            padding: 0.25rem 0.5rem;
            border-radius: 9999px;
            font-size: 0.75rem;
            font-weight: 500;
        }
        
        .status-available {
            background-color: var(--primary-light);
            color: var(--primary-dark);
        }
        
        .status-busy {
            background-color: #FEE2E2;
            color: #DC2626;
        }
        
        .favorite-action {
            color: var(--gray-500);
            background: none;
            border: none;
            cursor: pointer;
            transition: all 0.2s ease;
            padding: 0.25rem;
        }
        
        .favorite-action:hover {
            color: var(--primary-color);
        }
        
        .activity-list {
            list-style: none;
            padding: 0;
        }
        
        .activity-item {
            display: flex;
            padding: 1rem 0;
            border-bottom: 1px solid var(--gray-200);
        }
        
        .activity-item:last-child {
            border-bottom: none;
        }
        
        .activity-icon {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background-color: var(--primary-light);
            color: var(--primary-color);
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 1rem;
            flex-shrink: 0;
        }
        
        .activity-content {
            flex: 1;
        }
        
        .activity-title {
            font-weight: 500;
            color: var(--gray-800);
            margin-bottom: 0.25rem;
        }
        
        .activity-time {
            font-size: 0.75rem;
            color: var(--gray-500);
        }
        
        .empty-state {
            text-align: center;
            padding: 3rem 1rem;
            color: var(--gray-500);
        }
        
        .empty-state i {
            font-size: 3rem;
            margin-bottom: 1rem;
        }
        
        .empty-state p {
            font-size: 1rem;
            margin-bottom: 1.5rem;
        }
        
        /* 애니메이션 효과 */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        .fade-in {
            animation: fadeIn 0.5s ease-out forwards;
        }
        
        .delay-100 {
            animation-delay: 0.1s;
        }
        
        .delay-200 {
            animation-delay: 0.2s;
        }
        
        .delay-300 {
            animation-delay: 0.3s;
        }
        
        /* 반응형 디자인 */
        @media (max-width: 768px) {
            .btn_group {
                flex-direction: column;
            }
            
            .btn {
                width: 100%;
            }
            
            .favorite-list {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/views/header.jsp" />
    
    <div class="container">
        <div class="page-header fade-in">
            <h1 class="page-title"><i class="fas fa-user-circle"></i> 마이페이지</h1>
            <p class="page-description">회원 정보 관리 및 즐겨찾기한 충전소를 확인하세요.</p>
        </div>
        
        <div class="dashboard">
            <!-- 프로필 카드 -->
            <div class="profile-card fade-in">
                <div class="profile-header">
                    <div class="profile-avatar">
                        <i class="fas fa-user"></i>
                        <div class="profile-avatar-edit">
                            <i class="fas fa-camera"></i> 변경
                        </div>
                    </div>
                    <h1 class="profile-name">${memberDTO.user_name}</h1>
                    <p class="profile-email">${memberDTO.user_email}</p>
                </div>
                
                <div class="profile-stats">
                    <div class="stat-item">
                        <div class="stat-value">12</div>
                        <div class="stat-label">즐겨찾기</div>
                    </div>
                    <div class="stat-item">
                        <div class="stat-value">8</div>
                        <div class="stat-label">이용 내역</div>
                    </div>
                    <div class="stat-item">
                        <div class="stat-value">3</div>
                        <div class="stat-label">리뷰</div>
                    </div>
                </div>
                
                <div class="profile-body">
                    <h2 class="section-title">
                        <i class="fas fa-id-card"></i> 회원 정보
                    </h2>
                    
                    <ul class="info-list">
                        <li class="info-item">
                            <div class="info-label">아이디</div>
                            <div class="info-value">${memberDTO.user_id}</div>
                        </li>
                        <li class="info-item">
                            <div class="info-label">이름</div>
                            <div class="info-value">${memberDTO.user_name}</div>
                        </li>
                        <li class="info-item">
                            <div class="info-label">이메일</div>
                            <div class="info-value">${memberDTO.user_email}</div>
                        </li>
                        <li class="info-item">
                            <div class="info-label">주소</div>
                            <div class="info-value">
                                <div class="address-badges">
                                    <span class="address-badge"><i class="fas fa-map-marker-alt"></i> ${memberDTO.area_ctpy_nm}</span>
                                    <span class="address-badge"><i class="fas fa-map-marker-alt"></i> ${memberDTO.area_sgg_nm}</span>
                                    <span class="address-badge"><i class="fas fa-map-marker-alt"></i> ${memberDTO.area_emd_nm}</span>
                                </div>
                            </div>
                        </li>
                        <li class="info-item">
                            <div class="info-label">가입일</div>
                            <div class="info-value">2023년 10월 15일</div>
                        </li>
                    </ul>
                    
                    <div class="btn_group">
                        <a href="editInfo" class="btn btn-primary">
                            <i class="fas fa-user-edit"></i> 회원정보 수정
                        </a>
                        <a href="changePassword" class="btn btn-outline">
                            <i class="fas fa-key"></i> 비밀번호 변경
                        </a>
                        <a href="logout" class="btn btn-danger">
                            <i class="fas fa-sign-out-alt"></i> 로그아웃
                        </a>
                    </div>
                </div>
            </div>
            
            <!-- 콘텐츠 영역 -->
            <div class="content-card fade-in delay-100">
                <div class="card-header">
                    <h2><i class="fas fa-th-large"></i> 내 활동</h2>
                </div>
                <div class="card-body">
                    <div class="tab-navigation">
                        <button class="tab-button active" data-tab="favorites">
                            <i class="fas fa-heart"></i> 즐겨찾기
                        </button>
                        <button class="tab-button" data-tab="history">
                            <i class="fas fa-history"></i> 이용 내역
                        </button>
                        <button class="tab-button" data-tab="reviews">
                            <i class="fas fa-star"></i> 내 리뷰
                        </button>
                        <button class="tab-button" data-tab="notifications">
                            <i class="fas fa-bell"></i> 알림
                        </button>
                    </div>
                    
                    <!-- 즐겨찾기 탭 -->
                    <div class="tab-content active" id="favorites">
                        <div class="favorite-list">
                            <!-- 즐겨찾기 항목 예시 -->
                            <div class="favorite-item">
                                <div class="favorite-image">
                                    <i class="fas fa-charging-station"></i>
                                </div>
                                <div class="favorite-content">
                                    <h3 class="favorite-title">강남구청 공영주차장</h3>
                                    <p class="favorite-info">
                                        <i class="fas fa-map-marker-alt"></i> 서울 강남구 학동로 426
                                    </p>
                                    <p class="favorite-info">
                                        <i class="fas fa-bolt"></i> DC콤보 100kW (2기)
                                    </p>
                                    <div class="favorite-actions">
                                        <span class="favorite-status status-available">사용가능</span>
                                        <button class="favorite-action" title="즐겨찾기 삭제">
                                            <i class="fas fa-trash-alt"></i>
                                        </button>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="favorite-item">
                                <div class="favorite-image">
                                    <i class="fas fa-charging-station"></i>
                                </div>
                                <div class="favorite-content">
                                    <h3 class="favorite-title">역삼동 공영주차장</h3>
                                    <p class="favorite-info">
                                        <i class="fas fa-map-marker-alt"></i> 서울 강남구 역삼동 12-7
                                    </p>
                                    <p class="favorite-info">
                                        <i class="fas fa-bolt"></i> DC콤보 50kW (1기)
                                    </p>
                                    <div class="favorite-actions">
                                        <span class="favorite-status status-busy">사용중</span>
                                        <button class="favorite-action" title="즐겨찾기 삭제">
                                            <i class="fas fa-trash-alt"></i>
                                        </button>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="favorite-item">
                                <div class="favorite-image">
                                    <i class="fas fa-charging-station"></i>
                                </div>
                                <div class="favorite-content">
                                    <h3 class="favorite-title">삼성동 현대백화점</h3>
                                    <p class="favorite-info">
                                        <i class="fas fa-map-marker-alt"></i> 서울 강남구 삼성동 159
                                    </p>
                                    <p class="favorite-info">
                                        <i class="fas fa-bolt"></i> DC콤보 100kW (4기)
                                    </p>
                                    <div class="favorite-actions">
                                        <span class="favorite-status status-available">사용가능</span>
                                        <button class="favorite-action" title="즐겨찾기 삭제">
                                            <i class="fas fa-trash-alt"></i>
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- 이용 내역 탭 -->
                    <div class="tab-content" id="history">
                        <ul class="activity-list">
                            <li class="activity-item">
                                <div class="activity-icon">
                                    <i class="fas fa-bolt"></i>
                                </div>
                                <div class="activity-content">
                                    <div class="activity-title">강남구청 공영주차장에서 충전</div>
                                    <div class="activity-info">35.2kWh 충전 · 17,600원</div>
                                    <div class="activity-time">2023년 10월 15일 14:30</div>
                                </div>
                            </li>
                            <li class="activity-item">
                                <div class="activity-icon">
                                    <i class="fas fa-bolt"></i>
                                </div>
                                <div class="activity-content">
                                    <div class="activity-title">삼성동 현대백화점에서 충전</div>
                                    <div class="activity-info">28.7kWh 충전 · 14,350원</div>
                                    <div class="activity-time">2023년 10월 10일 11:15</div>
                                </div>
                            </li>
                            <li class="activity-item">
                                <div class="activity-icon">
                                    <i class="fas fa-bolt"></i>
                                </div>
                                <div class="activity-content">
                                    <div class="activity-title">역삼동 공영주차장에서 충전</div>
                                    <div class="activity-info">42.1kWh 충전 · 21,050원</div>
                                    <div class="activity-time">2023년 10월 5일 09:45</div>
                                </div>
                            </li>
                        </ul>
                    </div>
                    
                    <!-- 내 리뷰 탭 -->
                    <div class="tab-content" id="reviews">
                        <div class="empty-state">
                            <i class="fas fa-star"></i>
                            <p>아직 작성한 리뷰가 없습니다.</p>
                            <a href="#" class="btn btn-outline">
                                <i class="fas fa-pen"></i> 리뷰 작성하기
                            </a>
                        </div>
                    </div>
                    
                    <!-- 알림 탭 -->
                    <div class="tab-content" id="notifications">
                        <ul class="activity-list">
                            <li class="activity-item">
                                <div class="activity-icon">
                                    <i class="fas fa-bell"></i>
                                </div>
                                <div class="activity-content">
                                    <div class="activity-title">즐겨찾기한 충전소 사용 가능</div>
                                    <div class="activity-info">강남구청 공영주차장 충전기 사용 가능 상태로 변경되었습니다.</div>
                                    <div class="activity-time">2023년 10월 16일 08:30</div>
                                </div>
                            </li>
                            <li class="activity-item">
                                <div class="activity-icon">
                                    <i class="fas fa-bell"></i>
                                </div>
                                <div class="activity-content">
                                    <div class="activity-title">시스템 점검 안내</div>
                                    <div class="activity-info">10월 20일 02:00~04:00 시스템 점검이 예정되어 있습니다.</div>
                                    <div class="activity-time">2023년 10월 15일 10:00</div>
                                </div>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script>
        // 탭 전환 기능
        document.addEventListener('DOMContentLoaded', function() {
            const tabButtons = document.querySelectorAll('.tab-button');
            const tabContents = document.querySelectorAll('.tab-content');
            
            tabButtons.forEach(button => {
                button.addEventListener('click', function() {
                    // 모든 탭 버튼에서 active 클래스 제거
                    tabButtons.forEach(btn => btn.classList.remove('active'));
                    // 클릭한 탭 버튼에 active 클래스 추가
                    this.classList.add('active');
                    
                    // 모든 탭 콘텐츠 숨기기
                    tabContents.forEach(content => content.classList.remove('active'));
                    // 선택한 탭 콘텐츠 표시
                    const tabId = this.getAttribute('data-tab');
                    document.getElementById(tabId).classList.add('active');
                });
            });
            
            // 즐겨찾기 삭제 버튼 이벤트
            const deleteButtons = document.querySelectorAll('.favorite-action');
            deleteButtons.forEach(button => {
                button.addEventListener('click', function() {
                    if(confirm('즐겨찾기에서 삭제하시겠습니까?')) {
                        // 여기에 삭제 로직 추가
                        const favoriteItem = this.closest('.favorite-item');
                        favoriteItem.style.opacity = '0';
                        setTimeout(() => {
                            favoriteItem.remove();
                        }, 300);
                    }
                });
            });
            
            // 프로필 이미지 변경 이벤트
            const profileAvatar = document.querySelector('.profile-avatar');
            profileAvatar.addEventListener('click', function() {
                // 여기에 프로필 이미지 변경 로직 추가
                alert('프로필 이미지 변경 기능은 준비 중입니다.');
            });
        });
    </script>
</body>
</html>
