<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/station_detail.css">
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=109dd4a6fbdf108d896544146388b47e&libraries=services"></script>
<div id="station-detail-sidebar" class="station-sidebarA">
    <div class="sidebar-header">
        <div class="sidebar-title">
            <i class="fas fa-charging-station"></i>
            <h3>충전소 상세 정보</h3>
        </div>
        <div class="sidebar-actions">
            <button id="back-to-list" class="action-btn" title="목록으로">
                <i class="fas fa-arrow-left"></i>
            </button>
            <button id="close-detail-sidebar" class="action-btn" title="닫기">
                <i class="fas fa-times"></i>
            </button>
        </div>
    </div>
    
    <div class="sidebar-content">
        <div class="station-detail-container">
            
            <!-- 충전소 기본 정보 -->
            <div class="detail-section">
                <div class="station-header">
                    <h2 id="station-name" class="station-title"></h2>
                    <button id="station-detail-favorite-btn" class="favorite-toggle-btn" data-stat-id="" style="border: none; background-color: white;">
					    <span class="star-icon">☆</span>
					</button>
                </div>
                
                <div class="station-address-container">
                    <i class="fas fa-map-marker-alt"></i>
                    <p id="station-address" class="station-address"></p>
                </div>
                
                <form id="routeForm" method="get" action="${pageContext.request.contextPath}/findpath">
                    <input type="hidden" id="startLat" name="startLat">
                    <input type="hidden" id="startLng" name="startLng">
                    <input type="hidden" id="station_lat" name="endLat">
                    <input type="hidden" id="station_lng" name="endLng">
                </form>
                <input type="hidden" id="stat_id" name="stat_id">

                <div class="action-buttons">
                    <button class="action-button primary" id="findpathBtn">
                        <i class="fas fa-directions"></i>
                        <span>길찾기</span>
                    </button>
                    <button class="action-button secondary" onclick="reservationStation()">
                        <i class="fas fa-calendar-alt"></i>
                        <span>예약하기</span>
                    </button>
                </div>
                
            </div>
            
            <!-- 충전기 정보 -->
            <div class="detail-section">
                <h3 class="section-title">
                    <i class="fas fa-plug"></i>
                    <span>충전기 정보</span><span>충전기 사용 현황</span>
                </h3>
                
                <div class="charger-info" id="charger-info">
                    <div class="charger-type rapid_div">
                        <div class="charger-icon fast">
                            <i class="fas fa-bolt"></i>
                        </div>
                        <div class="charger-details">
                            <h4>급속 충전기</h4>
                            <p id="fast-charger-count"><strong id="strong_rapid"></strong>대<br>사용가능: <strong id="rapid_count"></strong></p>
                        </div>
                    </div>
                    
                    <div class="charger-type slow_div">
                        <div class="charger-icon slow">
                            <i class="fas fa-battery-half"></i>
                        </div>
                        <div class="charger-details">
                            <h4>완속 충전기</h4>
                            <p id="slow-charger-count"><strong id="strong_slow"></strong>대<br>사용가능: <strong id="slow_count"></strong></p>
                        </div>
                    </div>
                </div>
                
            </div>
            
            <!-- 지원 차종 정보 -->
            <!-- 충전 가능 자리 정보 -->
            <div class="detail-section">
                <h3 class="section-title">
                    <i class="fas fa-car"></i>
                    <!-- <span>지원 차종</span> -->
                    <span>충전기 타입</span>
                </h3>
                
                <div id="supported-vehicles" class="supported-vehicles">
                    <!-- <div class="vehicle-chip">현대</div>-->
                    <div class="charger-type rapid_div">
                        <div class="charger-icon fast">
                            <i class="fas fa-bolt"></i>
                        </div>
                        <div class="charger-details">
                            <h4>급속</h4>
                            <p class="type_block" id="fast-charger-count"><strong id="rapid_type"></strong></p>
                        </div>
                    </div>

                    <div class="charger-type slow_div">
                        <div class="charger-icon slow">
                            <i class="fas fa-battery-half"></i>
                        </div>
                        <div class="charger-details">
                            <h4>완속</h4>
                            <p class="type_block" id="slow-charger-count"><strong id="slow_type"></strong></p>
                        </div>
                    </div>
                </div>
            </div>
            
            </div>
            
            <!-- 운영 정보 -->
            <div class="detail-section">
                <h3 class="section-title">
                    <i class="fas fa-info-circle"></i>
                    <span>운영 정보</span>
                </h3>
                
                <div class="operation-info">
                    <div class="info-item">
                        <div class="info-label">운영 시간</div>
                        <div id="operation-hours" class="info-value"></div>
                    </div>
                    <div class="info-item">
                        <div class="info-label">주차 요금</div>
                        <div id="parking_free" class="info-value"></div>
                    </div>
                    <div class="info-item">
                        <div class="info-label">운영 기관</div>
                        <div id="operation-agency" class="info-value"></div>
                    </div>
                    <div class="info-item">
                        <div class="info-label">연락처</div>
                        <div id="contact-number" class="info-value"></div>
                    </div>
                    <!-- <div class="info-item">
                        <div class="info-label">최근 업데이트</div>
                        <div id="last-updated" class="info-value">2023-10-25 14:30</div>
                    </div> -->
                </div>
            </div>
        </div>
    <div class="sidebar-footer">
        <button id="report-issue" class="report-btn">
            <i class="fas fa-chart-line"></i>
            <span>실시간 분석하기</span>
        </button>
    </div>
