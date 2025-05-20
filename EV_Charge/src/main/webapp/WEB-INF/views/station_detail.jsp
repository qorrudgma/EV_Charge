<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/station_detail.css">

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
            <!-- 충전소 상태 배지 -->
            <!-- <div class="status-badge available"> -->
                <!-- <i class="fas fa-check-circle"></i> -->
                <!-- <span>사용가능</span> -->
            <!-- </div> -->
            
            <!-- 충전소 기본 정보 -->
            <div class="detail-section">
                <!-- <div id="station_lat"></div>
                <div id="station_lng"></div> -->
                <input type="text" id="station_lat" name="station_lat">

                <div class="station-header">
                    <h2 id="station-name" class="station-title"></h2>
                    <button id="toggle-favorite" class="favorite-btn" title="즐겨찾기">
                        <i class="fas fa-star"></i>
                    </button>
                </div>
                
                <div class="station-address-container">
                    <i class="fas fa-map-marker-alt"></i>
                    <p id="station-address" class="station-address"></p>
                </div>
                
                <div class="action-buttons">
                    <button class="action-button primary" onclick="navigateToStation()">
                        <i class="fas fa-directions"></i>
                        <span>길찾기</span>
                    </button>
                    <button class="action-button secondary" onclick="shareStation()">
                        <i class="fas fa-share-alt"></i>
                        <span>공유하기</span>
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
                
				<!-- 충전기 현황 -->
                <!-- <div class="charger-status">
                    <div class="status-item available">
                        <span class="status-dot"></span>
                        <span class="status-label">사용가능</span>
                        <span id="available-count" class="status-count">3</span>
                    </div>
                    <div class="status-item charging">
                        <span class="status-dot"></span>
                        <span class="status-label">충전중</span>
                        <span id="charging-count" class="status-count">2</span>
                    </div>
                    <div class="status-item offline">
                        <span class="status-dot"></span>
                        <span class="status-label">점검중</span>
                        <span id="offline-count" class="status-count">1</span>
                    </div>
                </div> -->
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
            
            <!-- 충전기 상세 목록 -->
<!--            <div class="detail-section">-->
<!--                <h3 class="section-title">-->
<!--                    <i class="fas fa-list"></i>-->
<!--                    <span>충전기 목록</span>-->
<!--                </h3>-->
                
<!--                <div class="charger-list">-->
<!--                    <div class="charger-item available">-->
<!--                        <div class="charger-header">-->
<!--                            <div class="charger-name">-->
<!--                                <span class="charger-number">01</span>-->
<!--                                <span class="charger-type">DC콤보</span>-->
<!--                            </div>-->
<!--                            <div class="charger-status">사용가능</div>-->
<!--                        </div>-->
<!--                        <div class="charger-specs">-->
<!--                            <div class="spec-item">-->
<!--                                <i class="fas fa-bolt"></i>-->
<!--                                <span>100kW</span>-->
<!--                            </div>-->
<!--                            <div class="spec-item">-->
<!--                                <i class="fas fa-dollar-sign"></i>-->
<!--                                <span>292.9원/kWh</span>-->
<!--                            </div>-->
<!--                        </div>-->
<!--                    </div>-->
<!--                </div>-->
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
            <i class="fas fa-exclamation-triangle"></i>
            <span>오류 신고하기</span>
        </button>
    </div>
