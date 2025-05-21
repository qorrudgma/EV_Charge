<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>게시판 | EV충전소</title>
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
    <script src="${pageContext.request.contextPath}/js/jquery.js"></script>
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
        
        .card {
            background-color: var(--white);
            border-radius: 0.75rem;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05), 0 2px 4px -1px rgba(0, 0, 0, 0.03);
            overflow: hidden;
            border: 1px solid var(--gray-200);
            transition: box-shadow 0.3s ease;
        }
        
        .card:hover {
            box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.08), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
        }
        
        .card-header {
            padding: 1.5rem 2rem;
            border-bottom: 1px solid var(--gray-200);
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: var(--white);
        }
        
        .card-header h2 {
            margin: 0;
            font-size: 1.5rem;
            font-weight: 600;
            color: var(--gray-800);
            display: flex;
            align-items: center;
        }
        
        .card-header h2 i {
            margin-right: 0.75rem;
            color: var(--primary-color);
            font-size: 1.25rem;
        }
        
        .card-body {
            padding: 1.5rem 2rem;
        }
        
        .table-container {
            overflow-x: auto;
            margin: 1rem 0;
            border-radius: 0.5rem;
            border: 1px solid var(--gray-200);
        }
        
        .table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
        }
        
        .table th,
        .table td {
            padding: 1rem;
            text-align: left;
        }
        
        .table th {
            background-color: var(--gray-50);
            font-weight: 600;
            color: var(--gray-700);
            border-bottom: 1px solid var(--gray-200);
            position: sticky;
            top: 0;
            z-index: 10;
        }
        
        .table th:first-child {
            border-top-left-radius: 0.5rem;
        }
        
        .table th:last-child {
            border-top-right-radius: 0.5rem;
        }
        
        .table td {
            border-bottom: 1px solid var(--gray-200);
            color: var(--gray-700);
        }
        
        .table tr:last-child td {
            border-bottom: none;
        }
        
        .table tr:hover td {
            background-color: var(--primary-light);
        }
        
        .btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 0.625rem 1.25rem;
            border-radius: 0.5rem;
            font-size: 0.875rem;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.2s ease;
            text-decoration: none;
            border: none;
            box-shadow: 0 1px 2px 0 rgba(0, 0, 0, 0.05);
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
        
        .btn-sm {
            padding: 0.375rem 0.75rem;
            font-size: 0.75rem;
        }
        
        .link {
            color: var(--primary-color);
            text-decoration: none;
            font-weight: 500;
            transition: all 0.2s ease;
            position: relative;
            display: inline-flex;
            align-items: center;
        }
        
        .link:hover {
            color: var(--primary-dark);
        }
        
        .link::after {
            content: '';
            position: absolute;
            width: 100%;
            height: 1px;
            bottom: -2px;
            left: 0;
            background-color: var(--primary-color);
            transform: scaleX(0);
            transform-origin: bottom right;
            transition: transform 0.3s ease;
        }
        
        .link:hover::after {
            transform: scaleX(1);
            transform-origin: bottom left;
        }
        
        /* 페이지네이션 */
        .pagination-container {
            margin-top: 2rem;
            display: flex;
            justify-content: center;
        }
        
        .pagination {
            display: flex;
            list-style: none;
            padding: 0;
            background-color: var(--white);
            border-radius: 0.5rem;
            box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.1), 0 1px 2px 0 rgba(0, 0, 0, 0.06);
            overflow: hidden;
        }
        
        .paginate_button {
            margin: 0;
        }
        
        .paginate_button a {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            min-width: 2.5rem;
            height: 2.5rem;
            padding: 0 0.75rem;
            color: var(--gray-700);
            text-decoration: none;
            transition: all 0.2s ease;
            border-right: 1px solid var(--gray-200);
        }
        
        .paginate_button:last-child a {
            border-right: none;
        }
        
        .paginate_button a:hover {
            background-color: var(--gray-100);
            color: var(--gray-900);
        }
        
        .paginate_button.active a {
            background-color: var(--primary-color);
            color: var(--white);
            font-weight: 600;
        }
        
        /* 검색 폼 */
        .search-container {
            margin-bottom: 1.5rem;
            background-color: var(--white);
            border-radius: 0.75rem;
            padding: 1.5rem;
            box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.1), 0 1px 2px 0 rgba(0, 0, 0, 0.06);
            border: 1px solid var(--gray-200);
        }
        
        .search-form {
            display: flex;
            gap: 0.75rem;
            flex-wrap: wrap;
        }
        
        .search-form-group {
            display: flex;
            flex: 1;
            min-width: 200px;
        }
        
        .search-form select,
        .search-form input[type="text"] {
            padding: 0.625rem 1rem;
            border: 1px solid var(--gray-300);
            font-family: inherit;
            font-size: 0.875rem;
            transition: all 0.2s ease;
        }
        
        .search-form select {
            min-width: 120px;
            border-radius: 0.5rem 0 0 0.5rem;
            border-right: none;
            background-color: var(--gray-50);
            color: var(--gray-700);
            font-weight: 500;
            appearance: none;
            background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' fill='none' viewBox='0 0 20 20'%3e%3cpath stroke='%236b7280' stroke-linecap='round' stroke-linejoin='round' stroke-width='1.5' d='M6 8l4 4 4-4'/%3e%3c/svg%3e");
            background-position: right 0.5rem center;
            background-repeat: no-repeat;
            background-size: 1.5em 1.5em;
            padding-right: 2.5rem;
        }
        
        .search-form input[type="text"] {
            flex: 1;
            border-radius: 0 0.5rem 0.5rem 0;
        }
        
        .search-form select:focus,
        .search-form input[type="text"]:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px var(--primary-light);
            z-index: 1;
        }
        
        .search-form button {
            padding: 0.625rem 1.25rem;
            background-color: var(--primary-color);
            color: var(--white);
            border: none;
            border-radius: 0.5rem;
            font-family: inherit;
            font-size: 0.875rem;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.2s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            min-width: 100px;
        }
        
        .search-form button i {
            margin-right: 0.5rem;
        }
        
        .search-form button:hover {
            background-color: var(--primary-dark);
            transform: translateY(-1px);
        }
        
        /* 게시글 정보 */
        .board-info {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1rem;
            color: var(--gray-600);
            font-size: 0.875rem;
        }
        
        .board-count {
            display: flex;
            align-items: center;
        }
        
        .board-count i {
            margin-right: 0.5rem;
            color: var(--primary-color);
        }
        
        .board-count strong {
            color: var(--primary-color);
            font-weight: 600;
            margin: 0 0.25rem;
        }
        
        /* 반응형 디자인 */
        @media (max-width: 768px) {
            .card-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 1rem;
            }
            
            .search-form {
                flex-direction: column;
            }
            
            .search-form-group {
                width: 100%;
            }
            
            .search-form button {
                width: 100%;
            }
            
            .table th:nth-child(2),
            .table td:nth-child(2),
            .table th:nth-child(5),
            .table td:nth-child(5) {
                display: none;
            }
        }
        
        /* 애니메이션 */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        .fade-in {
            animation: fadeIn 0.3s ease-out forwards;
        }
        
        /* 게시글 상태 뱃지 */
        .badge {
            display: inline-flex;
            align-items: center;
            padding: 0.25rem 0.5rem;
            border-radius: 9999px;
            font-size: 0.75rem;
            font-weight: 500;
            margin-left: 0.5rem;
        }
        
        .badge-new {
            background-color: var(--primary-light);
            color: var(--primary-dark);
        }
        
        .badge-hot {
            background-color: #FEE2E2;
            color: #DC2626;
        }
        
        /* 테이블 내 아이콘 */
        .table-icon {
            color: var(--gray-400);
            margin-right: 0.25rem;
        }
        
        /* 공지사항 행 스타일 */
        .notice-row td {
            background-color: #F0FDF4;
            font-weight: 500;
        }
        
        .notice-badge {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 0.25rem 0.5rem;
            background-color: var(--primary-color);
            color: white;
            border-radius: 0.25rem;
            font-size: 0.75rem;
            font-weight: 600;
            margin-right: 0.5rem;
        }
        
        /* 첨부파일 아이콘 */
        .attachment-icon {
            color: var(--gray-500);
            margin-left: 0.5rem;
        }
    </style>
