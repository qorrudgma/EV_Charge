<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원정보 수정 | EV충전소</title>
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
    <script src="${pageContext.request.contextPath}/js/jquery.js"></script>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/editInfo.css">
</head>
<body>
    <jsp:include page="/WEB-INF/views/header.jsp" />
    
    <div class="container">
        <div class="page-header">
            <h1 class="page-title">회원정보 수정</h1>
            <p class="page-subtitle">개인정보와 지역 설정을 업데이트하세요</p>
        </div>
        
        <div class="card fade-in">
            <div class="card-header">
                <h2><i class="fas fa-user-edit"></i> 내 정보 수정</h2>
            </div>
            <div class="card-body">
                <form action="updateMember" method="post" onsubmit="return validateForm();">
                    <input type="hidden" name="user_no" value="${memberDTO.user_no}" />
                    
                    <div class="form-section">
                        <h3 class="form-section-title"><i class="fas fa-id-card"></i> 기본 정보</h3>
                        
                        <div class="form-group">
                            <label for="user_id" class="form-label">아이디</label>
                            <input type="text" class="form-control" id="user_id" name="user_id" value="${memberDTO.user_id}" readonly>
                            <div class="form-hint">아이디는 변경할 수 없습니다.</div>
                        </div>
                        
                        <div class="form-group">
                            <label for="user_name" class="form-label">이름</label>
                            <input type="text" class="form-control" id="user_name" name="user_name" value="${memberDTO.user_name}">
                        </div>
                        
                        <div class="form-group">
                            <label for="user_email" class="form-label">이메일</label>
                            <input type="email" class="form-control" id="user_email" name="user_email" value="${memberDTO.user_email}">
                            <div class="form-hint">알림 및 공지사항을 받을 이메일 주소를 입력하세요.</div>
                        </div>
                    </div>
                    
                    <div class="form-section">
                        <h3 class="form-section-title"><i class="fas fa-lock"></i> 비밀번호 변경</h3>
                        
                        <div class="form-group">
                            <label for="user_password" class="form-label">새 비밀번호</label>
                            <input type="password" class="form-control" id="user_password" name="user_password" placeholder="새 비밀번호를 입력하세요">
                            <div class="password-strength">
                                <div id="password-strength-bar" class="password-strength-bar"></div>
                            </div>
                            <div class="form-hint">6자 이상의 안전한 비밀번호를 사용하세요.</div>
                        </div>
                        
                        <div class="form-group">
                            <label for="user_password_check" class="form-label">비밀번호 확인</label>
                            <input type="password" class="form-control" id="user_password_check" placeholder="비밀번호를 다시 입력하세요">
                            <div id="pw_match_msg" class="form-text"></div>
                        </div>
                    </div>
                    
                    <div class="form-section">
                        <h3 class="form-section-title"><i class="fas fa-map-marker-alt"></i> 지역 설정</h3>
                        <p class="form-hint" style="margin-bottom: 1rem;">주요 활동 지역을 설정하면 해당 지역의 충전소 정보를 우선적으로 제공받을 수 있습니다.</p>
                        
                        <div class="form-row">
                            <div class="form-group">
                                <label for="area_ctpy_nm" class="form-label">시/도</label>
                                <select id="area_ctpy_nm" name="area_ctpy_nm" class="form-control" onchange="updatearea_sgg_nm()">
                                    <option value="">선택하세요</option>
                                    <option value="서울특별시" ${memberDTO.area_ctpy_nm == '서울특별시' ? 'selected' : ''}>서울특별시</option>
                                    <option value="부산광역시" ${memberDTO.area_ctpy_nm == '부산광역시' ? 'selected' : ''}>부산광역시</option>
                                    <option value="대구광역시" ${memberDTO.area_ctpy_nm == '대구광역시' ? 'selected' : ''}>대구광역시</option>
                                    <option value="인천광역시" ${memberDTO.area_ctpy_nm == '인천광역시' ? 'selected' : ''}>인천광역시</option>
                                    <option value="광주광역시" ${memberDTO.area_ctpy_nm == '광주광역시' ? 'selected' : ''}>광주광역시</option>
                                    <option value="대전광역시" ${memberDTO.area_ctpy_nm == '대전광역시' ? 'selected' : ''}>대전광역시</option>
                                    <option value="울산광역시" ${memberDTO.area_ctpy_nm == '울산광역시' ? 'selected' : ''}>울산광역시</option>
                                    <option value="경기도" ${memberDTO.area_ctpy_nm == '경기도' ? 'selected' : ''}>경기도</option>
                                    <option value="강원도" ${memberDTO.area_ctpy_nm == '강원도' ? 'selected' : ''}>강원도</option>
                                    <option value="충청북도" ${memberDTO.area_ctpy_nm == '충청북도' ? 'selected' : ''}>충청북도</option>
                                    <option value="충청남도" ${memberDTO.area_ctpy_nm == '충청남도' ? 'selected' : ''}>충청남도</option>
                                    <option value="전라북도" ${memberDTO.area_ctpy_nm == '전라북도' ? 'selected' : ''}>전라북도</option>
                                    <option value="전라남도" ${memberDTO.area_ctpy_nm == '전라남도' ? 'selected' : ''}>전라남도</option>
                                    <option value="경상북도" ${memberDTO.area_ctpy_nm == '경상북도' ? 'selected' : ''}>경상북도</option>
                                    <option value="경상남도" ${memberDTO.area_ctpy_nm == '경상남도' ? 'selected' : ''}>경상남도</option>
                                    <option value="제주도" ${memberDTO.area_ctpy_nm == '제주도' ? 'selected' : ''}>제주도</option>
                                </select>
                            </div>
                            
                            <div class="form-group">
                                <label for="area_sgg_nm" class="form-label">군/구</label>
                                <select id="area_sgg_nm" name="area_sgg_nm" class="form-control" onchange="updatearea_emd_nm()">
                                    <option value="">선택하세요</option>
                                    <!-- 군/구 옵션이 여기에 동적으로 추가됩니다 -->
                                </select>
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label for="area_emd_nm" class="form-label">읍/면/동</label>
                            <select id="area_emd_nm" name="area_emd_nm" class="form-control">
                                <option value="">선택하세요</option>
                                <!-- 읍/면/동 옵션이 여기에 동적으로 추가됩니다 -->
                            </select>
                        </div>
                    </div>
                    
                    <div class="btn-group">
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-save"></i> 정보 저장하기
                        </button>
                        <a href="mypage" class="btn btn-secondary">
                            <i class="fas fa-arrow-left"></i> 마이페이지로 돌아가기
                        </a>
                    </div>
                </form>
            </div>
        </div>
    </div>
    
    <script>
        // 군/구 옵션 업데이트 함수
        function updatearea_sgg_nm() {
            const area_ctpy_nm = document.getElementById("area_ctpy_nm").value;
            const area_sgg_nmSelect = document.getElementById("area_sgg_nm");
            const area_emd_nmSelect = document.getElementById("area_emd_nm");

            // 군/구와 읍/면/동 초기화
            area_sgg_nmSelect.innerHTML = '<option value="">선택하세요</option>';
            area_emd_nmSelect.innerHTML = '<option value="">선택하세요</option>';

            if (area_ctpy_nm && regions[area_ctpy_nm]) {
                // 군/구 옵션 추가
                for (const area_sgg_nm in regions[area_ctpy_nm]) {
                    const option = document.createElement("option");
                    option.value = area_sgg_nm;
                    option.text = area_sgg_nm;
                    if (area_sgg_nm === "${memberDTO.area_sgg_nm}") {
                        option.selected = true;
                    }
                    area_sgg_nmSelect.appendChild(option);
                }
                
                // 기존 선택값이 있으면 읍/면/동도 업데이트
                if (area_sgg_nmSelect.value) {
                    updatearea_emd_nm();
                }
            }
        }

        // 읍/면/동 옵션 업데이트 함수
        function updatearea_emd_nm() {
            const area_ctpy_nm = document.getElementById("area_ctpy_nm").value;
            const area_sgg_nm = document.getElementById("area_sgg_nm").value;
            const area_emd_nmSelect = document.getElementById("area_emd_nm");

            // 읍/면/동 초기화
            area_emd_nmSelect.innerHTML = '<option value="">선택하세요</option>';

            if (area_ctpy_nm && area_sgg_nm && regions[area_ctpy_nm] && regions[area_ctpy_nm][area_sgg_nm]) {
                const area_emd_nms = regions[area_ctpy_nm][area_sgg_nm];
                area_emd_nms.forEach(area_emd_nm => {
                    const option = document.createElement("option");
                    option.value = area_emd_nm;
                    option.text = area_emd_nm;
                    if (area_emd_nm === "${memberDTO.area_emd_nm}") {
                        option.selected = true;
                    }
                    area_emd_nmSelect.appendChild(option);
                });
            }
        }
        
        // 페이지 로드 시 지역 정보 초기화
        document.addEventListener('DOMContentLoaded', function() {
            updatearea_sgg_nm();
        });
    </script>
    
    <script>
        $(document).ready(function () {
            // 비밀번호 일치 검사
            $("#user_password, #user_password_check").on("input", function () {
                var pw = $("#user_password").val();
                var pw_check = $("#user_password_check").val();
                var msg = $("#pw_match_msg");

                if (pw_check.length === 0) {
                    msg.text("").removeClass("text-success text-danger");
                    return;
                }

                if (pw === pw_check) {
                    msg.html('<i class="fas fa-check-circle"></i> 비밀번호가 일치합니다.').removeClass("text-danger").addClass("text-success");
                } else {
                    msg.html('<i class="fas fa-times-circle"></i> 비밀번호가 일치하지 않습니다.').removeClass("text-success").addClass("text-danger");
                }
            });
            
            // 비밀번호 강도 체크
            $("#user_password").on("input", function() {
                var password = $(this).val();
                var strengthBar = $("#password-strength-bar");
                
                // 비밀번호 강도 측정
                var strength = 0;
                
                // 길이 체크
                if (password.length >= 6) strength += 1;
                if (password.length >= 10) strength += 1;
                
                // 문자 조합 체크
                if (/[A-Z]/.test(password)) strength += 1;
                if (/[a-z]/.test(password)) strength += 1;
                if (/[0-9]/.test(password)) strength += 1;
                if (/[^A-Za-z0-9]/.test(password)) strength += 1;
                
                // 강도에 따른 시각적 표시
                strengthBar.removeClass("strength-weak strength-medium strength-strong");
                
                if (password.length === 0) {
                    strengthBar.css("width", "0");
                } else if (strength < 3) {
                    strengthBar.addClass("strength-weak");
                } else if (strength < 5) {
                    strengthBar.addClass("strength-medium");
                } else {
                    strengthBar.addClass("strength-strong");
                }
            });
        });
        
        function validateForm() {
            var password = document.getElementById("user_password").value.trim();
            var passwordCheck = document.getElementById("user_password_check").value.trim();
            var name = document.getElementById("user_name").value.trim();
            var email = document.getElementById("user_email").value.trim();
            var province = document.getElementById("area_ctpy_nm").value.trim();
            var city = document.getElementById("area_sgg_nm").value.trim();
            var town = document.getElementById("area_emd_nm").value.trim();
            
            if (name === '') {
                alert("이름을 입력해주세요.");
                document.getElementById("user_name").focus();
                return false;
            }

            if (password !== '') {
                if (password.length < 6) {
                    alert("비밀번호는 6자 이상 입력해야 합니다.");
                    document.getElementById("user_password").focus();
                    return false;
                }

                if (password !== passwordCheck) {
                    alert("비밀번호가 일치하지 않습니다.");
                    document.getElementById("user_password_check").focus();
                    return false;
                }
            }

            var emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailPattern.test(email)) {
                alert("올바른 이메일 형식을 입력하세요.");
                document.getElementById("user_email").focus();
                return false;
            }

            if (province === '' || city === '' || town === '') {
                alert("도/시/읍면동을 모두 선택해야 합니다.");
                if (province === '') {
                    document.getElementById("area_ctpy_nm").focus();
                } else if (city === '') {
                    document.getElementById("area_sgg_nm").focus();
                } else {
                    document.getElementById("area_emd_nm").focus();
                }
                return false;
            }

            return true;
        }
    </script>
</body>
</html>
