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
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/write_view.css">
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
