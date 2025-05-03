<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>EV충전소</title>
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
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
        
        body {
            font-family: 'Noto Sans KR', sans-serif;
            color: var(--text-color);
        }
        
        /* Header Styles */
        .ev-header {
            height: 7%;
            background-color: var(--white);
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
            position: sticky;
            top: 0;
            z-index: 1000;
            border-bottom: 1px solid var(--gray-200);
        }
        
        .ev-container {
            /* max-width: 1200px; */
            margin: 0 50px;
            /* margin-right: 10%; */
            padding: 0 1rem;
        }
        
        .ev-navbar {
            display: flex;
            align-items: center;
            justify-content: space-between;
            height: 64px;
        }

        #bars{
            color: var(--primary-color);
            font-size: 1.5rem;
            cursor: pointer;
            padding-right: 80px;
            /* margin-right: 30%; */
        }
        
        /* Logo Styles */
        .ev-brand {
            display: flex;
            align-items: center;
            color: var(--primary-color);
            text-decoration: none;
            font-weight: 700;
            font-size: 1.25rem;
            transition: color 0.2s;
        }
        
        .ev-brand:hover {
            color: var(--primary-dark);
        }
        
        .ev-brand i {
            font-size: 1.5rem;
            margin-right: 0.5rem;
        }
        
        /* Navigation Styles */
        .ev-nav {
            display: flex;
            align-items: center;
        }
        
        .ev-nav-item {
            display: flex;
            align-items: center;
            padding: 0.5rem 0.75rem;
            color: var(--gray-700);
            text-decoration: none;
            font-size: 0.875rem;
            font-weight: 500;
            border-radius: 0.375rem;
            transition: all 0.2s;
        }
        
        .ev-nav-item:hover {
            color: var(--primary-color);
            background-color: var(--gray-50);
        }
        
        .ev-nav-item i {
            margin-right: 0.5rem;
            font-size: 0.875rem;
        }
        
        /* Search Form Styles */
        .ev-search-form {
            position: relative;
            margin-right: 1rem;
        }
        
        .ev-search-input {
            padding: 0.5rem 0.75rem 0.5rem 2.25rem;
            border: 1px solid var(--gray-300);
            border-radius: 0.375rem;
            background-color: var(--gray-50);
            font-size: 0.875rem;
            transition: all 0.2s;
            width: 200px;
        }
        
        .ev-search-input:focus {
            outline: none;
            border-color: var(--primary-color);
            background-color: var(--white);
            box-shadow: 0 0 0 3px rgba(16, 185, 129, 0.1);
        }
        
        .ev-search-icon {
            position: absolute;
            left: 0.75rem;
            top: 50%;
            transform: translateY(-50%);
            color: var(--gray-400);
            font-size: 0.875rem;
        }
        
        .ev-search-button {
            background-color: var(--primary-color);
            color: var(--white);
            border: none;
            padding: 0.5rem 1rem;
            border-radius: 0.375rem;
            font-size: 0.875rem;
            font-weight: 500;
            cursor: pointer;
            transition: background-color 0.2s;
        }
        
        .ev-search-button:hover {
            background-color: var(--primary-dark);
        }
        
        /* User Section Styles */
        .ev-user-section {
            display: flex;
            align-items: center;
            padding-right: 100px;
        }
        
        .ev-welcome-text {
            margin-right: 1rem;
            font-size: 0.875rem;
            color: var(--gray-700);
        }
        
        .ev-welcome-name {
            color: var(--primary-color);
            font-weight: 500;
        }
        
        /* Button Styles */
        .ev-btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 0.5rem 1rem;
            border-radius: 0.375rem;
            font-size: 0.875rem;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.2s;
            text-decoration: none;
        }
        
        .ev-btn-ghost {
            background-color: var(--gray-200);
            color: var(--gray-700);
        }
        
        .ev-btn-ghost:hover {
            background-color: var(--gray-300);
            color: var(--gray-900);
        }
        
        .ev-btn-primary {
            background-color: var(--primary-color);
            color: var(--white);
            border: 1px solid transparent;
        }
        
        .ev-btn-primary:hover {
            background-color: var(--primary-dark);
        }
        
        .ev-btn-outline {
            background-color: transparent;
            color: var(--gray-700);
            border: 1px solid var(--gray-300);
        }
        
        .ev-btn-outline:hover {
            border-color: var(--gray-400);
            background-color: var(--gray-50);
        }
        
        .ev-btn-danger {
            background-color: var(--red-500);
            color: var(--white);
            border: 1px solid transparent;
        }
        
        .ev-btn-danger:hover {
            background-color: var(--red-600);
        }
        
        .ev-btn-sm {
            padding: 0.375rem 0.75rem;
            font-size: 0.75rem;
        }
        
        /* Mobile Menu Styles */
        .ev-mobile-menu-button {
            display: none;
            background: none;
            border: none;
            color: var(--gray-700);
            font-size: 1.25rem;
            cursor: pointer;
            padding: 0.5rem;
        }
        
        .ev-mobile-menu {
            display: none;
            padding: 1rem;
            border-top: 1px solid var(--gray-200);
            background-color: var(--white);
        }
        
        .ev-mobile-nav {
            display: flex;
            flex-direction: column;
            margin-bottom: 1rem;
        }
        
        .ev-mobile-search {
            margin-bottom: 1rem;
        }
        
        /* Avatar Styles */
        .ev-avatar {
            width: 2rem;
            height: 2rem;
            border-radius: 9999px;
            background-color: var(--primary-light);
            color: var(--primary-color);
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 600;
            font-size: 0.875rem;
            overflow: hidden;
        }
        
        .ev-avatar img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        
        /* Dropdown Styles */
        .ev-dropdown {
            position: relative;
        }
        
        .ev-dropdown-content {
            display: none;
            position: absolute;
            right: 0;
            top: calc(100% + 0.5rem);
            background-color: var(--white);
            border-radius: 0.375rem;
            box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
            min-width: 14rem;
            z-index: 1000;
            border: 1px solid var(--gray-200);
            overflow: hidden;
        }
        
        .ev-dropdown-header {
            padding: 0.75rem 1rem;
            border-bottom: 1px solid var(--gray-200);
        }
        
        .ev-dropdown-item {
            display: flex;
            align-items: center;
            padding: 0.75rem 1rem;
            color: var(--gray-700);
            text-decoration: none;
            transition: background-color 0.2s;
        }
        
        .ev-dropdown-item:hover {
            background-color: var(--gray-50);
        }
        
        .ev-dropdown-item i {
            margin-right: 0.5rem;
            font-size: 0.875rem;
        }
        
        .ev-dropdown-item.danger {
            color: var(--red-500);
        }
        
        .ev-dropdown-item.danger:hover {
            background-color: rgba(239, 68, 68, 0.05);
        }
        
        .ev-dropdown.active .ev-dropdown-content {
            display: block;
        }
        
        /* Region Selection Styles - 헤더에 맞게 스타일링 */
        .region-selection-section {
            display: flex;
            align-items: center;
            margin-right: 1rem;
        }
        
        #sidebar {
            background: none;
            box-shadow: none;
            padding: 0;
            width: auto;
            display: flex;
            align-items: center;
        }
        
        #sidebar h1 {
            display: none; /* 헤더에서는 제목 숨김 */
        }
        
        #address-form {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            margin: 0;
        }
        
        .form-group {
            position: relative;
            margin: 0;
        }
        
        #address-form label {
            position: absolute;
            width: 1px;
            height: 1px;
            padding: 0;
            margin: -1px;
            overflow: hidden;
            clip: rect(0, 0, 0, 0);
            white-space: nowrap;
            border-width: 0;
        }
        
        #address-form select {
            padding: 0.5rem 2rem 0.5rem 0.75rem;
            border: 1px solid var(--gray-300);
            border-radius: 0.375rem;
            background-color: var(--gray-50);
            font-size: 0.75rem;
            color: var(--gray-700);
            appearance: none;
            background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' fill='none' viewBox='0 0 20 20'%3e%3cpath stroke='%236b7280' stroke-linecap='round' stroke-linejoin='round' stroke-width='1.5' d='M6 8l4 4 4-4'/%3e%3c/svg%3e");
            background-position: right 0.5rem center;
            background-repeat: no-repeat;
            background-size: 1em 1em;
            min-width: 90px;
            max-width: 120px;
            transition: all 0.2s;
        }
        
        #address-form select:focus {
            outline: none;
            border-color: var(--primary-color);
            background-color: var(--white);
            box-shadow: 0 0 0 3px rgba(16, 185, 129, 0.1);
        }
        
        #search_btn {
            background-color: var(--primary-color);
            color: var(--white);
            border: none;
            padding: 0.5rem 0.75rem;
            border-radius: 0.375rem;
            font-size: 0.75rem;
            font-weight: 500;
            cursor: pointer;
            transition: background-color 0.2s;
            display: flex;
            align-items: center;
            white-space: nowrap;
        }
        
        #search_btn:hover {
            background-color: var(--primary-dark);
        }
        
        #search_btn::before {
            content: '\f002';
            font-family: 'Font Awesome 5 Free';
            font-weight: 900;
            margin-right: 0.25rem;
            font-size: 0.75rem;
        }
        
        /* Responsive Styles */
        @media (max-width: 992px) {
            .region-selection-section {
                display: none; /* 중간 크기 화면에서 숨김 */
            }
            
            .ev-mobile-region-selection {
                display: flex;
                flex-direction: column;
                margin-bottom: 1rem;
                padding-top: 1rem;
                border-top: 1px solid var(--gray-200);
            }
            
            .ev-mobile-region-selection #sidebar {
                width: 100%;
            }
            
            .ev-mobile-region-selection #address-form {
                flex-wrap: wrap;
                width: 100%;
            }
            
            .ev-mobile-region-selection .form-group {
                flex: 1 0 100%;
                margin-bottom: 0.5rem;
            }
            
            .ev-mobile-region-selection #address-form select {
                width: 100%;
                max-width: none;
            }
            
            .ev-mobile-region-selection .btn-group {
                width: 100%;
            }
            
            .ev-mobile-region-selection #search_btn {
                width: 100%;
                justify-content: center;
            }
        }
        
        @media (max-width: 768px) {
            .ev-nav, .ev-search-form, .ev-welcome-text {
                display: none;
            }
            
            .ev-mobile-menu-button {
                display: block;
            }
            
            .ev-mobile-menu.active {
                display: block;
            }
            
            .ev-search-input {
                width: 100%;
            }
            
            .ev-mobile-search {
                display: flex;
            }
            
            .ev-mobile-search .ev-search-form {
                display: block;
                flex: 1;
                margin-right: 0.5rem;
            }
        }
    </style>