</div>
<script>
    document.addEventListener('DOMContentLoaded', function() {
        // 사이드바 토글
        const sidebar = document.getElementById('station-detail-sidebar');
        const closeSidebarBtn = document.getElementById('close-detail-sidebar');
        const backToListBtn = document.getElementById('back-to-list');
        
        // 사이드바 열기 함수 (외부에서 호출 가능)
        window.openDetailSidebar = function(stationData) {
            // 여기에 stationData를 사용하여 사이드바 내용을 채우는 로직 구현
            // 예: document.getElementById('station-name').textContent = stationData.name;
            
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
        
        // 즐겨찾기 토글
        const favoriteBtn = document.getElementById('toggle-favorite');
        
        favoriteBtn.addEventListener('click', function() {
            this.classList.toggle('active');
            
            // 즐겨찾기 API 호출 로직 (사용자가 구현)
            const stationId = document.getElementById('station-name').getAttribute('data-id');
            const isFavorite = this.classList.contains('active');
            
            console.log(`충전소 ${stationId} 즐겨찾기 ${isFavorite ? '추가' : '제거'}`);
        });
    });
    
    // 길찾기 함수
    function navigateToStation() {
        // 길찾기 로직 (사용자가 구현)
        const lat = document.getElementById('station-name').getAttribute('data-lat');
        const lng = document.getElementById('station-name').getAttribute('data-lng');
        
        console.log(`길찾기: 위도 ${lat}, 경도 ${lng}`);
    }
    
    // 공유하기 함수
    function shareStation() {
        // 공유하기 로직 (사용자가 구현)
        const stationName = document.getElementById('station-name').textContent;
        const stationAddress = document.getElementById('station-address').textContent;
        
        console.log(`공유하기: ${stationName} (${stationAddress})`);
    }
	
	// 마커 클릭
	function updateStationDetail(markerData) {
        var name = markerData.name;
        var address = markerData.address;
        var lat = markerData.lat;
        var lng = markerData.lng;
        var rapid = markerData.rapid;
        var slow = markerData.slow;
        var cars = markerData.car;

        document.getElementById("station-name").textContent = name;
        document.getElementById("station-address").textContent = address;
        document.getElementById("station_lat").textContent = lat;
        document.getElementById("station_lng").textContent = lng;
        document.getElementById("strong_rapid").textContent = rapid;
        document.getElementById("strong_slow").textContent = slow;
        // document.getElementById("supported-vehicles").textContent = car;
        const car_list = cars.split(",");
        console.log(car_list);
		
        document.getElementById("supported-vehicles").textContent = "";
        for(let car of car_list){
            document.getElementById("supported-vehicles").innerHTML += `<div class="vehicle-chip">`+car+`</div>`;
            //document.getElementById("supported-vehicles").innerHTML += `<div class="vehicle-chip">${car}</div>`;
		}
    }
	function updateStationDetailTwo(markerData) {
        var chargerList = markerData.chargerList;
        console.log(chargerList);
        const first = markerData.chargerList[0];
        var rapid_count;
        var slow_count;
        // chargerList.forEach(charger => {
        //     console.log("!@#$ => ",charger.stat_id,charger.chger_id);
        // });

        fetch("stat_data", {
             method: "POST"
            ,headers: {"Content-Type":"application/json"}
            ,body: JSON.stringify({stat_id : first.stat_id})
        })
        .then(response => response.json())
        .then(data =>{
            // console.log("성공", data);
            console.log("성공", data.rapid_stat_three);
            rapid_count = data.rapid_stat_three;
            slow_count = data.slow_stat_three;
            // $("#station_lat").val(first.lat);
    
            // 전부다 반복으로 꺼내기
            // chargerList.forEach(charger => {
            //     console.log("전부 출력");
            //     console.log("충전소 이름 => ", charger.stat_name);
            //     console.log("충전기 타입 => ", charger.chger_type);
            //     console.log("출력 => ", charger.output);
            //     console.log("이용 가능 시간 => ", charger.use_time);
            //     console.log("====================================");
            // });

            // 첫번째 꺼만 꺼내기
            // console.log("!@#$!@#$", first.parking_free);
            // console.log("첫 번째 충전소 이름 =>", first.stat_name);
            // console.log("충전기 타입 =>", first.chger_type);

            // 이름
            document.getElementById("station-name").textContent = first.stat_name;
            // 주소
            let addressHtml = first.addr;
            if (first.addr_detail !== "null") {
                addressHtml += "<br>" + first.addr_detail;
            }
            if (first.addr_detail != first.location && first.location !== "null") {
                addressHtml += "<br>" + first.location;
            }
            document.getElementById("station-address").innerHTML = addressHtml;
            // 경도 위도
            // document.getElementById("station_lat").textContent = first.lat;
            // document.getElementById("station_lng").textContent = first.lng;
            // 충전기 종류
            const chger_type_map = {
                        "01": "B타입 (5핀, AC 완속)",
                        "02": "C타입 (5핀, AC 완속)",
                        "03": "BC타입 (5핀, AC 완속)",
                        "04": "BC타입 (7핀, AC 완속)",
                        "05": "DC 차데모 (DC CHAdeMO)",
                        "06": "AC 3상 (3상 교류)",
                        "07": "DC 콤보 (CCS1/CCS2)",
                        "08": "DC 차데모 + DC 콤보 복합",
                        "09": "DC 차데모 + AC 3상 복합",
                        "10": "DC 차데모 + DC 콤보 + AC3상 복합"
                    };

            var rapid_c = 0;
            var slow_c = 0;

            let charger_type_slow = [];
            let charger_type_rapid = [];

            chargerList.forEach(charger => {
                var output = charger.output;
                var chger_type = charger.chger_type;
                if(output < 50){
                    slow_c ++;
                    // console.log("!@#$@!#$!@#$@", chger_type);
                    const chager = chger_type_map[chger_type];
                    if (chager && !charger_type_slow.includes(chager)) {
                        charger_type_slow.push(chager);
                    }
                    // console.log("!@#$@!#$!@#$@!#$!@#$!@#$!@$#", chager);
                }else if(output >= 50){
                    rapid_c ++;
                    const chager = chger_type_map[chger_type];
                    if (chager && !charger_type_rapid.includes(chager)) {
                        charger_type_rapid.push(chager);
                    }
                }
            });

            if (rapid_c === 0) {
                $(".rapid_div").css("display","none");
            }else{
                $(".rapid_div").css("display","");
            }
            if (slow_c === 0) {
                $(".slow_div").css("display","none");
            }else{
                $(".slow_div").css("display","");
            }
            
            document.getElementById("strong_rapid").textContent = rapid_c;
            console.log("!@#$!@#$",rapid_count);
            document.getElementById("rapid_count").textContent = rapid_count;
            document.getElementById("strong_slow").textContent = slow_c;
            document.getElementById("slow_count").textContent = slow_count;
            // 충전기 타입
            document.getElementById("rapid_type").textContent = charger_type_rapid.join(", ");
            document.getElementById("slow_type").textContent = charger_type_slow.join(", ");


            // 운영 정보
            let parking_free;
            if (first.parking_free === 'Y') {
                parking_free = "요금 없음";
            }else{
                parking_free = "요금 있음";
            }
            document.getElementById("operation-hours").textContent = first.use_time;
            document.getElementById("parking_free").textContent = parking_free;
            document.getElementById("operation-agency").textContent = first.busi_nm;
            document.getElementById("contact-number").textContent = first.busi_call;
        })
        .catch(error => {
            console.log(error);
        });
    }
</script>