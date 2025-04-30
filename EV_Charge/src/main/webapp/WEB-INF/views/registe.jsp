<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입 | EV충전소</title>
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
    <script src="${pageContext.request.contextPath}/js/region.js"></script>
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
            --green-500: #22c55e;
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
        
        .container {
            width: 100%;
            max-width: 600px;
            margin: 0 auto;
        }
        
        .register-header {
            text-align: center;
            margin-bottom: 2rem;
        }
        
        .register-logo {
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 1.5rem;
        }
        
        .register-logo-icon {
            width: 60px;
            height: 60px;
            background-color: var(--primary-color);
            border-radius: 16px;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 10px 15px -3px rgba(16, 185, 129, 0.2), 0 4px 6px -2px rgba(16, 185, 129, 0.1);
        }
        
        .register-logo-icon i {
            font-size: 30px;
            color: var(--white);
        }
        
        .register-title {
            font-size: 1.75rem;
            font-weight: 700;
            color: var(--gray-800);
            margin-bottom: 0.5rem;
        }
        
        .register-subtitle {
            font-size: 1rem;
            color: var(--gray-600);
        }
        
        .card {
            background-color: var(--white);
            border-radius: 1rem;
            box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.05), 0 8px 10px -6px rgba(0, 0, 0, 0.01);
            overflow: hidden;
            border: 1px solid var(--gray-200);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        
        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
        }
        
        .card-body {
            padding: 2.5rem;
        }
        
        .form-group {
            margin-bottom: 1.75rem;
        }
        
        .form-label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 500;
            color: var(--gray-700);
            font-size: 0.9rem;
        }
        
        .form-control {
            width: 100%;
            padding: 0.75rem 1rem;
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
        
        .form-control[readonly] {
            background-color: var(--gray-100);
            cursor: not-allowed;
            color: var(--gray-600);
        }
        
        .form-text {
            margin-top: 0.5rem;
            font-size: 0.8rem;
            display: flex;
            align-items: center;
        }
        
        .form-text i {
            margin-right: 0.25rem;
        }
        
        .form-text.text-success {
            color: var(--green-500);
        }
        
        .form-text.text-danger {
            color: var(--red-500);
        }
        
        .input-group {
            position: relative;
            display: flex;
            gap: 0.75rem;
        }
        
        .input-group .form-control {
            flex: 1;
        }
        
        .input-icon {
            position: absolute;
            top: 50%;
            left: 1rem;
            transform: translateY(-50%);
            color: var(--primary-color);
            font-size: 1.25rem;
        }
        
        .input-with-icon {
            padding-left: 3rem;
        }
        
        .btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 0.75rem 1.5rem;
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
        
        .btn-secondary {
            background-color: var(--gray-500);
            color: var(--white);
        }
        
        .btn-secondary:hover {
            background-color: var(--gray-600);
            transform: translateY(-1px);
        }
        
        .btn-outline {
            background-color: var(--white);
            color: var(--gray-700);
            border: 1px solid var(--gray-300);
        }
        
        .btn-outline:hover {
            background-color: var(--gray-100);
            color: var(--gray-800);
            transform: translateY(-1px);
        }
        
        .btn-block {
            width: 100%;
        }
        
        .validation-message {
            margin-top: 0.5rem;
            font-size: 0.8rem;
            display: flex;
            align-items: center;
        }
        
        .validation-message i {
            margin-right: 0.25rem;
        }
        
        .validation-message.success {
            color: var(--green-500);
        }
        
        .validation-message.error {
            color: var(--red-500);
        }
        
        .select-group {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 0.75rem;
            margin-bottom: 1rem;
        }
        
        .select-group select {
            width: 100%;
            padding: 0.75rem 1rem;
            border: 1px solid var(--gray-300);
            border-radius: 0.5rem;
            font-family: inherit;
            font-size: 1rem;
            transition: all 0.2s ease;
            color: var(--gray-800);
            background-color: var(--white);
            appearance: none;
            background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' fill='none' viewBox='0 0 20 20'%3e%3cpath stroke='%236b7280' stroke-linecap='round' stroke-linejoin='round' stroke-width='1.5' d='M6 8l4 4 4-4'/%3e%3c/svg%3e");
            background-position: right 0.75rem center;
            background-repeat: no-repeat;
            background-size: 1.5em 1.5em;
            padding-right: 2.5rem;
        }
        
        .select-group select:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px var(--primary-light);
        }
        
        .select-label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 500;
            color: var(--gray-700);
            font-size: 0.9rem;
        }
        
        .password-strength {
            height: 4px;
            background-color: var(--gray-200);
            border-radius: 2px;
            margin-top: 0.5rem;
            overflow: hidden;
        }
        
        .password-strength-bar {
            height: 100%;
            width: 0;
            transition: width 0.3s ease;
            border-radius: 2px;
        }
        
        .strength-weak {
            width: 33%;
            background-color: var(--red-500);
        }
        
        .strength-medium {
            width: 66%;
            background-color: #f59e0b;
        }
        
        .strength-strong {
            width: 100%;
            background-color: var(--green-500);
        }
        
        .form-steps {
            display: flex;
            justify-content: space-between;
            margin-bottom: 2rem;
            position: relative;
        }
        
        .form-steps::before {
            content: '';
            position: absolute;
            top: 14px;
            left: 0;
            right: 0;
            height: 2px;
            background-color: var(--gray-200);
            z-index: 1;
        }
        
        .step {
            display: flex;
            flex-direction: column;
            align-items: center;
            position: relative;
            z-index: 2;
        }
        
        .step-number {
            width: 30px;
            height: 30px;
            border-radius: 50%;
            background-color: var(--white);
            border: 2px solid var(--gray-300);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 0.875rem;
            font-weight: 600;
            color: var(--gray-500);
            margin-bottom: 0.5rem;
            transition: all 0.3s ease;
        }
        
        .step-label {
            font-size: 0.75rem;
            color: var(--gray-500);
            transition: all 0.3s ease;
        }
        
        .step.active .step-number {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
            color: var(--white);
        }
        
        .step.active .step-label {
            color: var(--primary-color);
            font-weight: 500;
        }
        
        .step.completed .step-number {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
            color: var(--white);
        }
        
        .step.completed .step-number::after {
            content: '✓';
        }
        
        .step.completed .step-label {
            color: var(--primary-color);
        }
        
        .form-step {
            display: none;
        }
        
        .form-step.active {
            display: block;
            animation: fadeIn 0.5s ease-out forwards;
        }
        
        .step-buttons {
            display: flex;
            justify-content: space-between;
            margin-top: 2rem;
        }
        
        .terms-container {
            max-height: 200px;
            overflow-y: auto;
            padding: 1rem;
            border: 1px solid var(--gray-200);
            border-radius: 0.5rem;
            background-color: var(--gray-50);
            margin-bottom: 1rem;
            font-size: 0.875rem;
            color: var(--gray-700);
        }
        
        .checkbox-group {
            display: flex;
            align-items: center;
            margin-bottom: 0.75rem;
        }
        
        .checkbox-group input[type="checkbox"] {
            width: 1.25rem;
            height: 1.25rem;
            margin-right: 0.75rem;
            accent-color: var(--primary-color);
        }
        
        .checkbox-group label {
            font-size: 0.9rem;
            color: var(--gray-700);
        }
        
        .register-footer {
            text-align: center;
            margin-top: 2rem;
            color: var(--gray-600);
            font-size: 0.875rem;
        }
        
        .register-footer a {
            color: var(--primary-color);
            text-decoration: none;
            font-weight: 500;
            transition: color 0.2s ease;
        }
        
        .register-footer a:hover {
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
            .card-body {
                padding: 1.5rem;
            }
            
            .input-group {
                flex-direction: column;
            }
            
            .select-group {
                grid-template-columns: 1fr;
            }
            
            .form-steps {
                flex-wrap: wrap;
                justify-content: center;
                gap: 1rem;
            }
            
            .form-steps::before {
                display: none;
            }
            
            .step {
                flex-direction: row;
                width: 100%;
                gap: 0.5rem;
            }
            
            .step-number {
                margin-bottom: 0;
            }
        }
    </style>
