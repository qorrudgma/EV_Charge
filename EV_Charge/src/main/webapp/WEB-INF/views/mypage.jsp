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
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/mypage.css">
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
        $(document).ready(function () {
            $.ajax({
                
            });
        });

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