</head>
<body>

<!-- EV충전소 헤더 -->
<header class="ev-header">
    <div class="ev-container">
        <div class="ev-navbar">
            <i class="fa-solid fa-bars" id="bars"></i>
            <!-- 로고 및 브랜드 -->
            <a href="${pageContext.request.contextPath}/main" class="ev-brand">
                <i class="fas fa-charging-station"></i>
                <span>EV충전소</span>
            </a>
            
            <!-- 데스크톱 네비게이션 -->
            <nav class="ev-nav">
                <a href="${pageContext.request.contextPath}/main" class="ev-nav-item">
                    <i class="fas fa-home"></i>홈
                </a>
                <a href="${pageContext.request.contextPath}/favorites" class="ev-nav-item">
                    <i class="fas fa-heart"></i>즐겨찾기
                </a>
                <a href="${pageContext.request.contextPath}/notice" class="ev-nav-item">
                    <i class="fas fa-bell"></i>공지사항
                </a>
            </nav>
            
            <!-- 검색, 로그인, 프로필 섹션 -->
            <div class="ev-user-section">
                <!-- 지역 선택 섹션 -->
                <div class="region-selection-section">
                    <div id="sidebar">
                        <form id="address-form">
                            <div class="form-group">
                                <label for="area_ctpy_nm">시/도</label>
                                <select id="area_ctpy_nm" name="area_ctpy_nm" onchange="updatearea_sgg_nm()">
                                    <option value="">시/도</option>