</div>
<script>
	
	
    // ------------------- 여기 추가됨 ---------------------------
	window.currentStationFullDataForFavorite = {};
    // ------------------- 여기 추가됨 ---------------------------

    document.addEventListener('DOMContentLoaded', function() {
        // 사이드바 토글
        const sidebar = document.getElementById('station-detail-sidebar');
        const closeSidebarBtn = document.getElementById('close-detail-sidebar');
        const backToListBtn = document.getElementById('back-to-list');
        
        // 사이드바 열기 함수 (외부에서 호출 가능)
        window.openDetailSidebar = function(stationData) {
            sidebar.classList.add('active');
        };
        
        // 사이드바 닫기
        closeSidebarBtn.addEventListener('click', function() {
            sidebar.classList.remove('active');
        });
        
        // 목록으로 돌아가기
        backToListBtn.addEventListener('click', function() {
            sidebar.classList.remove('active');
            // 목록 사이드바 열기 로직 (필요한 경우)
            if (window.openSidebar) {
                window.openSidebar();
            }
        });
        // ---------------- 추가됨 -------------------
		const favButton = document.getElementById('station-detail-favorite-btn');
		    if (favButton) {
		        favButton.addEventListener('click', function() {
		            const userNo = window.APP_USER_NO; // main.jsp의 전역 변수 
		            const statId = this.getAttribute('data-stat-id');
                    console.log(userNo);
					console.log('[Station Detail] 클릭 시 window.APP_USER_NO 값:', window.APP_USER_NO);
					console.log('[Station Detail] userNo 변수 값:', userNo, '(타입:', typeof userNo, ')');

		            if (!userNo) {
		                alert("로그인이 필요합니다.");
		                return;
		            }

		            if (!statId) {
		                alert("충전소 ID를 찾을 수 없습니다.");
		                return;
		            }

		            if (!window.currentStationFullDataForFavorite || window.currentStationFullDataForFavorite.stat_id !== statId) {
		                alert("충전소 상세 정보가 올바르게 로드되지 않았습니다. 다시 시도해주세요.");
		                console.error("statId에 대한 currentStationFullDataForFavorite 불일치 또는 누락:", statId, window.currentStationFullDataForFavorite);
		                return;
		            }
					

		            const payload = {
		                user_no: userNo,
		                stat_id: statId,
						stat_name: window.currentStationFullDataForFavorite.stat_name,
		                addr: window.currentStationFullDataForFavorite.addr,
		                addr_detail: window.currentStationFullDataForFavorite.addr_detail,
		                location: window.currentStationFullDataForFavorite.location,
		                lat: window.currentStationFullDataForFavorite.lat,
		                lng: window.currentStationFullDataForFavorite.lng
		            };
		            
					console.log("즐겨찾기 토글 요청 payload:", payload); // 전송될 데이터 확인
					
		            $.ajax({
		                url: (window.myApp && window.myApp.contextPath ? window.myApp.contextPath : '') + "/favorites/toggle",
		                method: "POST",
		                contentType: "application/json",
		                data: JSON.stringify(payload),
		                success: function(response) {
		                    alert(response.message);
		                    if (response.status === 'success') {
		                        const starIcon = favButton.querySelector('.star-icon');
		                        if (response.action === 'added') {
		                            favButton.classList.add('favorited');
		                            starIcon.textContent = '⭐'; // 채워진 별
		                            favButton.childNodes[1].nodeValue = " 즐겨찾기됨";
									
		                            if (window.userFavoriteStationIds) {
										window.userFavoriteStationIds.add(statId)
									};
		                        } else if (response.action === 'removed') {
		                            favButton.classList.remove('favorited');
		                            starIcon.textContent = '☆'; // 빈 별
		                            favButton.childNodes[1].nodeValue = " 즐겨찾기";
		                            if (window.userFavoriteStationIds) {
										window.userFavoriteStationIds.delete(statId)
									};
		                        }
		                    }
		                },
		                error: function(jqXHR, textStatus, errorThrown) {
		                    console.error("즐겨찾기 토글 오류:", textStatus, errorThrown, jqXHR.responseText);
		                    let errorMsg = "즐겨찾기 처리 중 오류가 발생했습니다.";
		                    if (jqXHR.responseJSON && jqXHR.responseJSON.message) {
		                        errorMsg = jqXHR.responseJSON.message;
		                    }
		                    alert(errorMsg);
		                }
		            });
		        });
		    } else {
		        console.error("DOMContentLoaded 실행 중 ID가 'station-detail-favorite-btn'인 즐겨찾기 버튼을 찾지 못했습니다.");
		    }
		// ---------------- 추가됨 -------------------

    });


    document.getElementById('findpathBtn').addEventListener('click', function () {
        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(function (position) {
                document.getElementById('startLat').value = position.coords.latitude;
                document.getElementById('startLng').value = position.coords.longitude;
                document.getElementById('routeForm').submit();
                findpathAddActive();
            }, function () {
                alert("현재 위치를 가져올 수 없습니다.");
            });
        } else {
            alert("이 브라우저는 위치 기능을 지원하지 않습니다.");
        }
    });

	$(document).on("click", "#close-reservation", function () {
        $(".reservation-sidebar").removeClass("active");
    });
	// // 마커 클릭
	// function updateStationDetail(markerData) {
    //     var name = markerData.name;
    //     var address = markerData.address;
    //     var lat = markerData.lat;
    //     var lng = markerData.lng;
    //     var rapid = markerData.rapid;
    //     var slow = markerData.slow;
    //     var cars = markerData.car;

    //     document.getElementById("station-name").textContent = name;
    //     document.getElementById("station-address").textContent = address;
    //     // document.getElementById("station_lat").textContent = lat;
    //     // document.getElementById("station_lng").textContent = lng;
    //     document.getElementById("strong_rapid").textContent = rapid;
    //     document.getElementById("strong_slow").textContent = slow;
    
    //     // document.getElementById("supported-vehicles").textContent = car;
    //     const car_list = cars.split(",");
    //     console.log(car_list);
		
    //     document.getElementById("supported-vehicles").textContent = "";
    //     for(let car of car_list){
    //         document.getElementById("supported-vehicles").innerHTML += `<div class="vehicle-chip">`+car+`</div>`;
    //         //document.getElementById("supported-vehicles").innerHTML += `<div class="vehicle-chip">${car}</div>`;
	// 	}
    // }

    function updateStationDetailTwo(markerData) {
	    const first = markerData.chargerList[0]; // FavoriteDTO 객체
	    console.log("Received FavoriteDTO for detail view (first):", JSON.stringify(first, null, 2));

	    // 즐겨찾기용 데이터 설정
	    window.currentStationFullDataForFavorite = {
	        stat_id: first.stat_id,
	        addr: first.addr, // SQL에서 MAX(ecd.addr)로 가져온 최신 주소
	        addr_detail: (first.addr_detail && first.addr_detail !== "null" && first.addr_detail !== "undefined") ? first.addr_detail : null,
	        location: (first.location && first.location !== "null" && first.location !== "undefined") ? first.location : null,
	        lat: parseFloat(first.lat),
	        lng: parseFloat(first.lng)
	    };

	    // Hidden input
	    $("#station_lat").val(first.lat);
	    $("#station_lng").val(first.lng);
        $("#stat_id").val(first.stat_id);
	    // 이름
	    document.getElementById("station-name").textContent = first.stat_name || "정보 없음";

	    // 주소
	    let addressHtml = first.addr || "";
	    if (first.addr_detail && first.addr_detail !== "null" && first.addr_detail !== "undefined") {
	        addressHtml += (addressHtml ? "<br>" : "") + first.addr_detail;
	    }
	    if (first.location && first.location !== "null" && first.location !== "undefined" && first.location !== first.addr_detail) {
	        addressHtml += (addressHtml ? "<br>" : "") + first.location;
	    }
	    document.getElementById("station-address").innerHTML = addressHtml || "주소 정보 없음";

	    // --- 충전기 정보 (FavoriteDTO에서 직접 모든 정보 가져오기) ---
	    const totalRapidChargers = first.fastChargerCount || 0;
	    const availableRapidChargers = first.availableFastChargers || 0;
	    const rapidTypeInfoFromDTO = first.fastChargerTypeInfo || "정보 없음";

	    const totalSlowChargers = first.slowChargerCount || 0;
	    const availableSlowChargers = first.availableSlowChargers || 0;
	    const slowTypeInfoFromDTO = first.slowChargerTypeInfo || "정보 없음";

	    console.log("DTO Values - Total Rapid:", totalRapidChargers, "Available Rapid:", availableRapidChargers, "Type:", rapidTypeInfoFromDTO);
	    console.log("DTO Values - Total Slow:", totalSlowChargers, "Available Slow:", availableSlowChargers, "Type:", slowTypeInfoFromDTO);

	    // 총 급속 충전기 대수 및 사용 가능 대수 표시
	    if (totalRapidChargers === 0 && totalSlowChargers === 0) { // 아예 충전기 정보가 없으면 두 div 모두 숨김 (선택적)
	         $(".rapid_div").parent().css("display", "none"); // 부모인 charger-info div를 숨김
	    } else {
	         $(".rapid_div").parent().css("display", "");
	        if (totalRapidChargers === 0) {
	            $(".rapid_div").css("display", "none");
	        } else {
	            $(".rapid_div").css("display", "");
	            document.getElementById("strong_rapid").textContent = totalRapidChargers;
	            document.getElementById("rapid_count").textContent = availableRapidChargers;
	            document.getElementById("rapid_type").textContent = rapidTypeInfoFromDTO;
	        }

	        if (totalSlowChargers === 0) {
	            $(".slow_div").css("display", "none");
	        } else {
	            $(".slow_div").css("display", "");
	            document.getElementById("strong_slow").textContent = totalSlowChargers;
	            document.getElementById("slow_count").textContent = availableSlowChargers;
	            document.getElementById("slow_type").textContent = slowTypeInfoFromDTO;
	        }
	    }


	    // 운영 정보
	    let parking_free_text;
	    if (first.parking_free === 'Y') {
	        parking_free_text = "요금 없음";
	    } else if (first.parking_free === 'N') {
	        parking_free_text = "요금 있음";
	    } else {
	        parking_free_text = first.parking_free || "정보 없음";
	    }
	    document.getElementById("operation-hours").textContent = first.use_time || "정보 없음";
	    document.getElementById("parking_free").textContent = parking_free_text;
	    document.getElementById("operation-agency").textContent = first.busi_nm || first.bnm || "정보 없음";
	    document.getElementById("contact-number").textContent = first.busi_call || "정보 없음";

	    // 즐겨찾기 버튼 상태 업데이트 (이전과 동일)
	     const favButton = document.getElementById('station-detail-favorite-btn');
	    if (favButton) {
	        const currentStatId = first.stat_id;
	        favButton.setAttribute('data-stat-id', currentStatId);
	        if (window.userFavoriteStationIds && window.userFavoriteStationIds.has(currentStatId)) {
	            favButton.classList.add('favorited');
	            favButton.querySelector('.star-icon').textContent = '⭐';
	        } else {
	            favButton.classList.remove('favorited');
	            favButton.querySelector('.star-icon').textContent = '☆';
	        }
	    } else {
	        console.error("ID가 'station-detail-favorite-btn'인 즐겨찾기 버튼을 찾을 수 없습니다.");
	    }
	}
</script>