</head>

<body>
    <jsp:include page="/WEB-INF/views/header.jsp" />
    
    <div class="container">
        <div class="page-header">
            <h1 class="page-title"><i class="fas fa-clipboard-list"></i> 공지사항</h1>
            <p class="page-description">EV_Charge 공지사항입니다.</p>
        </div>
        
        <div class="search-container fade-in">
            <form method="get" id="searchForm" class="search-form">
                <div class="search-form-group">
                    <select name="ev_type">
                        <option value="" <c:out value="${pageMaker.ev_cri.ev_type == null ? 'selected':''}" />>전체</option>
                        <option value="T" <c:out value="${pageMaker.ev_cri.ev_type eq 'T' ? 'selected':''}" />>제목</option>
                        <option value="C" <c:out value="${pageMaker.ev_cri.ev_type eq 'C' ? 'selected':''}" />>내용</option>
                        <option value="W" <c:out value="${pageMaker.ev_cri.ev_type eq 'W' ? 'selected':''}" />>작성자</option>
                        <option value="TC" <c:out value="${pageMaker.ev_cri.ev_type eq 'TC' ? 'selected':''}" />>제목 or 내용</option>
                        <option value="TW" <c:out value="${pageMaker.ev_cri.ev_type eq 'TW' ? 'selected':''}" />>제목 or 작성자</option>
                        <option value="TCW" <c:out value="${pageMaker.ev_cri.ev_type eq 'TCW' ? 'selected':''}" />>제목 or 내용 or 작성자</option>
                    </select>
                    <input type="text" name="ev_keyword" value="${pageMaker.ev_cri.ev_keyword}" placeholder="검색어를 입력하세요">
                </div>
                <input type="hidden" name="ev_pageNum" value="1">
                <input type="hidden" name="ev_amount" value="${pageMaker.ev_cri.ev_amount}">
                <button type="submit"><i class="fas fa-search"></i> 검색</button>
            </form>
        </div>
        
        <div class="card fade-in">
            <div class="card-header">
                <h2 style="margin: 8px;"><i class="fas fa-list-ul"></i> 공지사항 목록</h2>

                <c:choose>
                    <c:when test="${not empty user.user_role and user.user_role eq 'ADMIN'}">
                        <a href="notice_write_view" class="btn btn-primary">
                            <i class="fas fa-pen"></i> 글작성
                        </a>
                    </c:when>
                    <c:otherwise>
                        ${user.user_name}님 환영합니다.
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="card-body">
                <div class="board-info">
                    <div class="board-count">
                        <i class="fas fa-file-alt"></i> 총 <strong>${pageMaker.ev_total}</strong> 개의 공지사항이 있습니다
                    </div>
                    <div class="board-view">
                        <select id="amountSelect" class="form-select" onchange="changeAmount(this.value)">
                            <option value="10" ${pageMaker.ev_cri.ev_amount == 10 ? 'selected' : ''}>10개씩 보기</option>
                            <option value="20" ${pageMaker.ev_cri.ev_amount == 20 ? 'selected' : ''}>20개씩 보기</option>
                            <option value="30" ${pageMaker.ev_cri.ev_amount == 30 ? 'selected' : ''}>30개씩 보기</option>
                            <option value="50" ${pageMaker.ev_cri.ev_amount == 50 ? 'selected' : ''}>50개씩 보기</option>
                        </select>
                    </div>
                </div>
                
                <div class="table-container">
                    <table class="table">
                        <thead>
                            <tr>
                                <th width="8%">번호</th>
                                <th width="12%">이름</th>
                                <th width="45%">제목</th>
                                <th width="15%">날짜</th>
                                <th width="8%">조회수</th>
                                <th width="12%">상태</th>
                            </tr>
                        </thead>
                        <tbody>
                            <!-- 공지사항 예시 (실제 데이터에 맞게 수정 필요) -->
                            <tr class="notice-row">
                                <td><span class="notice-badge">공지</span></td>
                                <td>관리자</td>
                                <td>
                                    <a class="link" href="#">
                                        <i class="fas fa-bullhorn table-icon"></i>
                                        EV충전소 커뮤니티 이용 안내
                                    </a>
                                </td>
                                <td>2023-10-15</td>
                                <td>521</td>
                                <td><span class="badge badge-hot">중요</span></td>
                            </tr>
                            
                            <!-- 실제 게시글 목록 -->
                            <c:forEach var="dto" items="${list}" varStatus="status">
                                <tr>
                                    <td>${dto.ev_notice_boardNo}</td>
                                    <td>${dto.ev_notice_boardName}</td>
                                    <td>
                                        <a class="link move_link" href="${dto.ev_notice_boardNo}">
                                            ${dto.ev_notice_boardTitle}
                                            <c:if test="${dto.ev_notice_boardHit >= 100}">
                                                <span class="badge badge-hot">HOT</span>
                                            </c:if>
                                        </a>
                                    </td>
                                    <td>
                                        <fmt:formatDate value="${dto.ev_notice_boardDate}" pattern="yyyy-MM-dd" />
                                    </td>
                                    <td>${dto.ev_notice_boardHit}</td>
                                    <td>
                                        <!-- 게시글 상태에 따른 뱃지 표시 (예시) -->
                                        <c:choose>
                                            <c:when test="${status.index % 5 == 0}">
                                                <span class="badge" style="background-color: #E0F2FE; color: #0369A1;">답변완료</span>
                                            </c:when>
                                            <c:when test="${status.index % 7 == 0}">
                                                <span class="badge" style="background-color: #FEF3C7; color: #B45309;">진행중</span>
                                            </c:when>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:forEach>
                            
                            <!-- 데이터가 없는 경우 -->
                            <c:if test="${empty list}">
                                <tr>
                                    <td colspan="6" style="text-align: center; padding: 3rem 1rem;">
                                        <div style="display: flex; flex-direction: column; align-items: center; color: var(--gray-500);">
                                            <i class="fas fa-search" style="font-size: 2rem; margin-bottom: 1rem;"></i>
                                            <p>검색 결과가 없습니다.</p>
                                        </div>
                                    </td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
                
                <div class="pagination-container">
                    <ul class="pagination">
                        <c:if test="${pageMaker.ev_prev}">
                            <li class="paginate_button">
                                <a href="${pageMaker.ev_startPage -1}" aria-label="이전">
                                    <i class="fas fa-chevron-left"></i>
                                </a>
                            </li>
                        </c:if>

                        <c:forEach var="num" begin="${pageMaker.ev_startPage}" end="${pageMaker.ev_endPage}">
                            <li class="paginate_button ${pageMaker.ev_cri.ev_pageNum == num ? 'active' : ''}">
                                <a href="${num}">${num}</a>
                            </li>
                        </c:forEach>

                        <c:if test="${pageMaker.ev_next}">
                            <li class="paginate_button">
                                <a href="${pageMaker.ev_endPage +1}" aria-label="다음">
                                    <i class="fas fa-chevron-right"></i>
                                </a>
                            </li>
                        </c:if>
                    </ul>
                </div>
            </div>
        </div>
    </div>

    <form id="actionForm" action="notice_list" method="get">
        <input type="hidden" name="ev_pageNum" value="${pageMaker.ev_cri.ev_pageNum}">
        <input type="hidden" name="ev_amount" value="${pageMaker.ev_cri.ev_amount}">
        <input type="hidden" name="ev_type" value="${pageMaker.ev_cri.ev_type}">
        <input type="hidden" name="ev_keyword" value="${pageMaker.ev_cri.ev_keyword}">
    </form>

    <script src="${pageContext.request.contextPath}/js/jquery.js"></script>
    <script>
        var actionForm = $("#actionForm");
        
        // 페이지번호 처리
        $(".paginate_button a").on("click", function (e) {
            e.preventDefault();
            console.log("페이지 번호 클릭");
            actionForm.find("input[name='ev_pageNum']").val($(this).attr("href"));
            actionForm.attr("action", "notice_list").submit();
        });

        // 게시글 처리
        $(".move_link").on("click", function (e) {
            e.preventDefault();
            console.log("게시글 클릭");
            var targetBno = $(this).attr("href");

            // 이미 boardNo input이 있으면 제거
            var bno = actionForm.find("input[name='ev_notice_boardNo']").val();
            if (bno != undefined) {
                actionForm.find("input[name='ev_notice_boardNo']").remove();
            }
            
            // boardNo input 추가
            actionForm.append("<input type='hidden' name='ev_notice_boardNo' value='" + targetBno + "'>");
            actionForm.attr("action", "notice_content_view").submit();
        });

        // 검색 폼 처리
        var searchForm = $("#searchForm");

        $("#searchForm button").on("click", function (e) {
            e.preventDefault();
            
            // 키워드 입력 확인
            if (searchForm.find("option:selected").val() != "" && !searchForm.find("input[name='ev_keyword']").val()) {
                alert("검색어를 입력해주세요.");
                searchForm.find("input[name='ev_keyword']").focus();
                return false;
            }

            searchForm.attr("action", "notice_list").submit();
        });

        // 검색 조건 변경 시
        $("#searchForm select").on("change", function () {
            if (searchForm.find("option:selected").val() == "") {
                // 전체 선택 시 키워드 초기화
                searchForm.find("input[name='ev_keyword']").val("");
            }
        });
        
        // 게시글 표시 개수 변경
        function changeAmount(amount) {
            actionForm.find("input[name='ev_amount']").val(amount);
            actionForm.find("input[name='ev_pageNum']").val(1); // 1페이지로 초기화
            actionForm.submit();
        }
    </script>
</body>
</html>