<!--                                    <option value="서울특별시">서울특별시</option>-->
<!--                                    <option value="부산광역시">부산광역시</option>-->
<!--                                    <option value="대구광역시">대구광역시</option>-->
<!--                                    <option value="인천광역시">인천광역시</option>-->
<!--                                    <option value="광주광역시">광주광역시</option>-->
<!--                                    <option value="대전광역시">대전광역시</option>-->
<!--                                    <option value="울산광역시">울산광역시</option>-->
<!--                                    <option value="경기도">경기도</option>-->
<!--                                    <option value="강원도">강원도</option>-->
<!--                                    <option value="충청북도">충청북도</option>-->
<!--                                    <option value="충청남도">충청남도</option>-->
<!--                                    <option value="전라북도">전라북도</option>-->
<!--                                    <option value="전라남도">전라남도</option>-->
<!--                                    <option value="경상북도">경상북도</option>-->
<!--                                    <option value="경상남도">경상남도</option>-->
<!--                                    <option value="제주도">제주도</option>-->
<!--                                    <option value="세종특별자치시">세종특별자치시</option>-->
                                </select>
                            </div>
                            
                            <div class="form-group">
                                <label for="area_sgg_nm">군/구</label>
                                <select id="area_sgg_nm" name="area_sgg_nm" onchange="updatearea_emd_nm()">
                                    <option value="">군/구</option>
                                    <!-- 군/구 옵션이 여기에 동적으로 추가됩니다 -->
                                </select>
                            </div>
                            
                            <div class="form-group">
                                <label for="area_emd_nm">읍/면/동</label>
                                <select id="area_emd_nm" name="area_emd_nm">
                                    <option value="">읍/면/동</option>
                                    <!-- 읍/면/동 옵션이 여기에 동적으로 추가됩니다 -->
                                </select>
                            </div>
                            
                            <div class="btn-group">
                                <button type="button" id="search_btn">검색</button>
                            </div>
                        </form>
                    </div>
                </div>
                
                <!-- 사용자 인증 -->
                <c:choose>
                    <c:when test="${not empty sessionScope.user}">
                        <span class="ev-welcome-text">
                            <span class="ev-welcome-name">${sessionScope.user.user_name}</span>님 환영합니다
                        </span>
                        <div class="ev-dropdown" id="userDropdown">
                            <button class="ev-btn ev-btn-ghost ev-btn-sm" onclick="toggleDropdown()">
                                <div class="ev-avatar">
                                    <!-- 이미지 제거됨 -->
                                </div>
                            </button>
                            <div class="ev-dropdown-content">
                                <div class="ev-dropdown-header">
                                    <div class="font-medium">${sessionScope.user.user_name}</div>
                                </div>
                                <a href="${pageContext.request.contextPath}/mypage" class="ev-dropdown-item">
                                    <i class="fas fa-user"></i>
                                    <span>마이페이지</span>
                                </a>
                                <a href="${pageContext.request.contextPath}/logout" class="ev-dropdown-item danger">
                                    <i class="fas fa-sign-out-alt"></i>
                                    <span>로그아웃</span>
                                </a>
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="ev-auth-buttons">
                            <a href="${pageContext.request.contextPath}/login" class="ev-btn ev-btn-ghost ev-btn-sm">로그인</a>
                            <a href="${pageContext.request.contextPath}/registe" class="ev-btn ev-btn-primary ev-btn-sm">회원가입</a>
                        </div>
                    </c:otherwise>
                </c:choose>
                
                <!-- 모바일 메뉴 버튼 -->
                <button class="ev-mobile-menu-button" id="mobileMenuButton">
                    <i class="fas fa-bars"></i>
                </button>
            </div>
        </div>
    </div>
    
    <!-- 모바일 메뉴 -->
    <div class="ev-mobile-menu" id="mobileMenu">
        <nav class="ev-mobile-nav">
            <a href="${pageContext.request.contextPath}/main" class="ev-nav-item">
                <i class="fas fa-home"></i>홈
            </a>
            <a href="${pageContext.request.contextPath}/favorites" class="ev-nav-item">
                <i class="fas fa-heart"></i>즐겨찾기
            </a>
            <a href="${pageContext.request.contextPath}/notice" class="ev-nav-item">
                <i class="fas fa-bell"></i>공지사항
            </a>
        </nav>
        
        <!-- 모바일 검색 -->
        <div class="ev-mobile-search">
            <form action="${pageContext.request.contextPath}/evse" method="get" class="d-flex">
                <div class="ev-search-form">
                    <i class="fas fa-search ev-search-icon"></i>
                    <input type="search" name="query" placeholder="충전소 검색" class="ev-search-input">
                </div>
                <button type="submit" class="ev-search-button">검색</button>
            </form>
        </div>
        
        <!-- 모바일 지역 선택 -->
        <div class="ev-mobile-region-selection">
            <div id="sidebar-mobile">
                <form id="address-form-mobile">
                    <div class="form-group">
                        <label for="area_ctpy_nm_mobile">시/도</label>
                        <select id="area_ctpy_nm_mobile" name="area_ctpy_nm" onchange="updatearea_sgg_nm_mobile()">
                            <option value="">시/도 선택</option>
