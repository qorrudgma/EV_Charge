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
            min-height: 100vh;
        }
        
        .page-container {
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }
        
        .content-container {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 2rem 1rem;
        }
        
        .login-container {
            width: 100%;
            max-width: 460px;
            margin: 0 auto;
        }
        
        .login-header {
            text-align: center;
            margin-bottom: 2rem;
        }
        
        .login-logo {
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 1.5rem;
        }
        
        .login-logo-icon {
            width: 60px;
            height: 60px;
            background-color: var(--primary-color);
            border-radius: 16px;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 10px 15px -3px rgba(16, 185, 129, 0.2), 0 4px 6px -2px rgba(16, 185, 129, 0.1);
        }
        
        .login-logo-icon i {
            font-size: 30px;
            color: var(--white);
        }
        
        .login-title {
            font-size: 1.75rem;
            font-weight: 700;
            color: var(--gray-800);
            margin-bottom: 0.5rem;
        }
        
        .login-subtitle {
            font-size: 1rem;
            color: var(--gray-600);
        }
        
        .login-card {
            background-color: var(--white);
            border-radius: 1rem;
            box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.05), 0 8px 10px -6px rgba(0, 0, 0, 0.01);
            overflow: hidden;
            border: 1px solid var(--gray-200);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        
        .login-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
        }
        
        .login-body {
            padding: 2.5rem;
        }
        
        .form-group {
            margin-bottom: 1.5rem;
        }
        
        .form-label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 500;
            color: var(--gray-700);
            font-size: 0.9rem;
        }
        
        .form_control {
            width: 100%;
            padding: 0.75rem 1rem;
            padding-left: 3rem;
            margin-bottom: 10px;
            border: 1px solid var(--gray-300);
            border-radius: 0.5rem;
            font-family: inherit;
            font-size: 1rem;
            transition: all 0.2s ease;
            color: var(--gray-800);
            background-color: var(--white);
        }
        
        .form-control:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px var(--primary-light);
        }
        
        .input-group {
            position: relative;
        }
        
        .input-icon {
            position: absolute;
            top: 50%;
            left: 1rem;
            transform: translateY(-50%);
            color: var(--primary-color);
            font-size: 1.25rem;
        }
        
        .btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 100%;
            padding: 0.875rem 1.5rem;
            border-radius: 0.5rem;
            font-size: 1rem;
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
        
        .login-options {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 1.5rem;
        }
        
        .remember-me {
            display: flex;
            align-items: center;
        }
        
        .remember-me input[type="checkbox"] {
            width: 1rem;
            height: 1rem;
            margin-right: 0.5rem;
            accent-color: var(--primary-color);
        }
        
        .remember-me label {
            font-size: 0.875rem;
            color: var(--gray-600);
        }
        
        .forgot-password {
            font-size: 0.875rem;
            color: var(--primary-color);
            text-decoration: none;
            transition: color 0.2s ease;
        }
        
        .forgot-password:hover {
            color: var(--primary-dark);
            text-decoration: underline;
        }
        
        .divider {
            display: flex;
            align-items: center;
            margin: 2rem 0;
            color: var(--gray-500);
            font-size: 0.875rem;
        }
        
        .divider::before,
        .divider::after {
            content: "";
            flex: 1;
            height: 1px;
            background-color: var(--gray-200);
        }
        
        .divider::before {
            margin-right: 1rem;
        }
        
        .divider::after {
            margin-left: 1rem;
        }
        
        .social-login {
            display: flex;
            gap: 1rem;
            margin-bottom: 2rem;
        }
        
        .social-btn {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 0.75rem;
            border-radius: 0.5rem;
            background-color: var(--white);
            border: 1px solid var(--gray-200);
            color: var(--gray-700);
            font-size: 1.25rem;
            transition: all 0.2s ease;
        }
        
        .social-btn:hover {
            background-color: var(--gray-50);
            transform: translateY(-1px);
        }
        
        .login-footer {
            text-align: center;
            margin-top: 2rem;
            color: var(--gray-600);
            font-size: 0.875rem;
        }
        
        .login-footer a {
            color: var(--primary-color);
            text-decoration: none;
            font-weight: 500;
            transition: color 0.2s ease;
        }
        
        .login-footer a:hover {
            color: var(--primary-dark);
            text-decoration: underline;
        }
        
        .help-text {
            display: flex;
            align-items: center;
            margin-top: 1.5rem;
            padding: 1rem;
            background-color: var(--primary-light);
            border-radius: 0.5rem;
            color: var(--primary-dark);
            font-size: 0.875rem;
        }
        
        .help-text i {
            margin-right: 0.75rem;
            font-size: 1.25rem;
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
        @media (max-width: 640px) {
            .login-body {
                padding: 2rem 1.5rem;
            }
            
            .social-login {
                flex-direction: column;
            }
        }
    </style>
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
