<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
		<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
			<!DOCTYPE html>
			<html>

			<head>
				<meta charset="UTF-8">
				<meta name="viewport" content="width=device-width, initial-scale=1.0">
				<title>게시글 상세보기 | 기업 포털</title>
				<!-- Google Fonts -->
				<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap"
					rel="stylesheet">
				<!-- Font Awesome -->
				<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
				<script src="${pageContext.request.contextPath}/js/jquery.js"></script>
				<style>
					:root {
						--primary-color: #10b981;
						--primary-dark: #059669;
						--primary-light: #d1fae5;
						--secondary-color: #6c757d;
						--success-color: #28a745;
						--danger-color: #dc3545;
						--warning-color: #ffc107;
						--info-color: #17a2b8;
						--text-color: #212529;
						--text-light: #6c757d;
						--text-muted: #adb5bd;
						--white: #ffffff;
						--gray-50: #f8f9fa;
						--gray-100: #f1f3f5;
						--gray-200: #e9ecef;
						--gray-300: #dee2e6;
						--gray-400: #ced4da;
						--gray-500: #adb5bd;
						--gray-600: #6c757d;
						--gray-700: #495057;
						--gray-800: #343a40;
						--gray-900: #212529;
						--border-radius: 0.375rem;
						--border-radius-sm: 0.25rem;
						--border-radius-lg: 0.5rem;
						--box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.08);
						--box-shadow-sm: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.075);
						--box-shadow-lg: 0 1rem 3rem rgba(0, 0, 0, 0.1);
						--transition: all 0.2s ease-in-out;
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
						max-width: 1000px;
						margin: 2rem auto;
						padding: 0 1.5rem;
					}

					.page-title {
						font-size: 1.75rem;
						font-weight: 700;
						color: var(--gray-800);
						margin-bottom: 1.5rem;
						padding-bottom: 0.75rem;
						border-bottom: 2px solid var(--primary-color);
					}

					.card {
						background-color: var(--white);
						border-radius: var(--border-radius);
						box-shadow: var(--box-shadow);
						overflow: hidden;
						margin-bottom: 2rem;
						border: 1px solid var(--gray-200);
						transition: var(--transition);
					}

					.card:hover {
						box-shadow: var(--box-shadow-lg);
					}

					.card-header {
						background-color: var(--white);
						padding: 1.25rem 1.5rem;
						border-bottom: 1px solid var(--gray-200);
						display: flex;
						align-items: center;
						justify-content: space-between;
					}

					.card-header h2 {
						font-size: 1.25rem;
						font-weight: 600;
						color: var(--gray-800);
						margin: 0;
						display: flex;
						align-items: center;
					}

					.card-header h2 i {
						margin-right: 0.75rem;
						color: var(--primary-color);
					}

					.card-header .meta {
						display: flex;
						align-items: center;
						gap: 1rem;
						color: var(--gray-600);
						font-size: 0.875rem;
					}

					.card-header .meta-item {
						display: flex;
						align-items: center;
					}

					.card-header .meta-item i {
						margin-right: 0.375rem;
					}

					.card-body {
						padding: 1.5rem;
					}

					.post-info {
						display: grid;
						grid-template-columns: 1fr;
						gap: 1.5rem;
						margin-bottom: 1.5rem;
					}

					.post-header {
						display: flex;
						flex-direction: column;
						gap: 0.5rem;
					}

					.post-title {
						font-size: 1.5rem;
						font-weight: 700;
						color: var(--gray-900);
						line-height: 1.4;
					}

					.post-meta {
						display: flex;
						align-items: center;
						flex-wrap: wrap;
						gap: 1rem;
						color: var(--gray-600);
						font-size: 0.875rem;
					}

					.post-meta-item {
						display: flex;
						align-items: center;
					}

					.post-meta-item i {
						margin-right: 0.375rem;
					}

					.post-content {
						background-color: var(--white);
						border-radius: var(--border-radius);
						padding: 1.5rem;
						border: 1px solid var(--gray-200);
						min-height: 200px;
						line-height: 1.7;
					}

					.form-group {
						margin-bottom: 1.5rem;
					}

					.form-label {
						display: block;
						margin-bottom: 0.5rem;
						font-weight: 500;
						color: var(--gray-700);
					}

					.form-control {
						display: block;
						width: 100%;
						padding: 0.75rem 1rem;
						font-size: 1rem;
						font-weight: 400;
						line-height: 1.5;
						color: var(--gray-700);
						background-color: var(--white);
						background-clip: padding-box;
						border: 1px solid var(--gray-300);
						border-radius: var(--border-radius);
						transition: border-color 0.15s ease-in-out, box-shadow 0.15s ease-in-out;
					}

					.form-control:focus {
						color: var(--gray-700);
						background-color: var(--white);
						border-color: var(--primary-color);
						outline: 0;
						box-shadow: 0 0 0 0.25rem rgba(0, 102, 204, 0.25);
					}

					textarea.form-control {
						min-height: 200px;
						resize: vertical;
					}

					.btn {
						display: inline-flex;
						align-items: center;
						justify-content: center;
						padding: 0.625rem 1.25rem;
						font-size: 0.875rem;
						font-weight: 500;
						line-height: 1.5;
						text-align: center;
						text-decoration: none;
						vertical-align: middle;
						cursor: pointer;
						user-select: none;
						border: 1px solid transparent;
						border-radius: var(--border-radius);
						transition: color 0.15s ease-in-out, background-color 0.15s ease-in-out,
							border-color 0.15s ease-in-out, box-shadow 0.15s ease-in-out;
					}

					.btn i {
						margin-right: 0.5rem;
					}

					.btn-primary {
						color: var(--white);
						background-color: var(--primary-color);
						border-color: var(--primary-color);
					}

					.btn-primary:hover {
						color: var(--white);
						background-color: var(--primary-dark);
						border-color: var(--primary-dark);
					}

					.btn-secondary {
						color: var(--white);
						background-color: var(--secondary-color);
						border-color: var(--secondary-color);
					}

					.btn-secondary:hover {
						color: var(--white);
						background-color: #5a6268;
						border-color: #545b62;
					}

					.btn-danger {
						color: var(--white);
						background-color: var(--danger-color);
						border-color: var(--danger-color);
					}

					.btn-danger:hover {
						color: var(--white);
						background-color: #c82333;
						border-color: #bd2130;
					}

					.btn-outline-primary {
						color: var(--primary-color);
						border-color: var(--primary-color);
						background-color: transparent;
					}

					.btn-outline-primary:hover {
						color: var(--white);
						background-color: var(--primary-color);
						border-color: var(--primary-color);
					}

					.btn-sm {
						padding: 0.375rem 0.75rem;
						font-size: 0.75rem;
					}

					.btn-group {
						display: flex;
						gap: 0.75rem;
					}

					/* 첨부파일 스타일 */
					.attachment-list {
						margin-top: 1rem;
					}

					.attachment-item {
						display: flex;
						align-items: center;
						padding: 0.75rem;
						background-color: var(--gray-50);
						border-radius: var(--border-radius);
						margin-bottom: 0.75rem;
						border: 1px solid var(--gray-200);
						transition: var(--transition);
					}

					.attachment-item:hover {
						background-color: var(--primary-light);
						border-color: var(--primary-color);
					}

					.attachment-icon {
						font-size: 1.5rem;
						color: var(--primary-color);
						margin-right: 1rem;
					}

					.attachment-info {
						flex: 1;
					}

					.attachment-name {
						font-weight: 500;
						color: var(--gray-800);
						margin-bottom: 0.25rem;
					}

					.attachment-meta {
						font-size: 0.75rem;
						color: var(--gray-600);
					}

					.attachment-preview {
						width: 60px;
						height: 60px;
						border-radius: var(--border-radius-sm);
						overflow: hidden;
						margin-left: 1rem;
						border: 1px solid var(--gray-300);
						background-color: var(--white);
						display: flex;
						align-items: center;
						justify-content: center;
					}

					.attachment-preview img {
						max-width: 100%;
						max-height: 100%;
						object-fit: cover;
					}

					/* 이미지 확대 보기 */
					.bigPicture {
						position: fixed;
						top: 0;
						left: 0;
						width: 100%;
						height: 100%;
						background-color: rgba(0, 0, 0, 0.85);
						display: none;
						justify-content: center;
						align-items: center;
						z-index: 1000;
						backdrop-filter: blur(5px);
					}

					.bigPic {
						max-width: 90%;
						max-height: 90%;
						position: relative;
					}

					.bigPic img {
						max-width: 100%;
						max-height: 100%;
						object-fit: contain;
						border-radius: var(--border-radius);
						box-shadow: 0 0 30px rgba(0, 0, 0, 0.5);
					}

					.close-btn {
						position: absolute;
						top: -40px;
						right: 0;
						color: var(--white);
						font-size: 1.5rem;
						cursor: pointer;
						background: none;
						border: none;
						opacity: 0.8;
						transition: opacity 0.2s;
					}

					.close-btn:hover {
						opacity: 1;
					}

					/* 댓글 스타일 */
					.comment-form {
						background-color: var(--gray-50);
						border-radius: var(--border-radius);
						padding: 1.5rem;
						margin-bottom: 1.5rem;
						border: 1px solid var(--gray-200);
					}

					.comment-form-title {
						font-size: 1rem;
						font-weight: 600;
						margin-bottom: 1rem;
						color: var(--gray-800);
					}

					.comment-form-row {
						display: grid;
						grid-template-columns: 1fr 3fr;
						gap: 1rem;
						margin-bottom: 1rem;
					}

					.comment-list {
						margin-top: 1.5rem;
					}

					.comment-item {
						padding: 1.25rem;
						border-radius: var(--border-radius);
						background-color: var(--white);
						border: 1px solid var(--gray-200);
						margin-bottom: 1rem;
						transition: var(--transition);
					}

					.comment-item:hover {
						border-color: var(--primary-color);
						box-shadow: var(--box-shadow-sm);
					}

					.comment-header {
						display: flex;
						justify-content: space-between;
						margin-bottom: 0.75rem;
					}

					.comment-author {
						font-weight: 600;
						color: var(--gray-800);
					}

					.comment-date {
						font-size: 0.75rem;
						color: var(--gray-600);
					}

					.comment-content {
						color: var(--gray-700);
						line-height: 1.6;
					}

					.comment-actions {
						display: flex;
						gap: 0.5rem;
						margin-top: 0.75rem;
						justify-content: flex-end;
					}

					.comment-action {
						font-size: 0.75rem;
						color: var(--gray-600);
						cursor: pointer;
						background: none;
						border: none;
						padding: 0.25rem 0.5rem;
						border-radius: var(--border-radius-sm);
						transition: var(--transition);
					}

					.comment-action:hover {
						color: var(--primary-color);
						background-color: var(--primary-light);
					}

					/* 반응형 디자인 */
					@media (max-width: 768px) {
						.container {
							padding: 0 1rem;
						}

						.card-header {
							flex-direction: column;
							align-items: flex-start;
							gap: 0.75rem;
						}

						.card-header .meta {
							flex-wrap: wrap;
						}

						.comment-form-row {
							grid-template-columns: 1fr;
						}

						.btn-group {
							flex-wrap: wrap;
						}
					}

					/* 애니메이션 */
					@keyframes fadeIn {
						from {
							opacity: 0;
						}

						to {
							opacity: 1;
						}
					}

					.fade-in {
						animation: fadeIn 0.3s ease-in-out;
					}

					/* 스크롤바 스타일 */
					::-webkit-scrollbar {
						width: 8px;
						height: 8px;
					}

					::-webkit-scrollbar-track {
						background: var(--gray-100);
					}

					::-webkit-scrollbar-thumb {
						background: var(--gray-400);
						border-radius: 4px;
					}

					::-webkit-scrollbar-thumb:hover {
						background: var(--gray-500);
					}
				</style>
			</head>

			<body>
				<jsp:include page="/WEB-INF/views/header.jsp" />

				<div class="container">
					<h1 class="page-title">게시글 상세보기</h1>

					<div class="card fade-in">
						<div class="card-header">
							<h2>${content_view.ev_notice_boardTitle}</h2>
							<div class="meta">
								<div class="meta-item">
									<i class="fas fa-user"></i> ${content_view.ev_notice_boardName}
								</div>
								<div class="meta-item">
									<i class="fas fa-calendar-alt"></i>
									<fmt:formatDate value="${content_view.ev_notice_boardDate}" pattern="yyyy-MM-dd HH:mm" />
								</div>
								<div class="meta-item">
									<i class="fas fa-eye"></i> ${content_view.ev_notice_boardHit}
								</div>
							</div>
						</div>
						<div class="card-body">
							<form id="actionForm" method="post" action="notice_modify">
								<input type="hidden" name="ev_notice_boardNo" value="${pageMaker.ev_notice_boardNo}">
								<input type="hidden" name="ev_pageNum" value="${pageMaker.ev_pageNum}">
								<input type="hidden" name="ev_amount" value="${pageMaker.ev_amount}">

								<div class="form-group">
									<label for="boardName" class="form-label">작성자</label>
									${content_view.ev_notice_boardName}"
								</div>

								<div class="form-group">
									<label for="boardTitle" class="form-label">제목</label>
									<c:choose>
										<c:when test="${not empty user.user_role and user.user_role eq 'ADMIN'}">
											<input type="text" id="boardTitle" name="ev_notice_boardTitle" class="form-control"
												value="${content_view.ev_notice_boardTitle}">
										</c:when>
										<c:otherwise>
											<input type="text" id="boardTitle" name="ev_notice_boardTitle" class="form-control"
												value="${content_view.ev_notice_boardTitle}" readonly>
										</c:otherwise>
									</c:choose>
								</div>

								<div class="form-group">
									<label for="boardContent" class="form-label">내용</label>
									<c:choose>
										<c:when test="${not empty user.user_role and user.user_role eq 'ADMIN'}">
											<textarea id="boardContent" name="ev_notice_boardContent"
												class="form-control">${content_view.ev_notice_boardContent}</textarea>
										</c:when>
										<c:otherwise>
											<textarea id="boardContent" name="ev_notice_boardContent"
												class="form-control" readonly>${content_view.ev_notice_boardContent}</textarea>
										</c:otherwise>
									</c:choose>
								</div>

								<div class="btn-group">
									<c:choose>
										<c:when test="${not empty user.user_role and user.user_role eq 'ADMIN'}">
											<button type="submit" class="btn btn-primary">
												<i class="fas fa-edit"></i> 수정
											</button>
										</c:when>
									</c:choose>
									<button type="submit" formaction="notice_list" class="btn btn-secondary">
										<i class="fas fa-list"></i> 목록보기
									</button>
									<c:choose>
										<c:when test="${not empty user.user_role and user.user_role eq 'ADMIN'}">
											<button type="submit" formaction="notice_delete" class="btn btn-danger">
												<i class="fas fa-trash-alt"></i> 삭제
											</button>
										</c:when>
									</c:choose>
								</div>
							</form>
						</div>
					</div>

			</body>

			</html>