<!--                            <option value="서울특별시">서울특별시</option>-->
<!--                            <option value="부산광역시">부산광역시</option>-->
<!--                            <option value="대구광역시">대구광역시</option>-->
<!--                            <option value="인천광역시">인천광역시</option>-->
<!--                            <option value="광주광역시">광주광역시</option>-->
<!--                            <option value="대전광역시">대전광역시</option>-->
<!--                            <option value="울산광역시">울산광역시</option>-->
<!--                            <option value="경기도">경기도</option>-->
<!--                            <option value="강원도">강원도</option>-->
<!--                            <option value="충청북도">충청북도</option>-->
<!--                            <option value="충청남도">충청남도</option>-->
<!--                            <option value="전라북도">전라북도</option>-->
<!--                            <option value="전라남도">전라남도</option>-->
<!--                            <option value="경상북도">경상북도</option>-->
<!--                            <option value="경상남도">경상남도</option>-->
<!--                            <option value="제주도">제주도</option>-->
<!--                            <option value="세종특별자치시">세종특별자치시</option>-->
                        </select>
                    </div>
                    
                    <div class="form-group">
                        <label for="area_sgg_nm_mobile">군/구</label>
                        <select id="area_sgg_nm_mobile" name="area_sgg_nm" onchange="updatearea_emd_nm_mobile()">
                            <option value="">군/구 선택</option>
                            <!-- 군/구 옵션이 여기에 동적으로 추가됩니다 -->
                        </select>
                    </div>
                    
                    <div class="form-group">
                        <label for="area_emd_nm_mobile">읍/면/동</label>
                        <select id="area_emd_nm_mobile" name="area_emd_nm">
                            <option value="">읍/면/동 선택</option>
                            <!-- 읍/면/동 옵션이 여기에 동적으로 추가됩니다 -->
                        </select>
                    </div>
                    
                    <div class="btn-group">
                        <button type="button" id="search_btn_mobile">충전소 검색</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</header>