</head>
<body>
    <div class="page-container">
        <jsp:include page="/WEB-INF/views/header.jsp" />
        
        <div class="content-container">
            <div class="container">
                <div class="register-header fade-in">
                    <div class="register-logo">
                        <div class="register-logo-icon">
                            <i class="fas fa-bolt"></i>
                        </div>
                    </div>
                    <h1 class="register-title">회원가입</h1>
                    <p class="register-subtitle">EV충전소 서비스 이용을 위한 회원가입을 진행합니다</p>
                </div>
                
                <div class="card fade-in delay-100">
                    <div class="card-body">
                        <div class="form-steps">
                            <div class="step active" data-step="1">
                                <div class="step-number">1</div>
                                <div class="step-label">약관동의</div>
                            </div>
                            <div class="step" data-step="2">
                                <div class="step-number">2</div>
                                <div class="step-label">정보입력</div>
                            </div>
                            <div class="step" data-step="3">
                                <div class="step-number">3</div>
                                <div class="step-label">가입완료</div>
                            </div>
                        </div>
                        
                        <form id="registerForm" method="post" action="registe_user" onsubmit="return validateForm()">
                            <!-- 약관동의 단계 -->
                            <div class="form-step active" id="step1">
                                <div class="form-group">
                                    <label class="form-label">서비스 이용약관</label>
                                    <div class="terms-container">
                                        <h4>제1조 (목적)</h4>
                                        <p>이 약관은 EV충전소(이하 "회사"라 함)가 제공하는 전기차 충전소 서비스(이하 "서비스"라 함)를 이용함에 있어 회사와 이용자의 권리, 의무 및 책임사항을 규정함을 목적으로 합니다.</p>
                                        <br>
                                        <h4>제2조 (정의)</h4>
                                        <p>"서비스"란 회사가 제공하는 전기차 충전소 위치 정보 제공, 충전 예약, 결제 등의 서비스를 의미합니다.</p>
                                        <p>"이용자"란 회사의 서비스에 접속하여 이 약관에 따라 회사가 제공하는 서비스를 받는 회원 및 비회원을 말합니다.</p>
                                        <br>
                                        <h4>제3조 (약관의 효력 및 변경)</h4>
                                        <p>이 약관은 서비스를 이용하고자 하는 모든 이용자에게 적용됩니다.</p>
                                        <p>회사는 필요한 경우 약관을 변경할 수 있으며, 변경된 약관은 서비스 내에 공지함으로써 효력이 발생합니다.</p>
                                    </div>
                                    <div class="checkbox-group">
                                        <input type="checkbox" id="terms1" name="terms1" required>
                                        <label for="terms1">서비스 이용약관에 동의합니다 (필수)</label>
                                    </div>
                                </div>
                                
                                <div class="form-group">
                                    <label class="form-label">개인정보 수집 및 이용 동의</label>
                                    <div class="terms-container">
                                        <h4>1. 수집하는 개인정보 항목</h4>
                                        <p>- 필수항목: 아이디, 비밀번호, 이름, 이메일, 주소(시/도, 군/구, 읍/면/동)</p>
                                        <p>- 선택항목: 프로필 이미지</p>
                                        <br>
                                        <h4>2. 개인정보의 수집 및 이용목적</h4>
                                        <p>- 서비스 제공에 관한 계약 이행 및 서비스 제공에 따른 요금정산</p>
                                        <p>- 회원 관리: 회원제 서비스 이용에 따른 본인확인, 개인식별, 불량회원의 부정 이용 방지와 비인가 사용 방지, 가입 의사 확인, 불만처리 등 민원처리, 고지사항 전달</p>
                                        <br>
                                        <h4>3. 개인정보의 보유 및 이용기간</h4>
                                        <p>회사는 회원탈퇴 시 또는 수집 및 이용목적이 달성되거나 보유 및 이용기간이 종료한 경우 해당 정보를 지체 없이 파기합니다. 단, 관계법령의 규정에 의하여 보존할 필요가 있는 경우 회사는 관계법령에서 정한 일정한 기간 동안 회원정보를 보관합니다.</p>
                                    </div>
                                    <div class="checkbox-group">
                                        <input type="checkbox" id="terms2" name="terms2" required>
                                        <label for="terms2">개인정보 수집 및 이용에 동의합니다 (필수)</label>
                                    </div>
                                </div>
                                
                                <div class="form-group">
                                    <div class="checkbox-group">
                                        <input type="checkbox" id="terms3" name="terms3">
                                        <label for="terms3">마케팅 정보 수신에 동의합니다 (선택)</label>
                                    </div>
                                </div>
                                
                                <div class="step-buttons">
                                    <div></div> <!-- 빈 div로 공간 확보 -->
                                    <button type="button" class="btn btn-primary next-step" data-step="1">
                                        다음 단계 <i class="fas fa-arrow-right"></i>
                                    </button>
                                </div>
                            </div>
                            
                            <!-- 정보입력 단계 -->
                            <div class="form-step" id="step2">
                                <div class="form-group">
                                    <label for="user_id" class="form-label">아이디</label>
                                    <div class="input-group">
                                        <div class="position-relative flex-grow-1">
                                            <i class="fas fa-user input-icon"></i>
                                            <input type="text" class="form-control input-with-icon" name="user_id" id="user_id" required
                                                placeholder="4자 이상 입력하세요">
                                        </div>
                                        <button type="button" id="user_id_check" class="btn btn-outline">
                                            <i class="fas fa-check"></i> 중복확인
                                        </button>
                                    </div>
                                    <div id="id_validation" class="validation-message"></div>
                                </div>
                                
                                <div class="form-group">
                                    <label for="user_password" class="form-label">비밀번호</label>
                                    <div class="input-group">
                                        <div class="position-relative flex-grow-1">
                                            <i class="fas fa-lock input-icon"></i>
                                            <input type="password" class="form-control input-with-icon" name="user_password" id="user_password" required
                                                placeholder="6자 이상 입력하세요">
                                        </div>
                                        <button type="button" id="pw_toggle" class="btn btn-outline">
                                            <i class="fas fa-eye"></i>
                                        </button>
                                    </div>
                                    <div class="password-strength">
                                        <div id="password-strength-bar" class="password-strength-bar"></div>
                                    </div>
                                    <div class="form-text">
                                        <i class="fas fa-info-circle"></i> 영문, 숫자, 특수문자 조합으로 6자 이상 입력하세요
                                    </div>
                                </div>
                                
                                <div class="form-group">
                                    <label for="user_password_check" class="form-label">비밀번호 확인</label>
                                    <div class="input-group">
                                        <div class="position-relative flex-grow-1">
                                            <i class="fas fa-lock input-icon"></i>
                                            <input type="password" class="form-control input-with-icon" name="user_password_check" id="user_password_check" required
                                                placeholder="비밀번호를 한번 더 입력하세요">
                                        </div>
                                        <button type="button" id="pw_check_toggle" class="btn btn-outline">
                                            <i class="fas fa-eye"></i>
                                        </button>
                                    </div>
                                    <div id="pw_match_msg" class="validation-message"></div>
                                </div>
                                
                                <div class="form-group">
                                    <label for="user_name" class="form-label">이름</label>
                                    <div class="position-relative">
                                        <i class="fas fa-id-card input-icon"></i>
                                        <input type="text" class="form-control input-with-icon" name="user_name" id="user_name" required
                                            placeholder="이름을 입력하세요">
                                    </div>
                                </div>
                                
                                <div class="form-group">
                                    <label for="user_email" class="form-label">이메일</label>
                                    <div class="position-relative">
                                        <i class="fas fa-envelope input-icon"></i>
                                        <input type="email" class="form-control input-with-icon" name="user_email" id="user_email" required
                                            placeholder="example@email.com">
                                    </div>
                                </div>
                                
                                <div class="form-group">
                                    <label class="form-label">지역 선택</label>
                                    <div class="select-group">
                                        <div>
                                            <select id="area_ctpy_nm" name="area_ctpy_nm" onchange="updatearea_sgg_nm()">
                                                <option value="">시/도 선택</option>
                                                <option value="서울특별시">서울특별시</option>
                                                <option value="부산광역시">부산광역시</option>
                                                <option value="대구광역시">대구광역시</option>
                                                <option value="인천광역시">인천광역시</option>
                                                <option value="광주광역시">광주광역시</option>
                                                <option value="대전광역시">대전광역시</option>
                                                <option value="울산광역시">울산광역시</option>
                                                <option value="경기도">경기도</option>
                                                <option value="강원도">강원도</option>
                                                <option value="충청북도">충청북도</option>
                                                <option value="충청남도">충청남도</option>
                                                <option value="전라북도">전라북도</option>
                                                <option value="전라남도">전라남도</option>
                                                <option value="경상북도">경상북도</option>
                                                <option value="경상남도">경상남도</option>
                                                <option value="제주도">제주도</option>
                                            </select>
                                        </div>
                                        <div>
                                            <select id="area_sgg_nm" name="area_sgg_nm" onchange="updatearea_emd_nm()">
                                                <option value="">군/구 선택</option>
                                            </select>
                                        </div>
                                        <div>
                                            <select id="area_emd_nm" name="area_emd_nm">
                                                <option value="">읍/면/동 선택</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="step-buttons">
                                    <button type="button" class="btn btn-outline prev-step" data-step="2">
                                        <i class="fas fa-arrow-left"></i> 이전 단계
                                    </button>
                                    <button type="button" class="btn btn-primary next-step" data-step="2">
                                        다음 단계 <i class="fas fa-arrow-right"></i>
                                    </button>
                                </div>
                            </div>
                            
                            <!-- 가입완료 단계 -->
                            <div class="form-step" id="step3">
                                <div class="text-center" style="padding: 2rem 0;">
                                    <div style="font-size: 4rem; color: var(--primary-color); margin-bottom: 1.5rem;">
                                        <i class="fas fa-check-circle"></i>
                                    </div>
                                    <h2 style="font-size: 1.5rem; font-weight: 600; margin-bottom: 1rem; color: var(--gray-800);">
                                        회원가입 정보 확인
                                    </h2>
                                    <p style="color: var(--gray-600); margin-bottom: 2rem;">
                                        입력하신 정보를 확인하시고 가입 버튼을 클릭하세요.
                                    </p>
                                    
                                    <div style="background-color: var(--gray-50); border-radius: 0.5rem; padding: 1.5rem; text-align: left; margin-bottom: 2rem;">
                                        <div style="display: flex; margin-bottom: 0.75rem;">
                                            <div style="width: 30%; font-weight: 500; color: var(--gray-700);">아이디</div>
                                            <div style="width: 70%; color: var(--gray-800);" id="confirm_id"></div>
                                        </div>
                                        <div style="display: flex; margin-bottom: 0.75rem;">
                                            <div style="width: 30%; font-weight: 500; color: var(--gray-700);">이름</div>
                                            <div style="width: 70%; color: var(--gray-800);" id="confirm_name"></div>
                                        </div>
                                        <div style="display: flex; margin-bottom: 0.75rem;">
                                            <div style="width: 30%; font-weight: 500; color: var(--gray-700);">이메일</div>
                                            <div style="width: 70%; color: var(--gray-800);" id="confirm_email"></div>
                                        </div>
                                        <div style="display: flex; margin-bottom: 0.75rem;">
                                            <div style="width: 30%; font-weight: 500; color: var(--gray-700);">지역</div>
                                            <div style="width: 70%; color: var(--gray-800);" id="confirm_address"></div>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="step-buttons">
                                    <button type="button" class="btn btn-outline prev-step" data-step="3">
                                        <i class="fas fa-arrow-left"></i> 이전 단계
                                    </button>
                                    <button type="submit" class="btn btn-primary">
                                        <i class="fas fa-user-plus"></i> 가입하기
                                    </button>
                                </div>
                            </div>
                        </form>
                        
                        <div class="help-text fade-in delay-300">
                            <i class="fas fa-info-circle"></i>
                            <span>회원가입에 문제가 있으신가요? <a href="support">고객센터</a>에 문의하세요.</span>
                        </div>
                    </div>
                </div>
                
                <div class="register-footer fade-in delay-200">
                    <p>이미 계정이 있으신가요? <a href="login">로그인</a></p>
                </div>
            </div>
        </div>
    </div>
    
    <script src="${pageContext.request.contextPath}/js/jquery.js"></script>
    <script>
        $(document).ready(function () {
            // 단계별 폼 처리
            $(".next-step").on("click", function() {
                const currentStep = parseInt($(this).data("step"));
                const nextStep = currentStep + 1;
                
                // 현재 단계 유효성 검사
                if (currentStep === 1) {
                    if (!$("#terms1").is(":checked") || !$("#terms2").is(":checked")) {
                        alert("필수 약관에 동의해주세요.");
                        return;
                    }
                } else if (currentStep === 2) {
                    // 아이디 중복 체크 여부
                    if (!$("#user_id").prop("readonly")) {
                        alert("아이디 중복 확인을 해주세요.");
                        return;
                    }
                    
                    // 비밀번호 확인
                    const pw = $("#user_password").val();
                    const pwCheck = $("#user_password_check").val();
                    if (pw !== pwCheck) {
                        alert("비밀번호가 일치하지 않습니다.");
                        return;
                    }
                    
                    // 필수 입력 확인
                    if (!$("#user_name").val().trim()) {
                        alert("이름을 입력해주세요.");
                        $("#user_name").focus();
                        return;
                    }
                    
                    if (!$("#user_email").val().trim()) {
                        alert("이메일을 입력해주세요.");
                        $("#user_email").focus();
                        return;
                    }
                    
                    // 지역 선택 확인
                    if (!$("#area_ctpy_nm").val() || !$("#area_sgg_nm").val() || !$("#area_emd_nm").val()) {
                        alert("지역을 모두 선택해주세요.");
                        return;
                    }
                    
                    // 확인 페이지에 정보 표시
                    $("#confirm_id").text($("#user_id").val());
                    $("#confirm_name").text($("#user_name").val());
                    $("#confirm_email").text($("#user_email").val());
                    $("#confirm_address").text(
                        $("#area_ctpy_nm").val() + " " + 
                        $("#area_sgg_nm").val() + " " + 
                        $("#area_emd_nm").val()
                    );
                }
                
                // 다음 단계로 이동
                $(".form-step").removeClass("active");
                $("#step" + nextStep).addClass("active");
                
                // 단계 표시 업데이트
                $(".step").removeClass("active completed");
                $(".step[data-step='" + nextStep + "']").addClass("active");
                for (let i = 1; i < nextStep; i++) {
                    $(".step[data-step='" + i + "']").addClass("completed");
                }
                
                // 페이지 상단으로 스크롤
                $('html, body').animate({
                    scrollTop: $(".form-steps").offset().top - 20
                }, 300);
            });
            
            $(".prev-step").on("click", function() {
                const currentStep = parseInt($(this).data("step"));
                const prevStep = currentStep - 1;
                
                // 이전 단계로 이동
                $(".form-step").removeClass("active");
                $("#step" + prevStep).addClass("active");
                
                // 단계 표시 업데이트
                $(".step").removeClass("active completed");
                $(".step[data-step='" + prevStep + "']").addClass("active");
                for (let i = 1; i < prevStep; i++) {
                    $(".step[data-step='" + i + "']").addClass("completed");
                }
                
                // 페이지 상단으로 스크롤
                $('html, body').animate({
                    scrollTop: $(".form-steps").offset().top - 20
                }, 300);
            });
            
            // 아이디 중복 체크
            $("#user_id_check").on("click", function () {
                var id = $("#user_id").val().trim();
                if (id === "") {
                    $("#id_validation").html('<i class="fas fa-exclamation-circle"></i> 아이디를 입력하세요!').removeClass("success").addClass("error");
                    return;
                }

                // 아이디 4자 이상
                if (id.length < 4) {
                    $("#id_validation").html('<i class="fas fa-exclamation-circle"></i> 아이디는 4자 이상 입력해야 합니다.').removeClass("success").addClass("error");
                    return;
                }
                
                $.ajax({
                    type: "post",
                    url: "user_id_check",
                    data: { user_id: id },
                    success: function (result) {
                        if (result == "ok") {
                            $("#id_validation").html('<i class="fas fa-check-circle"></i> 사용 가능한 아이디입니다!').removeClass("error").addClass("success");
                            $("#user_id").prop("readonly", true);
                        } else {
                            $("#id_validation").html('<i class="fas fa-exclamation-circle"></i> 이미 사용중인 아이디입니다!').removeClass("success").addClass("error");
                        }
                    },
                    error: function () {
                        $("#id_validation").html('<i class="fas fa-exclamation-circle"></i> 서버 에러가 발생했습니다!').removeClass("success").addClass("error");
                    }
                });
            });

            // 비번과 비번확인 비교
            $("#user_password, #user_password_check").on("input", function () {
                var pw = $("#user_password").val();
                var pw_check = $("#user_password_check").val();
                var msg = $("#pw_match_msg");

                if (pw_check.length === 0) {
                    msg.text("").removeClass("success error");
                    return;
                }

                if (pw === pw_check) {
                    msg.html('<i class="fas fa-check-circle"></i> 비밀번호가 일치합니다.').removeClass("error").addClass("success");
                } else {
                    msg.html('<i class="fas fa-exclamation-circle"></i> 비밀번호가 일치하지 않습니다.').removeClass("success").addClass("error");
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

            // 비번과 비번확인 보이게하기
            $("#pw_toggle").on("click", function (e) {
                e.preventDefault();
                var pw = $("#user_password");
                var icon = $(this).find("i");

                if (pw.attr("type") === "password") {
                    pw.attr("type", "text");
                    icon.removeClass("fa-eye").addClass("fa-eye-slash");
                } else {
                    pw.attr("type", "password");
                    icon.removeClass("fa-eye-slash").addClass("fa-eye");
                }
            });

            $("#pw_check_toggle").on("click", function (e) {
                e.preventDefault();
                var pw_check = $("#user_password_check");
                var icon = $(this).find("i");

                if (pw_check.attr("type") === "password") {
                    pw_check.attr("type", "text");
                    icon.removeClass("fa-eye").addClass("fa-eye-slash");
                } else {
                    pw_check.attr("type", "password");
                    icon.removeClass("fa-eye-slash").addClass("fa-eye");
                }
            });
        });
        
        // 군/구 옵션 업데이트 함수
        function updatearea_sgg_nm() {
            const area_ctpy_nm = document.getElementById("area_ctpy_nm").value;
            const area_sgg_nmSelect = document.getElementById("area_sgg_nm");
            const area_emd_nmSelect = document.getElementById("area_emd_nm");

            // 군/구와 읍/면/동 초기화
            area_sgg_nmSelect.innerHTML = '<option value="">군/구 선택</option>';
            area_emd_nmSelect.innerHTML = '<option value="">읍/면/동 선택</option>';

            if (area_ctpy_nm && regions[area_ctpy_nm]) {
                // 군/구 옵션 추가
                for (const area_sgg_nm in regions[area_ctpy_nm]) {
                    const option = document.createElement("option");
                    option.value = area_sgg_nm;
                    option.text = area_sgg_nm;
                    area_sgg_nmSelect.appendChild(option);
                }
            }
        }

        // 읍/면/동 옵션 업데이트 함수
        function updatearea_emd_nm() {
            const area_ctpy_nm = document.getElementById("area_ctpy_nm").value;
            const area_sgg_nm = document.getElementById("area_sgg_nm").value;
            const area_emd_nmSelect = document.getElementById("area_emd_nm");

            // 읍/면/동 초기화
            area_emd_nmSelect.innerHTML = '<option value="">읍/면/동 선택</option>';

            if (area_ctpy_nm && area_sgg_nm && regions[area_ctpy_nm] && regions[area_ctpy_nm][area_sgg_nm]) {
                const area_emd_nms = regions[area_ctpy_nm][area_sgg_nm];
                area_emd_nms.forEach(area_emd_nm => {
                    const option = document.createElement("option");
                    option.value = area_emd_nm;
                    option.text = area_emd_nm;
                    area_emd_nmSelect.appendChild(option);
                });
            }
        }
        
        function validateForm() {
            // 최종 제출 전 유효성 검사
            var userid = document.getElementById("user_id").value.trim();
            var password = document.getElementById("user_password").value.trim();
            var passwordCheck = document.getElementById("user_password_check").value.trim();
            var name = document.getElementById("user_name").value.trim();
            var email = document.getElementById("user_email").value.trim();
            var province = document.getElementById("area_ctpy_nm").value.trim();
            var city = document.getElementById("area_sgg_nm").value.trim();
            var town = document.getElementById("area_emd_nm").value.trim();

            // 아이디 중복 확인 여부
            if (!document.getElementById("user_id").readOnly) {
                alert("아이디 중복 확인을 해주세요.");
                return false;
            }

            // 비밀번호 일치 여부
            if (password !== passwordCheck) {
                alert("비밀번호가 일치하지 않습니다.");
                return false;
            }

            // 필수 입력 확인
            if (!name) {
                alert("이름을 입력해주세요.");
                return false;
            }

            // 이메일 형식 체크
            var emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailPattern.test(email)) {
                alert("올바른 이메일 형식을 입력하세요.");
                return false;
            }

            // 지역 선택 확인
            if (!province || !city || !town) {
                alert("지역을 모두 선택해주세요.");
                return false;
            }

            return true;
        }
    </script>
</body>
</html>
