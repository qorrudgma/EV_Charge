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
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">
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

                <c:choose>
                    <c:when test="${not empty sessionScope.user}">
                        <a href="${pageContext.request.contextPath}/favorites" class="ev-nav-item">
                            <i class="fas fa-heart"></i>즐겨찾기
                        </a>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/login" class="ev-nav-item">
                            <i class="fas fa-heart"></i>즐겨찾기
                        </a>
                    </c:otherwise>
                </c:choose>

                <a href="${pageContext.request.contextPath}/notice" class="ev-nav-item">
                    <i class="fas fa-bell"></i>공지사항
                </a>

                <c:choose>
                    <c:when test="${not empty sessionScope.user}">
                        <a href="${pageContext.request.contextPath}/list" class="ev-nav-item">
                            <i class="fa-solid fa-comment"></i>게시판
                        </a>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/login" class="ev-nav-item">
                            <i class="fa-solid fa-comment"></i>게시판
                        </a>
                    </c:otherwise>
                </c:choose>
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
                            <option value="">시/도</option>
                        </select>
                    </div>
                    
                    <div class="form-group">
                        <label for="area_sgg_nm_mobile">군/구</label>
                        <select id="area_sgg_nm_mobile" name="area_sgg_nm" onchange="updatearea_emd_nm_mobile()">
                            <option value="">군/구</option>
                            <!-- 군/구 옵션이 여기에 동적으로 추가됩니다 -->
                        </select>
                    </div>
                    
                    <div class="form-group">
                        <label for="area_emd_nm_mobile">읍/면/동</label>
                        <select id="area_emd_nm_mobile" name="area_emd_nm">
                            <option value="">읍/면/동</option>
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

    $(document).ready(function(e) {
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
                area_ctpy_nm_mobileSelect.html('<option value="">시/도</option>');
                
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
                        $("#area_sgg_nm_mobile").html('<option value="">군/구</option>');
                        $("#area_emd_nm_mobile").html('<option value="">읍/면/동</option>');
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
    
    // 지역함수 - 데스크톱
    function updatearea_sgg_nm() {
        // 군/구 업데이트 로직 구현
        console.log("시/도 변경됨");
    }
    
    function updatearea_emd_nm() {
        // 읍/면/동 업데이트 로직 구현
        console.log("군/구 변경됨");
    }
    
    // 지역 선택 함수 - 모바일
    function updatearea_sgg_nm_mobile() {
        // 모바일용 군/구 업데이트 로직 구현
        console.log("모바일 시/도 변경됨");
    }
    
    function updatearea_emd_nm_mobile() {
        // 모바일용 읍/면/동 업데이트 로직 구현
        console.log("모바일 군/구 변경됨");
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