<!-- Bootstrap JS 및 Popper.js -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<!-- 자바스크립트 -->
<script>
	// ------------------------------------------------------------------
	// 페이지 로드 시 시/도 데이터 가져오기
	// $(document).ready(function() {
	//     // 서버에서 시/도 데이터 가져오기
	//     $.ajax({
	//         type: "get",
	//         url: "/provinces_list", // ProvincesController에 정의된 엔드포인트
	//         success: function(data) {
    //             console.log("시/도 데이터 가져왔음");
	//             var area_ctpy_nmSelect = $("#area_ctpy_nm");
	//             // 기본 옵션
	//             area_ctpy_nmSelect.html('<option value="">시/도</option>');
	            
	//             // 받아온 데이터로 옵션 추가 (코드를 value로, 이름을 텍스트로)
	//             $.each(data, function(index, province) {
	//                 area_ctpy_nmSelect.append($('<option>', {
	//                     value: province.provinces_code, // 시/도 코드를 value로
	//                     text: province.provinces_name   // 시/도 이름을 텍스트로
	//                 }));
	//             });
	            
	//             // 모바일 버전도 동일하게 적용
	//             var area_ctpy_nm_mobileSelect = $("#area_ctpy_nm_mobile");
	//             area_ctpy_nm_mobileSelect.html('<option value="">시/도 선택</option>');
	            
	//             $.each(data, function(index, province) {
	//                 area_ctpy_nm_mobileSelect.append($('<option>', {
	//                     value: province.provinces_code,
	//                     text: province.provinces_name
	//                 }));
	//             });
	//         },
	//         error: function(xhr, status, error) {
	//             console.error("시/도 데이터를 가져오는 중 오류가 발생했습니다:", error);
	//         }
	//     });
	// });
    $(document).ready(function() {
    // 서버에서 시/도 데이터 가져오기
    $.ajax({
        type: "get",
        url: "/provinces_list", // ProvincesController에 정의된 엔드포인트
        success: function(data) {
            console.log("시/도 데이터 가져왔음");
            var area_ctpy_nmSelect = $("#area_ctpy_nm");
            // 기본 옵션
            area_ctpy_nmSelect.html('<option value="">시/도</option>');
            
            // 받아온 데이터로 옵션 추가 (코드를 value로, 이름을 텍스트로)
            $.each(data, function(index, province) {
                area_ctpy_nmSelect.append($('<option>', {
                    value: province.provinces_code, // 시/도 코드를 value로
                    text: province.provinces_name   // 시/도 이름을 텍스트로
                }));
            });
            
            // 시/도 선택 시 이벤트 리스너 추가
            area_ctpy_nmSelect.on("change", function() {
                var selectedProvinceCode = $(this).val();
                if(selectedProvinceCode) {
                    // 선택된 시/도 코드가 있으면 함수 실행
                    updatearea_sgg_nm(selectedProvinceCode);
                } else {
                    // 선택이 취소되면 시/군/구 드롭다운 초기화
                    $("#area_sgg_nm").html('<option value="">군/구</option>');
                    $("#area_emd_nm").html('<option value="">읍/면/동</option>');
                }
            });
            
            // 모바일 버전도 동일하게 적용
            var area_ctpy_nm_mobileSelect = $("#area_ctpy_nm_mobile");
            area_ctpy_nm_mobileSelect.html('<option value="">시/도 선택</option>');
            
            $.each(data, function(index, province) {
                area_ctpy_nm_mobileSelect.append($('<option>', {
                    value: province.provinces_code,
                    text: province.provinces_name
                }));
            });
            
            // 모바일 버전 시/도 선택 시 이벤트 리스너 추가
            area_ctpy_nm_mobileSelect.on("change", function() {
                var selectedProvinceCode = $(this).val();
                if(selectedProvinceCode) {
                    // 선택된 시/도 코드가 있으면 함수 실행
                    updatearea_sgg_nm_mobile(selectedProvinceCode);
                } else {
                    // 선택이 취소되면 시/군/구 드롭다운 초기화
                    $("#area_sgg_nm_mobile").html('<option value="">군/구 선택</option>');
                    $("#area_emd_nm_mobile").html('<option value="">읍/면/동 선택</option>');
                }
            });
        },
        error: function(xhr, status, error) {
            console.error("시/도 데이터를 가져오는 중 오류가 발생했습니다:", error);
        }
    });
// });

// 시/도 선택 시 해당 시/군/구 데이터 가져오기
function updatearea_sgg_nm(provinces_code) {
    console.log("시/도 선택해서 시/군/구 가야한다.(1)");
    var area_sgg_nmSelect = $("#area_sgg_nm");
    var area_emd_nmSelect = $("#area_emd_nm");

    // 시/군/구와 읍/면/동 초기화
    area_sgg_nmSelect.html('<option value="">군/구</option>');
    area_emd_nmSelect.html('<option value="">읍/면/동</option>');

    if (!provinces_code) {
        return;
    }

    // 서버에서 시/군/구 데이터 가져오기
    $.ajax({
        type: "get",
        url: "/districts_list",
        data: { provinces_code: provinces_code },
        success: function(data) {
            console.log("시/도 선택해서 시/군/구 가야한다.(2)");
            // 받아온 데이터로 옵션 추가 (코드를 value로, 이름을 텍스트로)
            $.each(data, function(index, district) {
                // "미분류" 항목은 제외
                if (district.districts_name !== "미분류") {
                    area_sgg_nmSelect.append($('<option>', {
                        value: district.districts_code, // 시/군/구 코드를 value로
                        text: district.districts_name   // 시/군/구 이름을 텍스트로
                    }));
                }
            });
        },
        error: function(xhr, status, error) {
            console.error("시/군/구 데이터를 가져오는 중 오류가 발생했습니다:", error);
        }
    });
}
});

