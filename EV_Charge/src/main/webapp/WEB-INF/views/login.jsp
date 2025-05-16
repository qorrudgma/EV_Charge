<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그인 | EV충전소</title>
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/login.css">
</head>
<body>
    <div class="page-container">
        <jsp:include page="/WEB-INF/views/header.jsp" />
        
        <div class="content-container">
            <div class="login-container">
                <div class="login-header fade-in">
                    <div class="login-logo">
                        <div class="login-logo-icon">
                            <i class="fas fa-bolt"></i>
                        </div>
                    </div>
                    <h1 class="login-title">환영합니다</h1>
                    <p class="login-subtitle">계정에 로그인하여 서비스를 이용하세요</p>
                </div>
                
                <div class="login-card fade-in delay-100">
                    <div class="login-body">
                        <form method="post" action="login_yn">
                            <div class="form-group">
                                <label for="user_id" class="form-label">아이디</label>
                                <div class="input-group">
                                    <i class="fas fa-user input-icon"></i>
                                    <input type="text" id="user_id" name="user_id" class="form_control" placeholder="아이디를 입력하세요" required autocomplete="username">
                                </div>
                            </div>
                            
                            <div class="form-group">
                                <label for="user_password" class="form-label">비밀번호</label>
                                <div class="input-group">
                                    <i class="fas fa-lock input-icon"></i>
                                    <input type="password" id="user_password" name="user_password" class="form_control" placeholder="비밀번호를 입력하세요" required autocomplete="current-password">
                                </div>
                            </div>
                            
                            <div class="login-options">
                                <div class="remember-me">
                                    <input type="checkbox" id="remember" name="remember">
                                    <label for="remember">아이디 저장</label>
                                </div>
                                <a href="forgot-password" class="forgot-password">비밀번호 찾기</a>
                            </div>
                            
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-sign-in-alt"></i> 로그인
                            </button>
                        </form>
                        
                        <div class="divider">또는</div>
                        
                        <div class="social-login">
                            <a href="#" class="social-btn" title="Google 계정으로 로그인">
                                <i class="fab fa-google"></i>
                            </a>
                            <a href="#" class="social-btn" title="Kakao 계정으로 로그인">
                                <i class="fas fa-comment"></i>
                            </a>
                            <a href="#" class="social-btn" title="Naver 계정으로 로그인">
                                <i class="fas fa-n"></i>
                            </a>
                        </div>
                        
                        <div class="help-text fade-in delay-300">
                            <i class="fas fa-info-circle"></i>
                            <span>로그인에 문제가 있으신가요? <a href="support">고객센터</a>에 문의하세요.</span>
                        </div>
                    </div>
                </div>
                
                <div class="login-footer fade-in delay-200">
                    <p>아직 계정이 없으신가요? <a href="${pageContext.request.contextPath}/registe">회원가입</a></p>
                </div>
            </div>
        </div>
    </div>
    
    <script>
        // 아이디 저장 기능
        document.addEventListener('DOMContentLoaded', function() {
            // 저장된 쿠키값을 가져와서 아이디 입력칸에 넣어준다.
            var userId = getCookie("rememberedId");
            if(userId) {
                document.getElementById("user_id").value = userId;
                document.getElementById("remember").checked = true;
            }
            
            // 로그인 폼 제출 시 아이디 저장 처리
            document.querySelector("form").addEventListener("submit", function() {
                var rememberMe = document.getElementById("remember").checked;
                var userId = document.getElementById("user_id").value;
                
                if(rememberMe) {
                    // 7일간 쿠키 저장
                    setCookie("rememberedId", userId, 7);
                } else {
                    // 쿠키 삭제
                    deleteCookie("rememberedId");
                }
            });
        });
        
        // 쿠키 생성 함수
        function setCookie(cookieName, value, exdays) {
            var exdate = new Date();
            exdate.setDate(exdate.getDate() + exdays);
            var cookieValue = escape(value) + ((exdays == null) ? "" : "; expires=" + exdate.toGMTString());
            document.cookie = cookieName + "=" + cookieValue;
        }
        
        // 쿠키 삭제 함수
        function deleteCookie(cookieName) {
            var expireDate = new Date();
            expireDate.setDate(expireDate.getDate() - 1);
            document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString();
        }
        
        // 쿠키 가져오기 함수
        function getCookie(cookieName) {
            cookieName = cookieName + '=';
            var cookieData = document.cookie;
            var start = cookieData.indexOf(cookieName);
            var cookieValue = '';
            if(start != -1) {
                start += cookieName.length;
                var end = cookieData.indexOf(';', start);
                if(end == -1) end = cookieData.length;
                cookieValue = cookieData.substring(start, end);
            }
            return unescape(cookieValue);
        }
    </script>
</body>
</html>
