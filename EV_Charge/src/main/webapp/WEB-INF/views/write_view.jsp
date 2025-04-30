<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>게시글 작성 | EV충전소</title>
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
            --border-radius: 0.5rem;
            --shadow-sm: 0 1px 2px 0 rgba(0, 0, 0, 0.05);
            --shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.1), 0 1px 2px 0 rgba(0, 0, 0, 0.06);
            --shadow-md: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
            --shadow-lg: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
            --transition: all 0.2s ease;
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
            max-width: 900px;
            margin: 2rem auto;
            padding: 0 1.5rem;
        }
        
        .page-header {
            margin-bottom: 1.5rem;
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
            border-radius: var(--border-radius);
            box-shadow: var(--shadow-md);
            overflow: hidden;
            border: 1px solid var(--gray-200);
            transition: var(--transition);
        }
        
        .card:hover {
            box-shadow: var(--shadow-lg);
        }
        
        .card-header {
            background-color: var(--white);
            padding: 1.5rem 2rem;
            border-bottom: 1px solid var(--gray-200);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .card-header h2 {
            margin: 0;
            font-size: 1.25rem;
            font-weight: 600;
            color: var(--gray-800);
            display: flex;
            align-items: center;
        }
        
        .card-header h2 i {
            margin-right: 0.75rem;
            color: var(--primary-color);
        }
        
        .card-body {
            padding: 2rem;
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
            border-radius: var(--border-radius);
            font-family: inherit;
            font-size: 1rem;
            transition: var(--transition);
            color: var(--gray-800);
            background-color: var(--white);
        }
        
        .form-control:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px var(--primary-light);
        }
        
        textarea.form-control {
            resize: vertical;
            min-height: 200px;
        }
        
        .form-hint {
            margin-top: 0.5rem;
            font-size: 0.8rem;
            color: var(--gray-500);
            display: flex;
            align-items: center;
        }
        
        .form-hint i {
            margin-right: 0.375rem;
        }
        
        .btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 0.75rem 1.5rem;
            border-radius: var(--border-radius);
            font-size: 0.875rem;
            font-weight: 500;
            cursor: pointer;
            transition: var(--transition);
            text-decoration: none;
            border: none;
            box-shadow: var(--shadow-sm);
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
            box-shadow: var(--shadow);
        }
        
        .btn-secondary {
            background-color: var(--white);
            color: var(--gray-700);
            border: 1px solid var(--gray-300);
        }
        
        .btn-secondary:hover {
            background-color: var(--gray-100);
            transform: translateY(-1px);
            box-shadow: var(--shadow);
        }
        
        .btn-danger {
            background-color: var(--white);
            color: var(--red-500);
            border: 1px solid var(--red-500);
        }
        
        .btn-danger:hover {
            background-color: var(--red-500);
            color: var(--white);
            transform: translateY(-1px);
            box-shadow: var(--shadow);
        }
        
        .btn-group {
            display: flex;
            gap: 0.75rem;
            margin-top: 2rem;
        }
        
        .section-title {
            font-size: 1.125rem;
            font-weight: 600;
            color: var(--gray-800);
            margin-bottom: 1.25rem;
            display: flex;
            align-items: center;
            padding-bottom: 0.75rem;
            border-bottom: 1px solid var(--gray-200);
        }
        
        .section-title i {
            margin-right: 0.75rem;
            color: var(--primary-color);
        }
        
        .file-upload {
            margin-top: 2.5rem;
        }
        
        .upload-area {
            position: relative;
            margin-bottom: 1.5rem;
            border: 2px dashed var(--gray-300);
            border-radius: var(--border-radius);
            padding: 2rem;
            text-align: center;
            background-color: var(--gray-50);
            transition: var(--transition);
            cursor: pointer;
        }
        
        .upload-area:hover {
            border-color: var(--primary-color);
            background-color: var(--primary-light);
        }
        
        .upload-icon {
            font-size: 2.5rem;
            color: var(--gray-400);
            margin-bottom: 1rem;
            transition: var(--transition);
        }
        
        .upload-area:hover .upload-icon {
            color: var(--primary-color);
        }
        
        .upload-text {
            font-size: 1rem;
            color: var(--gray-600);
            margin-bottom: 0.5rem;
        }
        
        .upload-hint {
            font-size: 0.8rem;
            color: var(--gray-500);
        }
        
        .upload-input {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            opacity: 0;
            cursor: pointer;
        }
        
        .upload-preview {
            margin-top: 1.5rem;
            background-color: var(--white);
            border-radius: var(--border-radius);
            box-shadow: var(--shadow);
            overflow: hidden;
            border: 1px solid var(--gray-200);
        }
        
        .preview-header {
            padding: 1rem 1.5rem;
            background-color: var(--gray-50);
            border-bottom: 1px solid var(--gray-200);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .preview-title {
            font-size: 0.875rem;
            font-weight: 600;
            color: var(--gray-700);
            display: flex;
            align-items: center;
        }
        
        .preview-title i {
            margin-right: 0.5rem;
            color: var(--primary-color);
        }
        
        .preview-count {
            font-size: 0.75rem;
            color: var(--gray-500);
            background-color: var(--gray-100);
            padding: 0.25rem 0.5rem;
            border-radius: 9999px;
        }
        
        .preview-body {
            padding: 1.5rem;
        }
        
        .preview-list {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(150px, 1fr));
            gap: 1rem;
            margin: 0;
            padding: 0;
        }
        
        .preview-item {
            list-style: none;
            background-color: var(--white);
            border: 1px solid var(--gray-200);
            border-radius: var(--border-radius);
            overflow: hidden;
            position: relative;
            transition: var(--transition);
        }
        
        .preview-item:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-md);
        }
        
        .preview-item-content {
            padding: 0.75rem;
        }
        
        .preview-item-name {
            font-size: 0.75rem;
            color: var(--gray-700);
            margin-bottom: 0.5rem;
            word-break: break-all;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
            text-overflow: ellipsis;
            height: 2.4em;
        }
        
        .preview-item-thumbnail {
            width: 100%;
            height: 100px;
            object-fit: cover;
            border-radius: 0.25rem;
            background-color: var(--gray-100);
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .preview-item-thumbnail img {
            max-width: 100%;
            max-height: 100%;
            object-fit: contain;
        }
        
        .preview-item-remove {
            position: absolute;
            top: 0.25rem;
            right: 0.25rem;
            width: 1.5rem;
            height: 1.5rem;
            background-color: rgba(239, 68, 68, 0.8);
            color: var(--white);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            font-size: 0.75rem;
            transition: var(--transition);
            z-index: 10;
        }
        
        .preview-item-remove:hover {
            background-color: var(--red-600);
            transform: scale(1.1);
        }
        
        .preview-item-type {
            position: absolute;
            bottom: 0.25rem;
            left: 0.25rem;
            font-size: 0.625rem;
            padding: 0.125rem 0.375rem;
            border-radius: 0.25rem;
            background-color: rgba(0, 0, 0, 0.5);
            color: var(--white);
        }
        
        .preview-empty {
            text-align: center;
            padding: 2rem;
            color: var(--gray-500);
        }
        
        .preview-empty i {
            font-size: 2rem;
            margin-bottom: 0.75rem;
            color: var(--gray-400);
        }
        
        .preview-empty p {
            font-size: 0.875rem;
        }
        
        .category-select {
            display: flex;
            gap: 1rem;
            margin-bottom: 1.5rem;
            flex-wrap: wrap;
        }
        
        .category-option {
            flex: 1;
            min-width: 120px;
        }
        
        .category-option input[type="radio"] {
            display: none;
        }
        
        .category-option label {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            padding: 1rem;
            background-color: var(--white);
            border: 1px solid var(--gray-300);
            border-radius: var(--border-radius);
            cursor: pointer;
            transition: var(--transition);
            text-align: center;
        }
        
        .category-option label:hover {
            border-color: var(--primary-color);
            background-color: var(--primary-light);
        }
        
        .category-option input[type="radio"]:checked + label {
            border-color: var(--primary-color);
            background-color: var(--primary-light);
            box-shadow: 0 0 0 3px var(--primary-light);
        }
        
        .category-icon {
            font-size: 1.5rem;
            margin-bottom: 0.5rem;
            color: var(--gray-500);
            transition: var(--transition);
        }
        
        .category-option label:hover .category-icon,
        .category-option input[type="radio"]:checked + label .category-icon {
            color: var(--primary-color);
        }
        
        .category-name {
            font-size: 0.875rem;
            font-weight: 500;
            color: var(--gray-700);
        }
        
        /* 애니메이션 */
        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }
        
        @keyframes slideIn {
            from { transform: translateY(10px); opacity: 0; }
            to { transform: translateY(0); opacity: 1; }
        }
        
        .fade-in {
            animation: fadeIn 0.3s ease-out forwards;
        }
        
        .slide-in {
            animation: slideIn 0.3s ease-out forwards;
        }
        
        /* 반응형 디자인 */
        @media (max-width: 768px) {
            .card-header, .card-body {
                padding: 1.5rem;
            }
            
            .btn-group {
                flex-direction: column;
            }
            
            .btn {
                width: 100%;
            }
            
            .preview-list {
                grid-template-columns: repeat(auto-fill, minmax(120px, 1fr));
            }
            
            .category-select {
                flex-direction: column;
            }
            
            .category-option {
                width: 100%;
            }
        }
    </style>
    <script src="${pageContext.request.contextPath}/js/jquery.js"></script>
