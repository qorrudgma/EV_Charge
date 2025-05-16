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
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/list.css">
</head>

<body>
    <jsp:include page="/WEB-INF/views/header.jsp" />
    
    <div class="container">
        <div class="page-header">
            <h1 class="page-title"><i class="fas fa-clipboard-list"></i> 게시판</h1>
            <p class="page-description">EV충전소 커뮤니티에서 다양한 정보와 소식을 나눠보세요.</p>
        </div>
        
        <div class="search-container fade-in">
            <form method="get" id="searchForm" class="search-form">
                <div class="search-form-group">
                    <select name="type">
                        <option value="" <c:out value="${pageMaker.cri.type == null ? 'selected':''}" />>전체</option>
                        <option value="T" <c:out value="${pageMaker.cri.type eq 'T' ? 'selected':''}" />>제목</option>
                        <option value="C" <c:out value="${pageMaker.cri.type eq 'C' ? 'selected':''}" />>내용</option>
                        <option value="W" <c:out value="${pageMaker.cri.type eq 'W' ? 'selected':''}" />>작성자</option>
                        <option value="TC" <c:out value="${pageMaker.cri.type eq 'TC' ? 'selected':''}" />>제목 or 내용</option>
                        <option value="TW" <c:out value="${pageMaker.cri.type eq 'TW' ? 'selected':''}" />>제목 or 작성자</option>
                        <option value="TCW" <c:out value="${pageMaker.cri.type eq 'TCW' ? 'selected':''}" />>제목 or 내용 or 작성자</option>
                    </select>
                    <input type="text" name="keyword" value="${pageMaker.cri.keyword}" placeholder="검색어를 입력하세요">
                </div>
                <input type="hidden" name="pageNum" value="1">
                <input type="hidden" name="amount" value="${pageMaker.cri.amount}">
                <button type="submit"><i class="fas fa-search"></i> 검색</button>
            </form>
        </div>
        
        <div class="card fade-in">
            <div class="card-header">
                <h2><i class="fas fa-list-ul"></i> 게시글 목록</h2>
                <a href="write_view" class="btn btn-primary">
                    <i class="fas fa-pen"></i> 글작성
                </a>
            </div>
            <div class="card-body">
                <div class="board-info">
                    <div class="board-count">
                        <i class="fas fa-file-alt"></i> 총 <strong>${pageMaker.total}</strong> 개의 게시글이 있습니다
                    </div>
                    <div class="board-view">
                        <select id="amountSelect" class="form-select" onchange="changeAmount(this.value)">
                            <option value="10" ${pageMaker.cri.amount == 10 ? 'selected' : ''}>10개씩 보기</option>
                            <option value="20" ${pageMaker.cri.amount == 20 ? 'selected' : ''}>20개씩 보기</option>
                            <option value="30" ${pageMaker.cri.amount == 30 ? 'selected' : ''}>30개씩 보기</option>
                            <option value="50" ${pageMaker.cri.amount == 50 ? 'selected' : ''}>50개씩 보기</option>
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
                                    <td>${dto.boardNo}</td>
                                    <td>${dto.boardName}</td>
                                    <td>
                                        <a class="link move_link" href="${dto.boardNo}">
                                            ${dto.boardTitle}
                                            <!-- 첨부파일이 있는 경우 아이콘 표시 (예시) -->
                                            <c:if test="${dto.hasAttachment}">
                                                <i class="fas fa-paperclip attachment-icon"></i>
                                            </c:if>
                                            
                                            <!-- 최신글 표시 (예시: 3일 이내 작성된 글) -->
                                            <c:if test="${dto.isNew}">
                                                <span class="badge badge-new">NEW</span>
                                            </c:if>
                                            
                                            <!-- 인기글 표시 (예시: 조회수 100 이상) -->
                                            <c:if test="${dto.boardHit >= 100}">
                                                <span class="badge badge-hot">HOT</span>
                                            </c:if>
                                        </a>
                                    </td>
                                    <td>
                                        <fmt:formatDate value="${dto.boardDate}" pattern="yyyy-MM-dd" />
                                    </td>
                                    <td>${dto.boardHit}</td>
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
                        <c:if test="${pageMaker.prev}">
                            <li class="paginate_button">
                                <a href="${pageMaker.startPage -1}" aria-label="이전">
                                    <i class="fas fa-chevron-left"></i>
                                </a>
                            </li>
                        </c:if>

                        <c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
                            <li class="paginate_button ${pageMaker.cri.pageNum == num ? 'active' : ''}">
                                <a href="${num}">${num}</a>
                            </li>
                        </c:forEach>

                        <c:if test="${pageMaker.next}">
                            <li class="paginate_button">
                                <a href="${pageMaker.endPage +1}" aria-label="다음">
                                    <i class="fas fa-chevron-right"></i>
                                </a>
                            </li>
                        </c:if>
                    </ul>
                </div>
            </div>
        </div>
    </div>

    <form id="actionForm" action="list" method="get">
        <input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
        <input type="hidden" name="amount" value="${pageMaker.cri.amount}">
        <input type="hidden" name="type" value="${pageMaker.cri.type}">
        <input type="hidden" name="keyword" value="${pageMaker.cri.keyword}">
    </form>

    <script src="${pageContext.request.contextPath}/js/jquery.js"></script>
    <script>
        var actionForm = $("#actionForm");
        
        // 페이지번호 처리
        $(".paginate_button a").on("click", function (e) {
            e.preventDefault();
            console.log("페이지 번호 클릭");
            actionForm.find("input[name='pageNum']").val($(this).attr("href"));
            actionForm.attr("action", "list").submit();
        });

        // 게시글 처리
        $(".move_link").on("click", function (e) {
            e.preventDefault();
            console.log("게시글 클릭");
            var targetBno = $(this).attr("href");

            // 이미 boardNo input이 있으면 제거
            var bno = actionForm.find("input[name='boardNo']").val();
            if (bno != undefined) {
                actionForm.find("input[name='boardNo']").remove();
            }
            
            // boardNo input 추가
            actionForm.append("<input type='hidden' name='boardNo' value='" + targetBno + "'>");
            actionForm.attr("action", "content_view").submit();
        });

        // 검색 폼 처리
        var searchForm = $("#searchForm");

        $("#searchForm button").on("click", function (e) {
            e.preventDefault();
            
            // 키워드 입력 확인
            if (searchForm.find("option:selected").val() != "" && !searchForm.find("input[name='keyword']").val()) {
                alert("검색어를 입력해주세요.");
                searchForm.find("input[name='keyword']").focus();
                return false;
            }

            searchForm.attr("action", "list").submit();
        });

        // 검색 조건 변경 시
        $("#searchForm select").on("change", function () {
            if (searchForm.find("option:selected").val() == "") {
                // 전체 선택 시 키워드 초기화
                searchForm.find("input[name='keyword']").val("");
            }
        });
        
        // 게시글 표시 개수 변경
        function changeAmount(amount) {
            actionForm.find("input[name='amount']").val(amount);
            actionForm.find("input[name='pageNum']").val(1); // 1페이지로 초기화
            actionForm.submit();
        }
    </script>
</body>
</html>
