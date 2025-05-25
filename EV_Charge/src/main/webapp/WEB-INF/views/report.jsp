<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <!-- 헤더 -->
    <jsp:include page="/WEB-INF/views/header.jsp"/>

    <div class="report-container" style="max-width:600px; margin:0 auto; border:1px solid #ccc; padding:20px; border-radius:10px;">
    <!-- 히든 사용자 ID -->
    <input type="hidden" id="userId" value="12345" />

    <!-- 닉네임 -->
    <div class="form-group mb-3">
        <label for="nickname">닉네임</label>
        <input type="text" id="nickname" class="form-control" value="백경흠" readonly />
    </div>

    <!-- 신고 유형 -->
    <div class="form-group mb-3">
        <label for="reportType">신고 유형</label>
        <select id="reportType" class="form-select">
	        <option value="정보 오류">정보 오류</option>
	        <option value="이용 불가">이용 불가</option>
	        <option value="기타">기타</option>
        </select>
    </div>

    <!-- 제목 -->
    <div class="form-group mb-3">
        <label for="reportTitle">제목 (간단하게 요약해 주세요)</label>
        <input type="text" id="reportTitle" class="form-control" placeholder="예: 위치가 실제랑 달라요" />
    </div>

    <!-- 상세 내용 -->
    <div class="form-group mb-3">
        <label for="reportContent">내용</label>
        <textarea id="reportContent" rows="5" class="form-control" placeholder="불편사항이나 수정할 내용을 자세히 적어주세요."></textarea>
    </div>

    <!-- 신고 버튼 -->
    <div style="text-align:right;">
        <button id="submitReportBtn" class="btn btn-danger">🚨 신고하기</button>
    </div>
</div>

</body>
</html>