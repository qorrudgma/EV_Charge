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
							<h2>${content_view.boardTitle}</h2>
							<div class="meta">
								<div class="meta-item">
									<i class="fas fa-user"></i> ${content_view.boardName}
								</div>
								<div class="meta-item">
									<i class="fas fa-calendar-alt"></i>
									<fmt:formatDate value="${content_view.boardDate}" pattern="yyyy-MM-dd HH:mm" />
								</div>
								<div class="meta-item">
									<i class="fas fa-eye"></i> ${content_view.boardHit}
								</div>
							</div>
						</div>
						<div class="card-body">
							<form id="actionForm" method="post" action="modify">
								<input type="hidden" name="boardNo" value="${pageMaker.boardNo}">
								<input type="hidden" name="pageNum" value="${pageMaker.pageNum}">
								<input type="hidden" name="amount" value="${pageMaker.amount}">

								<div class="form-group">
									<label for="boardName" class="form-label">작성자</label>
									<input type="text" id="boardName" name="boardName" class="form-control"
										value="${content_view.boardName}">
								</div>

								<div class="form-group">
									<label for="boardTitle" class="form-label">제목</label>
									<input type="text" id="boardTitle" name="boardTitle" class="form-control"
										value="${content_view.boardTitle}">
								</div>

								<div class="form-group">
									<label for="boardContent" class="form-label">내용</label>
									<textarea id="boardContent" name="boardContent"
										class="form-control">${content_view.boardContent}</textarea>
								</div>

								<div class="btn-group">
									<button type="submit" class="btn btn-primary">
										<i class="fas fa-edit"></i> 수정
									</button>
									<button type="submit" formaction="list" class="btn btn-secondary">
										<i class="fas fa-list"></i> 목록보기
									</button>
									<button type="submit" formaction="delete" class="btn btn-danger">
										<i class="fas fa-trash-alt"></i> 삭제
									</button>
								</div>
							</form>
						</div>
					</div>

					<!-- 첨부파일 출력 -->
					<div class="card fade-in">
						<div class="card-header">
							<h2><i class="fas fa-paperclip"></i> 첨부파일</h2>
						</div>
						<div class="card-body">
							<div class="bigPicture">
								<div class="bigPic">
									<button class="close-btn"><i class="fas fa-times"></i></button>
								</div>
							</div>

							<div class="uploadResult">
								<ul class="attachment-list"></ul>
							</div>
						</div>
					</div>

					<!-- 댓글 출력 -->
					<div class="card fade-in">
						<div class="card-header">
							<h2><i class="fas fa-comments"></i> 댓글</h2>
							<div class="meta">
								<div class="meta-item">
									<i class="fas fa-comment"></i> 총 <span
										id="commentCount">${commentList.size()}</span>개의 댓글
								</div>
							</div>
						</div>
						<div class="card-body">
							<div class="comment-form">
								<h3 class="comment-form-title">댓글 작성</h3>
								<div class="comment-form-row">
									<input type="text" id="commentWriter" class="form-control" placeholder="작성자">
									<input type="text" id="commentContent" class="form-control" placeholder="내용">
								</div>
								<button onclick="commentWrite()" class="btn btn-primary">
									<i class="fas fa-paper-plane"></i> 댓글 작성
								</button>
							</div>

							<div id="comment-list" class="comment-list">
								<c:forEach items="${commentList}" var="comment">
									<div class="comment-item">
										<div class="comment-header">
											<span class="comment-author">${comment.commentWriter}</span>
											<span class="comment-date">
												<fmt:formatDate value="${comment.commentCreatedTime}"
													pattern="yyyy-MM-dd HH:mm" />
											</span>
										</div>
										<div class="comment-content">
											${comment.commentContent}
										</div>
										<div class="comment-actions">
											<button class="comment-action">
												<i class="fas fa-reply"></i> 답글
											</button>
											<button class="comment-action">
												<i class="fas fa-edit"></i> 수정
											</button>
											<button class="comment-action">
												<i class="fas fa-trash-alt"></i> 삭제
											</button>
										</div>
									</div>
								</c:forEach>
							</div>
						</div>
					</div>
				</div>

				<script>
					const commentWrite = () => {
						const writer = document.getElementById("commentWriter").value;
						const content = document.getElementById("commentContent").value;
						const no = "${content_view.boardNo}";

						if (!writer.trim()) {
							alert("작성자를 입력해주세요.");
							document.getElementById("commentWriter").focus();
							return;
						}

						if (!content.trim()) {
							alert("내용을 입력해주세요.");
							document.getElementById("commentContent").focus();
							return;
						}

						$.ajax({
							type: "post",
							data: {
								commentWriter: writer,
								commentContent: content,
								boardNo: no
							},
							url: "/comment/save",
							success: function (commentList) {
								console.log("댓글 작성 성공");

								// 댓글 입력 필드 초기화
								document.getElementById("commentWriter").value = "";
								document.getElementById("commentContent").value = "";

								// 댓글 수 업데이트
								document.getElementById("commentCount").textContent = commentList.length;

								// 댓글 목록 업데이트
								let output = "";
								for (let i in commentList) {
									const comment = commentList[i];
									output += `
                            <div class="comment-item fade-in">
                                <div class="comment-header">
                                    <span class="comment-author">${comment.commentWriter}</span>
                                    <span class="comment-date">${comment.commentCreatedTime}</span>
                                </div>
                                <div class="comment-content">
                                    ${comment.commentContent}
                                </div>
                                <div class="comment-actions">
                                    <button class="comment-action">
                                        <i class="fas fa-reply"></i> 답글
                                    </button>
                                    <button class="comment-action">
                                        <i class="fas fa-edit"></i> 수정
                                    </button>
                                    <button class="comment-action">
                                        <i class="fas fa-trash-alt"></i> 삭제
                                    </button>
                                </div>
                            </div>
                        `;
								}

								document.getElementById("comment-list").innerHTML = output;
							},
							error: function () {
								console.log("댓글 작성 실패");
								alert("댓글 작성에 실패했습니다. 잠시 후 다시 시도해주세요.");
							}
						});
					};
				</script>
				<script>
					$(document).ready(function () {
						// 즉시실행함수
						(function () {
							console.log("문서 로드 완료");
							var boardNo = "<c:out value='${content_view.boardNo}'/>";
							console.log("게시글 번호: " + boardNo);

							$.getJSON("/getFileList", { boardNo: boardNo }, function (arr) {
								console.log("첨부파일 목록:", arr);

								var str = "";

								$(arr).each(function (i, obj) {
									// 파일 크기 포맷팅
									var fileSize = "";
									if (obj.fileSize) {
										var size = obj.fileSize;
										if (size < 1024) {
											fileSize = size + " B";
										} else if (size < 1024 * 1024) {
											fileSize = (size / 1024).toFixed(1) + " KB";
										} else {
											fileSize = (size / (1024 * 1024)).toFixed(1) + " MB";
										}
									}

									// 파일 아이콘 결정
									var fileIcon = "fas fa-file";
									var fileExt = obj.fileName.split('.').pop().toLowerCase();

									if (obj.image) {
										fileIcon = "fas fa-file-image";
									} else if (['pdf'].includes(fileExt)) {
										fileIcon = "fas fa-file-pdf";
									} else if (['doc', 'docx'].includes(fileExt)) {
										fileIcon = "fas fa-file-word";
									} else if (['xls', 'xlsx'].includes(fileExt)) {
										fileIcon = "fas fa-file-excel";
									} else if (['ppt', 'pptx'].includes(fileExt)) {
										fileIcon = "fas fa-file-powerpoint";
									} else if (['zip', 'rar', '7z'].includes(fileExt)) {
										fileIcon = "fas fa-file-archive";
									} else if (['mp3', 'wav', 'ogg'].includes(fileExt)) {
										fileIcon = "fas fa-file-audio";
									} else if (['mp4', 'avi', 'mov'].includes(fileExt)) {
										fileIcon = "fas fa-file-video";
									} else if (['html', 'css', 'js'].includes(fileExt)) {
										fileIcon = "fas fa-file-code";
									}

									str += `
                            <li class="attachment-item" 
                                data-path="${obj.uploadPath}" 
                                data-uuid="${obj.uuid}" 
                                data-filename="${obj.fileName}" 
                                data-type="${obj.image}">
                                <div class="attachment-icon">
                                    <i class="${fileIcon}"></i>
                                </div>
                                <div class="attachment-info">
                                    <div class="attachment-name">${obj.fileName}</div>
                                    <div class="attachment-meta">
                                        ${fileSize ? fileSize + ' · ' : ''}업로드: ${obj.uploadDate || '날짜 정보 없음'}
                                    </div>
                                </div>
                        `;

									// 이미지인 경우 미리보기 추가
									if (obj.image) {
										var fileCallPath = obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName;
										str += `
                                <div class="attachment-preview">
                                    <img src="/display?fileName=${fileCallPath}" alt="미리보기">
                                </div>
                            `;
									}

									str += `</li>`;
								});

								$(".attachment-list").html(str);
							});

							// 첨부파일 클릭 이벤트
							$(".uploadResult").on("click", "li", function (e) {
								console.log("첨부파일 클릭");

								var liObj = $(this);  // <- 여기 잘못된 부분을 수정

								console.log("경로:", liObj.data("path"));
								console.log("UUID:", liObj.data("uuid"));
								console.log("파일명:", liObj.data("filename"));
								console.log("이미지 여부:", liObj.data("type"));

								var path = liObj.data("path") + "/" + liObj.data("uuid") + "_" + liObj.data("filename");
								console.log("전체 경로:", path);

								// 이미지일 때
								if (liObj.data("type")) {
									console.log("이미지 확대 보기");
									showImage(path);  // 이 함수는 별도로 정의되어 있어야 합니다.
								} else {
									console.log("파일 다운로드");
									// 컨트롤러의 download 호출
									self.location = "/download?fileName=" + path;
								}
							});

							// 이미지 확대 보기 함수
							function showImage(fileCallPath) {
								console.log("이미지 경로:", fileCallPath);

								$(".bigPicture").css("display", "flex").show();
								$(".bigPic").html("<img src='/display?fileName=" + fileCallPath + "'><button class='close-btn'><i class='fas fa-times'></i></button>")
									.animate({ width: "100%", height: "100%" }, 300);
							}

							// 확대 이미지 닫기
							$(".bigPicture").on("click", function (e) {
								if ($(e.target).is(".bigPicture") || $(e.target).is(".close-btn") || $(e.target).is(".fa-times")) {
									$(".bigPic").animate({ width: "0%", height: "0%" }, 300);
									setTimeout(function () {
										$(".bigPicture").hide();
									}, 300);
								}
							});

						})(); // 즉시실행함수 종료

						// 폼 제출 전 확인
						$("#actionForm").on("submit", function (e) {
							if ($(this).attr("action").includes("delete")) {
								if (!confirm("정말로 이 게시글을 삭제하시겠습니까?")) {
									e.preventDefault();
								}
							} else if ($(this).attr("action").includes("modify")) {
								// 필수 입력 필드 검증
								var title = $("#boardTitle").val().trim();
								var content = $("#boardContent").val().trim();

								if (!title) {
									alert("제목을 입력해주세요.");
									$("#boardTitle").focus();
									e.preventDefault();
									return false;
								}

								if (!content) {
									alert("내용을 입력해주세요.");
									$("#boardContent").focus();
									e.preventDefault();
									return false;
								}

								if (!confirm("게시글을 수정하시겠습니까?")) {
									e.preventDefault();
								}
							}
						});

						// 댓글 작성 엔터키 이벤트
						$("#commentContent").on("keypress", function (e) {
							if (e.which === 13 && !e.shiftKey) {
								e.preventDefault();
								commentWrite();
							}
						});
					});
				</script>
			</body>

			</html>