</head>
<body>
    <jsp:include page="/WEB-INF/views/header.jsp" />
    
    <div class="container">
        <div class="page-header fade-in">
            <h1 class="page-title"><i class="fas fa-edit"></i> 게시글 작성</h1>
            <p class="page-description">EV충전소 커뮤니티에 새로운 글을 작성해보세요.</p>
        </div>
        
        <div class="card slide-in">
            <div class="card-header">
                <h2><i class="fas fa-pen-to-square"></i> 새 게시글</h2>
            </div>
            <div class="card-body">
                <form id="frm" method="post" action="write">
                    <h3 class="section-title"><i class="fas fa-tag"></i> 카테고리 선택</h3>
                    <div class="category-select">
                        <div class="category-option">
                            <input type="radio" name="boardCategory" id="category-general" value="general" checked>
                            <label for="category-general">
                                <i class="fas fa-comments category-icon"></i>
                                <span class="category-name">일반 게시글</span>
                            </label>
                        </div>
                        <div class="category-option">
                            <input type="radio" name="boardCategory" id="category-question" value="question">
                            <label for="category-question">
                                <i class="fas fa-question-circle category-icon"></i>
                                <span class="category-name">질문</span>
                            </label>
                        </div>
                        <div class="category-option">
                            <input type="radio" name="boardCategory" id="category-review" value="review">
                            <label for="category-review">
                                <i class="fas fa-star category-icon"></i>
                                <span class="category-name">충전소 리뷰</span>
                            </label>
                        </div>
                        <div class="category-option">
                            <input type="radio" name="boardCategory" id="category-info" value="info">
                            <label for="category-info">
                                <i class="fas fa-info-circle category-icon"></i>
                                <span class="category-name">정보 공유</span>
                            </label>
                        </div>
                    </div>
                    
                    <h3 class="section-title"><i class="fas fa-align-left"></i> 게시글 정보</h3>
                    <div class="form-group">
                        <label for="boardName" class="form-label">작성자</label>
                        <input type="text" id="boardName" name="boardName" class="form-control" placeholder="이름을 입력하세요" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="boardTitle" class="form-label">제목</label>
                        <input type="text" id="boardTitle" name="boardTitle" class="form-control" placeholder="제목을 입력하세요" required>
                        <div class="form-hint">
                            <i class="fas fa-info-circle"></i>
                            <span>명확하고 구체적인 제목을 작성하면 더 많은 관심을 받을 수 있습니다.</span>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label for="boardContent" class="form-label">내용</label>
                        <textarea id="boardContent" name="boardContent" class="form-control" placeholder="내용을 입력하세요" required></textarea>
                    </div>
                    
                    <div class="file-upload">
                        <h3 class="section-title"><i class="fas fa-paperclip"></i> 파일 첨부</h3>
                        
                        <div class="upload-area">
                            <div class="upload-icon">
                                <i class="fas fa-cloud-upload-alt"></i>
                            </div>
                            <div class="upload-text">파일을 여기에 끌어다 놓거나 클릭하여 업로드</div>
                            <div class="upload-hint">최대 5MB, 지원 형식: JPG, PNG, GIF, PDF, DOC, DOCX, XLS, XLSX, ZIP</div>
                            <input type="file" name="uploadFile" multiple class="upload-input">
                        </div>
                        
                        <div class="upload-preview">
                            <div class="preview-header">
                                <div class="preview-title">
                                    <i class="fas fa-file-alt"></i>
                                    <span>첨부된 파일</span>
                                </div>
                                <div class="preview-count">0개</div>
                            </div>
                            <div class="preview-body">
                                <div class="uploadResult">
                                    <ul class="preview-list"></ul>
                                    <div class="preview-empty">
                                        <i class="fas fa-file-upload"></i>
                                        <p>아직 첨부된 파일이 없습니다.</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="btn-group">
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-paper-plane"></i> 게시글 등록
                        </button>
                        <a href="list" class="btn btn-secondary">
                            <i class="fas fa-list"></i> 목록으로 돌아가기
                        </a>
                        <button type="reset" class="btn btn-danger">
                            <i class="fas fa-trash-alt"></i> 초기화
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    
    <script>
        $(document).ready(function (e){
            var formObj = $("form[id='frm']");
            var fileCount = 0;
            
            // 파일 업로드 영역 클릭 시 파일 선택 창 열기
            $(".upload-area").on("click", function() {
                $(".upload-input").trigger("click");
            });
            
            // 드래그 앤 드롭 기능
            $(".upload-area").on("dragover", function(e) {
                e.preventDefault();
                $(this).addClass("active");
            });
            
            $(".upload-area").on("dragleave", function(e) {
                e.preventDefault();
                $(this).removeClass("active");
            });
            
            $(".upload-area").on("drop", function(e) {
                e.preventDefault();
                $(this).removeClass("active");
                
                var files = e.originalEvent.dataTransfer.files;
                $("input[name='uploadFile']")[0].files = files;
                $("input[name='uploadFile']").change();
            });

            // 폼 제출 처리
            $("button[type='submit']").on("click", function (e) {
                e.preventDefault();
                
                // 필수 입력 확인
                var name = $("#boardName").val().trim();
                var title = $("#boardTitle").val().trim();
                var content = $("#boardContent").val().trim();
                
                if (!name) {
                    alert("작성자 이름을 입력해주세요.");
                    $("#boardName").focus();
                    return;
                }
                
                if (!title) {
                    alert("제목을 입력해주세요.");
                    $("#boardTitle").focus();
                    return;
                }
                
                if (!content) {
                    alert("내용을 입력해주세요.");
                    $("#boardContent").focus();
                    return;
                }
                
                console.log("게시글 등록");

                var str = "";

                $(".uploadResult ul li").each(function (i, obj) {
                    var jobj = $(obj);

                    str += "<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
                    str += "<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
                    str += "<input type='hidden' name='attachList["+i+"].uploadPath' value='"+jobj.data("path")+"'>";
                    str += "<input type='hidden' name='attachList["+i+"].image' value='"+jobj.data("type")+"'>";
                });

                formObj.append(str).submit();
            });

            // 파일 확장자 및 크기 검사
            var regex = new RegExp("(.*?)\.(exe|sh|alz)$");
            var maxSize = 5242880; // 5MB

            function checkExtension(fileName, fileSize) {
                if(fileSize >= maxSize){
                    alert("파일 크기가 5MB를 초과하여 업로드할 수 없습니다.");
                    return false;
                }
                if (regex.test(fileName)) {
                    alert("해당 종류의 파일은 보안상의 이유로 업로드할 수 없습니다.");
                    return false;
                }
                return true;
            }

            // 파일 업로드 처리
            $("input[type='file']").change(function (e){
                var formData = new FormData();
                var inputFile = $("input[name='uploadFile']");
                var files = inputFile[0].files;
                
                if(files.length === 0) {
                    return;
                }

                for(var i=0; i<files.length; i++){
                    if (!checkExtension(files[i].name, files[i].size)) {
                        return false;
                    }
                    formData.append("uploadFile", files[i]);
                }

                $.ajax({
                    type: "post",
                    data: formData,
                    url: "uploadAjaxAction",
                    processData: false,
                    contentType: false,
                    beforeSend: function() {
                        // 로딩 표시
                        $(".upload-icon i").removeClass("fa-cloud-upload-alt").addClass("fa-spinner fa-spin");
                        $(".upload-text").text("파일 업로드 중...");
                    },
                    success: function (result) {
                        console.log(result);
                        $(".upload-icon i").removeClass("fa-spinner fa-spin").addClass("fa-cloud-upload-alt");
                        $(".upload-text").text("파일을 여기에 끌어다 놓거나 클릭하여 업로드");
                        
                        // 파일 업로드 성공 알림
                        alert("파일이 성공적으로 업로드되었습니다.");
                        
                        // 파일 목록 표시
                        showUploadResult(result);
                        
                        // 파일 입력 초기화
                        inputFile.val("");
                    },
                    error: function() {
                        alert("파일 업로드 중 오류가 발생했습니다. 다시 시도해주세요.");
                        $(".upload-icon i").removeClass("fa-spinner fa-spin").addClass("fa-cloud-upload-alt");
                        $(".upload-text").text("파일을 여기에 끌어다 놓거나 클릭하여 업로드");
                    }
                });
            });

            // 업로드 결과 표시
            function showUploadResult(uploadResultArr) {
                if (!uploadResultArr || uploadResultArr.length == 0) {
                    return;
                }

                var uploadUL = $(".uploadResult ul");
                var str = "";
                
                // 첨부파일 목록 표시
                $(uploadResultArr).each(function (i, obj) {
                    // 빈 상태 메시지 숨기기
                    $(".preview-empty").hide();
                    
                    // 파일 카운트 업데이트
                    fileCount++;
                    $(".preview-count").text(fileCount + "개");
                    
                    // 이미지 파일인 경우
                    if (obj.image) {
                        var fileCallPath = obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName;
                        
                        str += "<li class='preview-item' data-path='" + obj.uploadPath + "' ";
                        str += "data-uuid='" + obj.uuid + "' data-filename='" + obj.fileName + "' data-type='" + obj.image + "'>";
                        str += "<div class='preview-item-thumbnail'>";
                        str += "<img src='/display?fileName=" + fileCallPath + "' alt='미리보기'>";
                        str += "</div>";
                        str += "<div class='preview-item-content'>";
                        str += "<div class='preview-item-name'>" + obj.fileName + "</div>";
                        str += "</div>";
                        str += "<span class='preview-item-type'>이미지</span>";
                        str += "<button type='button' class='preview-item-remove' data-file='" + fileCallPath + "' data-type='image'>";
                        str += "<i class='fas fa-times'></i></button>";
                        str += "</li>";
                    } else {
                        // 일반 파일인 경우
                        var fileCallPath = obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName;
                        var fileIcon = getFileIcon(obj.fileName);
                        
                        str += "<li class='preview-item' data-path='" + obj.uploadPath + "' ";
                        str += "data-uuid='" + obj.uuid + "' data-filename='" + obj.fileName + "' data-type='" + obj.image + "'>";
                        str += "<div class='preview-item-thumbnail'>";
                        str += "<i class='" + fileIcon + "' style='font-size: 2.5rem; color: var(--gray-500);'></i>";
                        str += "</div>";
                        str += "<div class='preview-item-content'>";
                        str += "<div class='preview-item-name'>" + obj.fileName + "</div>";
                        str += "</div>";
                        str += "<span class='preview-item-type'>파일</span>";
                        str += "<button type='button' class='preview-item-remove' data-file='" + fileCallPath + "' data-type='file'>";
                        str += "<i class='fas fa-times'></i></button>";
                        str += "</li>";
                    }
                });
                
                uploadUL.append(str);
            }
            
            // 파일 타입에 따른 아이콘 선택
            function getFileIcon(fileName) {
                var ext = fileName.split('.').pop().toLowerCase();
                
                if(['pdf'].includes(ext)) {
                    return 'fas fa-file-pdf';
                } else if(['doc', 'docx'].includes(ext)) {
                    return 'fas fa-file-word';
                } else if(['xls', 'xlsx'].includes(ext)) {
                    return 'fas fa-file-excel';
                } else if(['ppt', 'pptx'].includes(ext)) {
                    return 'fas fa-file-powerpoint';
                } else if(['zip', 'rar', '7z'].includes(ext)) {
                    return 'fas fa-file-archive';
                } else if(['mp3', 'wav', 'ogg'].includes(ext)) {
                    return 'fas fa-file-audio';
                } else if(['mp4', 'avi', 'mov'].includes(ext)) {
                    return 'fas fa-file-video';
                } else if(['html', 'css', 'js'].includes(ext)) {
                    return 'fas fa-file-code';
                } else {
                    return 'fas fa-file-alt';
                }
            }

            // 첨부파일 삭제
            $(".uploadResult").on("click", ".preview-item-remove", function(e) {
                e.preventDefault();
                
                var targetFile = $(this).data("file");
                var type = $(this).data("type");
                var targetLi = $(this).closest("li");
                
                $.ajax({
                    type: "post",
                    data: {fileName: targetFile, type: type},
                    url: "deleteFile",
                    dataType: "text",
                    success: function(result) {
                        alert("파일이 삭제되었습니다.");
                        targetLi.remove();
                        
                        // 파일 카운트 업데이트
                        fileCount--;
                        $(".preview-count").text(fileCount + "개");
                        
                        // 첨부파일이 없는 경우 빈 상태 메시지 표시
                        if(fileCount === 0) {
                            $(".preview-empty").show();
                        }
                    }
                });
            });
            
            // 폼 초기화 버튼
            $("button[type='reset']").on("click", function(e) {
                e.preventDefault();
                
                if(confirm("작성 중인 내용이 모두 초기화됩니다. 계속하시겠습니까?")) {
                    // 폼 필드 초기화
                    $("#boardName").val("");
                    $("#boardTitle").val("");
                    $("#boardContent").val("");
                    $("input[name='boardCategory'][value='general']").prop("checked", true);
                    
                    // 첨부파일 모두 삭제
                    $(".preview-item").each(function() {
                        var targetFile = $(this).find(".preview-item-remove").data("file");
                        var type = $(this).find(".preview-item-remove").data("type");
                        
                        $.ajax({
                            type: "post",
                            data: {fileName: targetFile, type: type},
                            url: "deleteFile",
                            async: false
                        });
                    });
                    
                    // 첨부파일 목록 초기화
                    $(".uploadResult ul").empty();
                    $(".preview-empty").show();
                    fileCount = 0;
                    $(".preview-count").text("0개");
                }
            });
        });
    </script>
</body>
</html>