// 모바일 버전 함수도 동일하게 구현
function updatearea_sgg_nm_mobile(provinces_code) {
    // 위와 유사한 구현...
}


	// ------------------------------------------------------------------
	
    // 모바일 메뉴 토글
    const mobileMenuButton = document.getElementById('mobileMenuButton');
    const mobileMenu = document.getElementById('mobileMenu');
    
    mobileMenuButton.addEventListener('click', function() {
        mobileMenu.classList.toggle('active');
        
        // 아이콘 변경 (메뉴/닫기)
        const icon = mobileMenuButton.querySelector('i');
        if (mobileMenu.classList.contains('active')) {
            icon.classList.remove('fa-bars');
            icon.classList.add('fa-times');
        } else {
            icon.classList.remove('fa-times');
            icon.classList.add('fa-bars');
        }
    });
    
    // 사용자 드롭다운 토글
    function toggleDropdown() {
        const dropdown = document.getElementById('userDropdown');
        dropdown.classList.toggle('active');
    }
    
    // 드롭다운 외부 클릭 시 닫기
    document.addEventListener('click', function(event) {
        const dropdown = document.getElementById('userDropdown');
        if (dropdown) {
            const isClickInside = dropdown.contains(event.target);
            
            if (!isClickInside && dropdown.classList.contains('active')) {
                dropdown.classList.remove('active');
            }
        }
    });
    
    // 지역 선택 함수 - 데스크톱
    function updatearea_sgg_nm() {
        // 군/구 업데이트 로직 구현
        console.log("시/도 선택 변경됨");
    }
    
    function updatearea_emd_nm() {
        // 읍/면/동 업데이트 로직 구현
        console.log("군/구 선택 변경됨");
    }
    
    // 지역 선택 함수 - 모바일
    function updatearea_sgg_nm_mobile() {
        // 모바일용 군/구 업데이트 로직 구현
        console.log("모바일 시/도 선택 변경됨");
    }
    
    function updatearea_emd_nm_mobile() {
        // 모바일용 읍/면/동 업데이트 로직 구현
        console.log("모바일 군/구 선택 변경됨");
    }
    
    // 검색 버튼 이벤트
    document.getElementById('search_btn').addEventListener('click', function() {
       
        // 검색 로직 구현
        console.log("데스크톱 검색 버튼 클릭됨");
        
        const area_ctpy_nm = document.getElementById('area_ctpy_nm').value;
        const area_sgg_nm = document.getElementById('area_sgg_nm').value;
        // const area_emd_nm = document.getElementById('area_emd_nm').value;
        
        if (!area_ctpy_nm || !area_sgg_nm) {
            alert("시/도와 군/구를 선택해주세요.");
            return;
        }
        
        // 여기에 검색 API 호출 로직 추가
        // searchChargingStations(area_ctpy_nm, area_sgg_nm, area_emd_nm);
        searchChargingStations(area_ctpy_nm, area_sgg_nm);
    });
    
    document.getElementById('search_btn_mobile').addEventListener('click', function() {
        // 모바일 검색 로직 구현
        console.log("모바일 검색 버튼 클릭됨");
        
        const area_ctpy_nm = document.getElementById('area_ctpy_nm_mobile').value;
        const area_sgg_nm = document.getElementById('area_sgg_nm_mobile').value;
        const area_emd_nm = document.getElementById('area_emd_nm_mobile').value;
        
        if (!area_ctpy_nm || !area_sgg_nm) {
            alert("시/도와 군/구를 선택해주세요.");
            return;
        }
        
        // 여기에 검색 API 호출 로직 추가
        searchChargingStations(area_ctpy_nm, area_sgg_nm, area_emd_nm);
        
        // 모바일 메뉴 닫기
        mobileMenu.classList.remove('active');
        mobileMenuButton.querySelector('i').classList.remove('fa-times');
        mobileMenuButton.querySelector('i').classList.add('fa-bars');
    });
    
    // function searchChargingStations(area_ctpy_nm, area_sgg_nm, area_emd_nm) {
    function searchChargingStations(area_ctpy_nm, area_sgg_nm) {
        // 충전소 검색 API 호출 함수
        console.log(`지역 검색: ${area_ctpy_nm} ${area_sgg_nm}`);
        
        // 여기에 실제 API 호출 코드 추가
        // 예: fetch('/findStationsNear', {...})
    }
</script>

</body>
</html>