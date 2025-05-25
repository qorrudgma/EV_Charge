<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="com.fasterxml.jackson.databind.ObjectMapper" %>
<%@ page import="java.util.Set" %>
<%@ page import="java.util.Collections" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>EV 충전소 찾기</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <script src="${pageContext.request.contextPath}/js/jquery.js"></script>
    <script src="${pageContext.request.contextPath}/js/region.js"></script>
	
    <style>
        html, body { margin: 0; padding: 0; height: 100%; }
        #reset { position: fixed; bottom: 50px; left: 1000px; z-index: 1000; padding: 10px 20px; border-radius: 30px; font-weight: bolder; background-color: #0475f4; color: white; }
        #reset:hover { background-color: #0062d3; cursor: pointer; }
        #reset i { transition: transform 0.7s ease; }
        #reset:hover i { transform: rotate(180deg); }
    </style>
    <script>
        // --- 전역 변수 초기화 ---
        window.APP_USER_NO = null;
        <c:if test="${not empty sessionScope.user && not empty sessionScope.user.user_no}">
            var userNoFromSession = '${sessionScope.user.user_no}';
            if (userNoFromSession && !isNaN(parseInt(userNoFromSession))) {
                window.APP_USER_NO = parseInt(userNoFromSession);
            }
        </c:if>
        console.log('[Main JSP] 로그인된 사용자 번호 (window.APP_USER_NO):', window.APP_USER_NO);

        window.userFavoriteStationIds = new Set();
        <%
            @SuppressWarnings("unchecked")
            Set<String> favIds = (Set<String>) session.getAttribute("userFavoriteStationIds");
            if (favIds == null) {
                favIds = Collections.emptySet();
            }	
            ObjectMapper objectMapper = new ObjectMapper();
            String favoriteIdsJson = objectMapper.writeValueAsString(favIds);
        %>
        try {
            const serverFavoriteIds = JSON.parse('<%= favoriteIdsJson %>');
            if (Array.isArray(serverFavoriteIds)) {
                window.userFavoriteStationIds = new Set(serverFavoriteIds);
            }
        } catch (e) {
            console.error('[Main JSP] 즐겨찾기 ID 목록 JSON 파싱 오류:', e);
        }
        console.log('[Main JSP] 초기화된 즐겨찾기 ID 목록 (window.userFavoriteStationIds):', Array.from(window.userFavoriteStationIds));
    </script>
</head>
<body>
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=109dd4a6fbdf108d896544146388b47e"></script>

    <jsp:include page="/WEB-INF/views/header.jsp" />
    <jsp:include page="/WEB-INF/views/favorites_sidebar.jsp"/>
    <jsp:include page="/WEB-INF/views/station_detail.jsp"/>
    <jsp:include page="/WEB-INF/views/reservation.jsp"/>
    <jsp:include page="/WEB-INF/views/findpath.jsp"/>
    <div id="map" style="width:100%;height:93%;"></div>
    <div id="reset"><i class="fas fa-sync-alt"></i> &nbsp;현 지도에서 검색</i></div>

    <script type="text/javascript">
        var mapContainer = document.getElementById('map');
        var markers = [];
        var markerInfoMap = {}; // 검색 시 마커 그룹핑용
        var center_lat = 37.5400456; // 기본 서울 중심
        var center_lng = 126.9921017;

        var mapOption = {
            center: new kakao.maps.LatLng(center_lat, center_lng),
            level: 3
        };
        var map = new kakao.maps.Map(mapContainer, mapOption);
        window.map = map;
        window.markers = markers;

        kakao.maps.event.addListener(map, 'center_changed', function () {
            var latlng = map.getCenter();
            center_lat = latlng.getLat();
            center_lng = latlng.getLng();
        });
        // 길찾기
         // vertexJson이 있으면 경로 표시, 없으면 기본 지도
         var vertexJson = '${vertexJson}';
         if (vertexJson && vertexJson !== 'null' && vertexJson.length > 2) {
            var vertexes = JSON.parse(vertexJson);
            var centerLat = vertexes[1];
            var centerLng = vertexes[0];

            var pathCoordinates = [];
            for (var i = 0; i < vertexes.length; i += 2) {
                  var lng = vertexes[i];
                  var lat = vertexes[i + 1];
                  pathCoordinates.push(new kakao.maps.LatLng(lat, lng));
            }

            map = new kakao.maps.Map(mapContainer, {
                  center: new kakao.maps.LatLng(centerLat, centerLng),
                  level: 3
            });

            var polyline = new kakao.maps.Polyline({
                  path: pathCoordinates,
                  strokeWeight: 8,
                  strokeColor: '#3B82F6',
                  strokeOpacity: 1,
                  strokeStyle: 'solid'
            });
            polyline.setMap(map);

            new kakao.maps.Marker({
                  position: pathCoordinates[0],
                  map: map,
                  title: '출발지'
            });

            new kakao.maps.Marker({
                  position: pathCoordinates[pathCoordinates.length - 1],
                  map: map,
                  title: '도착지'
            });

         }
         // else {
         //    // 경로 없을 때는 기본 지도만 표시
         //    map = new kakao.maps.Map(mapContainer, {
         //          center: new kakao.maps.LatLng(37.5665, 126.9780), // 서울 중심
         //          level: 4
         //    });
         // }
        // ※※※ updatearea_emd_nm 함수는 이전 제공 코드에서 regions 객체 관련 부분 수정된 것 사용 ※※※
        // (js/region.js 파일과 regions 객체의 키가 지역 코드로 되어 있다고 가정)
        function updatearea_emd_nm() {
            const area_ctpy_nm_val = document.getElementById("area_ctpy_nm").value; // 시/도 코드
            const area_sgg_nm_val = document.getElementById("area_sgg_nm").value;   // 시/군/구 코드
            const area_emd_nmSelect = document.getElementById("area_emd_nm");

            area_emd_nmSelect.innerHTML = '<option value="">선택하세요</option>';

            if (typeof regions !== 'undefined' && area_ctpy_nm_val && area_sgg_nm_val &&
                regions[area_ctpy_nm_val] && regions[area_ctpy_nm_val][area_sgg_nm_val]) {
                const area_emd_nms = regions[area_ctpy_nm_val][area_sgg_nm_val];
                area_emd_nms.forEach(emd_name => {
                    const option = document.createElement("option");
                    option.value = emd_name;
                    option.text = emd_name;
                    area_emd_nmSelect.appendChild(option);
                });
            } else {
                if (typeof regions === 'undefined') console.error("updatearea_emd_nm: 'regions' 객체가 정의되지 않았습니다.");
            }
        }

        // --- 상세 정보창 업데이트 함수 (FavoriteDTO 사용) ---
        function updateStationDetailTwo(markerData) {
            const first = markerData.chargerList[0]; // FavoriteDTO 객체
            console.log("updateStationDetailTwo - Received FavoriteDTO (first):", JSON.stringify(first, null, 2));

            window.currentStationFullDataForFavorite = {
                stat_id: first.stat_id, stat_name: first.stat_name ,addr: first.addr, addr_detail: first.addr_detail,
                location: first.location, lat: parseFloat(first.lat), lng: parseFloat(first.lng)
            };

            $("#station_lat").val(first.lat);
            $("#station_lng").val(first.lng);
            document.getElementById("station-name").textContent = first.stat_name || "정보 없음";

            let addressHtml = first.addr || "";
            if (first.addr_detail && first.addr_detail !== "null" && first.addr_detail !== "undefined") {
                addressHtml += (addressHtml ? "<br>" : "") + first.addr_detail;
            }
            if (first.location && first.location !== "null" && first.location !== "undefined" && first.location !== first.addr_detail) {
                addressHtml += (addressHtml ? "<br>" : "") + first.location;
            }
            document.getElementById("station-address").innerHTML = addressHtml || "주소 정보 없음";

            // --- 총 충전기 대수 및 타입 정보 (FavoriteDTO에서 직접 가져오기) ---
            const totalRapidChargers = first.fastChargerCount || 0;
            const rapidTypeInfoFromDTO = first.fastChargerTypeInfo || "정보 없음";
            const totalSlowChargers = first.slowChargerCount || 0;
            const slowTypeInfoFromDTO = first.slowChargerTypeInfo || "정보 없음";

            // --- 사용 가능한 충전기 대수 (/stat_data API 호출 유지) ---
            let availableRapidChargers = 0; // API 호출 전 기본값
            let availableSlowChargers = 0;  // API 호출 전 기본값

            fetch("stat_data", {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify({ stat_id: first.stat_id })
            })
            .then(response => {
                if (!response.ok) throw new Error(`HTTP error! status: ${response.status}`);
                return response.json();
            })
            .then(data => {
                console.log("/stat_data API 응답:", data);
                availableRapidChargers = data.rapid_stat_available || 0; // ※ 컨트롤러 반환 키와 일치 확인! ※
                availableSlowChargers = data.slow_stat_available || 0;  // ※ 컨트롤러 반환 키와 일치 확인! ※
                document.getElementById("rapid_count").textContent = availableRapidChargers;
                document.getElementById("slow_count").textContent = availableSlowChargers;
            })
            .catch(error => {
                console.error("/stat_data API 호출 오류:", error);
                document.getElementById("rapid_count").textContent = "0";
                document.getElementById("slow_count").textContent = "0";
            })
            .finally(() => { // API 호출 결과에 관계없이 총 대수 및 타입 정보는 DTO 기준으로 표시
                console.log("Displaying - Total Rapid:", totalRapidChargers, "Available Rapid:", availableRapidChargers, "Type:", rapidTypeInfoFromDTO);
                console.log("Displaying - Total Slow:", totalSlowChargers, "Available Slow:", availableSlowChargers, "Type:", slowTypeInfoFromDTO);

                if (totalRapidChargers === 0 && totalSlowChargers === 0) {
                    $(".rapid_div").parent().css("display", "none"); 
                    $("#supported-vehicles").parent().css("display", "none"); 
                } else {
                    $(".rapid_div").parent().css("display", "");
                    $("#supported-vehicles").parent().css("display", "");
                    if (totalRapidChargers === 0) {
                        $(".rapid_div").css("display", "none");
                        $("#supported-vehicles .rapid_div").css("display", "none");
                    } else {
                        $(".rapid_div").css("display", "");
                        $("#supported-vehicles .rapid_div").css("display", "");
                        document.getElementById("strong_rapid").textContent = totalRapidChargers;
                        // rapid_count는 fetch 결과로 채워짐
                        document.getElementById("rapid_type").textContent = rapidTypeInfoFromDTO;
                    }
                    if (totalSlowChargers === 0) {
                        $(".slow_div").css("display", "none");
                        $("#supported-vehicles .slow_div").css("display", "none");
                    } else {
                        $(".slow_div").css("display", "");
                        $("#supported-vehicles .slow_div").css("display", "");
                        document.getElementById("strong_slow").textContent = totalSlowChargers;
                        // slow_count는 fetch 결과로 채워짐
                        document.getElementById("slow_type").textContent = slowTypeInfoFromDTO;
                    }
                }
            });


            let parking_free_text = (first.parking_free === 'Y') ? "요금 없음" : (first.parking_free === 'N' ? "요금 있음" : (first.parking_free || "정보 없음"));
            document.getElementById("operation-hours").textContent = first.use_time || "정보 없음";
            document.getElementById("parking_free").textContent = parking_free_text;
            document.getElementById("operation-agency").textContent = first.busi_nm || first.bnm || "정보 없음";
            document.getElementById("contact-number").textContent = first.busi_call || "정보 없음";

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
            }
        }

        // --- 마커 생성 및 클릭 이벤트 함수 (모든 경로 공통 사용) ---
        window.addMarker_two = function(lat, lng, initialChargerDataList) {
            const position = new kakao.maps.LatLng(lat, lng);
            const marker = new kakao.maps.Marker({ position: position, map: map });
            markers.push(marker);

            if (initialChargerDataList && initialChargerDataList.length > 0) {
                const representativeData = initialChargerDataList[0];
                marker.stat_id = representativeData.stat_id;
                marker.marker_lat = parseFloat(representativeData.lat);
                marker.marker_lng = parseFloat(representativeData.lng);
            } else { return marker; }

			// 마커 클릭
            kakao.maps.event.addListener(marker, 'click', function () {
                const clickedMarkerStatId = marker.stat_id;
                const clickedMarkerLat = marker.marker_lat;
                const clickedMarkerLng = marker.marker_lng;

                if (!clickedMarkerStatId) {
                    alert("충전소 ID가 없어 상세 정보를 가져올 수 없습니다."); return;
                }
                console.log(`마커 클릭: stat_id=${clickedMarkerStatId}. 상세 정보 API 호출...`);
                const apiUrl = "/favorites/markerInfo?statId=" + encodeURIComponent(clickedMarkerStatId);
                
                fetch(apiUrl)
                    .then(response => {
                        if (!response.ok) {
                            return response.json().then(err => { throw new Error(err.message || `서버 오류: ${response.status}`) });
                        }
                        return response.json();
                    })
                    .then(data => { // data는 [FavoriteDTO]
                        if (!data || data.length === 0 || (data[0] && data[0].status === 'error')) {
                            const errorMessage = (data && data[0] && data[0].message) ? data[0].message : "충전소 상세 정보를 가져오지 못했습니다.";
                            alert(errorMessage); console.error("API 응답 오류:", data); return;
                        }
                        console.log(`/favorites/markerInfo API 응답 (${clickedMarkerStatId}):`, data);
                        map.setCenter(new kakao.maps.LatLng(clickedMarkerLat, clickedMarkerLng - 0.001));
                        map.setLevel(1);
                        $(".station-sidebarA").addClass("active");
                        updateStationDetailTwo({ lat: clickedMarkerLat, lng: clickedMarkerLng, chargerList: data });
                    })
                    .catch(error => {
                        console.error(`상세 정보 로드 실패 (stat_id: ${clickedMarkerStatId}):`, error);
                        alert(error.message || "정보 로드 중 오류 발생");
                    });
            });
            return marker;
        };

        // --------------------------------- 추가됨	--------------------------------------------------------------
		$(document).ready(function () {
		    // --- 사이드바 관련 이벤트 핸들러 (기존 유지) ---
		    $("#close-sidebar").on("click", function () {
		        $(".station-sidebar").removeClass("active");
		        $(".station-sidebarA").removeClass("active");
		    });
		    $("#bars").on("click", function () {
		        $(".station-sidebar").toggleClass("active");
		        if ($(".station-sidebarA").hasClass("active")) {
		            $(".station-sidebarA").removeClass("active");
		        }
		    });

		    // --- "지역 검색" (#search_btn) 버튼 클릭 로직 ---
		    $("#search_btn").on("click", function () {
		        const area_ctpy_nm_val = $("#area_ctpy_nm").val(); // 시/도 코드
		        const area_sgg_nm_val = $("#area_sgg_nm").val();   // 시/군/구 코드
		        const area_ctpy_nm_text = $("#area_ctpy_nm option:selected").text();
		        const area_sgg_nm_text = $("#area_sgg_nm option:selected").text();
		        const area_emd_nm_text = $("#area_emd_nm").val(); // 읍/면/동 명칭

		        if (!area_ctpy_nm_val || !area_sgg_nm_val || !area_emd_nm_text) {
		            alert("모든 주소 항목을 선택해주세요.");
		            return;
		        }
		        console.log(`[지역 검색] 요청: ${area_ctpy_nm_text} ${area_sgg_nm_text} ${area_emd_nm_text}`);

		        // 1. 주소로 좌표 변환 API 호출
		        fetch('/updateMapCoordinates', {
		            method: 'POST', // ★★★ POST 방식 명시 ★★★
		            headers: {
		                'Content-Type': 'application/json'
		            },
		            body: JSON.stringify({
		                area_ctpy_nm: area_ctpy_nm_text, // 서버 API가 텍스트 기반으로 좌표를 찾는다고 가정
		                area_sgg_nm: area_sgg_nm_text,
		                area_emd_nm: area_emd_nm_text
		            })
		        })
		        .then(response => {
		            if (!response.ok) {
		                return response.json().catch(() => { // 에러 응답도 JSON일 수 있음
		                    throw new Error(`[좌표변환] 서버 응답 오류: ${response.status} ${response.statusText}`);
		                }).then(errorBody => {
		                    throw new Error(errorBody.message || `[좌표변환] 정보 조회 실패 (상태: ${response.status})`);
		                });
		            }
		            return response.json();
		        })
		        .then(coordData => {
		            if (coordData && coordData.latitude && coordData.longitude) {
		                center_lat = coordData.latitude;
		                center_lng = coordData.longitude;
		                if (map && typeof map.setCenter === 'function') {
		                     map.setCenter(new kakao.maps.LatLng(center_lat, center_lng));
		                } else {
		                    console.error("[지역 검색] map 객체가 유효하지 않습니다.");
		                }
		                console.log("[지역 검색] 새로운 중심 좌표:", center_lat, center_lng);

		                // 2. 해당 좌표로 충전소 검색 (/search_data API 호출)
		                return fetch("/search_data", {
		                    method: "POST", // ★★★ POST 방식 명시 ★★★
		                    headers: { "Content-Type": "application/json" },
		                    body: JSON.stringify({ lat: center_lat, lng: center_lng })
		                });
		            } else {
		                alert("선택한 지역의 좌표를 찾을 수 없습니다.");
		                throw new Error("좌표 변환 실패: 유효한 위도/경도 없음"); // Promise 체인 중단
		            }
		        })
		        .then(response => { // 이 .then은 /search_data의 응답을 처리
		             if (!response.ok) { // /search_data 응답의 에러 처리
		                return response.json().catch(() => {
		                    throw new Error(`[/search_data] 서버 응답 오류: ${response.status} ${response.statusText}`);
		                }).then(errorBody => {
		                    throw new Error(errorBody.message || `[/search_data] 정보 조회 실패 (상태: ${response.status})`);
		                });
		            }
		            return response.json();
		        })
		        .then(chargerDataList => { // chargerDataList는 EvChargerDTO 배열
		            if (!Array.isArray(chargerDataList)) {
		                 console.error("[지역 검색] /search_data API가 배열을 반환하지 않았습니다:", chargerDataList);
		                 alert("충전소 정보를 가져오는 데 실패했습니다. (응답 형식 오류)");
		                 return;
		            }
		            console.log("[지역 검색] /search_data API 응답 (EvChargerDTO list):", chargerDataList);

		            // 기존 마커 제거
		            if (window.markers) {
		                for (var i = 0; i < window.markers.length; i++) { 
		                    if(window.markers[i] && typeof window.markers[i].setMap === 'function') window.markers[i].setMap(null); 
		                }
		            }
		            window.markers = [];
		            window.markerInfoMap = {}; // 그룹핑 맵 초기화

		            if (chargerDataList.length === 0) {
		                alert("해당 지역에 검색된 충전소가 없습니다.");
		                return;
		            }

		            // 같은 위치끼리 그룹핑 및 마커 생성
		            chargerDataList.forEach((charger, index) => {
		                if (charger.lat != null && charger.lng != null && !isNaN(parseFloat(charger.lat)) && !isNaN(parseFloat(charger.lng))) {
		                    const key = parseFloat(charger.lat) + "," + parseFloat(charger.lng);
		                    if (!window.markerInfoMap[key]) {
		                        window.markerInfoMap[key] = [];
		                    }
		                    window.markerInfoMap[key].push(charger);
		                } else {
		                    console.warn(`[지역 검색] 유효하지 않은 좌표를 가진 충전기 데이터 제외 (${index}):`, charger);
		                }
		            });

		            Object.entries(window.markerInfoMap).forEach(([key, chargersAtLocation]) => {
		                const parts = key.split(',');
		                const lat = parseFloat(parts[0]);
		                const lng = parseFloat(parts[1]);
		                if (!isNaN(lat) && !isNaN(lng) && window.addMarker_two) {
		                    window.addMarker_two(lat, lng, chargersAtLocation);
		                } else {
		                     if(isNaN(lat) || isNaN(lng)) console.warn("[지역 검색] 마커 생성 위한 좌표 파싱 실패:", key);
		                     if(!window.addMarker_two) console.error("[지역 검색] window.addMarker_two 함수 없음");
		                }
		            });
		        })
		        .catch(error => {
		            console.error("[지역 검색] 중 전체 오류 발생:", error);
		            alert(error.message || "지역으로 충전소 검색 중 오류가 발생했습니다.");
		        });
		    });


		    // --- "현 지도에서 검색" (#reset) 버튼 클릭 로직 ---
			window.addMarkers = function(lat, lng, chargerList) {
	            console.log("마커찍기");
	            // console.log("chargerList => ", chargerList);
	            const key = lat+","+lng;
	            const position = new kakao.maps.LatLng(lat, lng);

	            const marker = new kakao.maps.Marker({
	               position: position,
	               map: map
	            });

	            markers.push(marker);

	            // 마커 클릭 이벤트
	            kakao.maps.event.addListener(marker, 'click', function () {
	               console.log("마커 클릭됨 =>", lat, lng, chargerList);

	               map.setCenter(new kakao.maps.LatLng(lat, lng-0.001));
	               // map.setLevel(3);
	               map.setLevel(1);

	               $(".station-sidebar").addClass("active");
	               $(".station-sidebarA").addClass("active");

	               // 해당 위치의 모든 충전소 정보 전달
	               const markerData = {
	                     lat: lat,
	                     lng: lng,
	                     // chargers: markerInfoMap[key]  // 리스트 통째로 넘김
	                     chargerList: chargerList
	               };

	               stationDetail(markerData);
	            });

	            return marker;
	         };

			$(document).on("click", "#reset", function (e) {
	            console.log("현 지도에서 검색 클릭");
	            $(".station-sidebarA").removeClass("active");
	            console.log(center_lat + " / " + center_lng);
				   map.setLevel(3);

	            fetch("/search_data", {
	                method: "POST"
	               ,headers: {
	                  "Content-Type": "application/json"
	               }
	               ,body: JSON.stringify({
	                  lat: center_lat,
	                  lng: center_lng,
	                  lat_n: 0.005,
	                  lng_n: 0.01
	               }) 
	            })
	            .then(response => response.json())
	            .then(data => {
	               console.log("서버 응답 데이터 => ", data);
	               for (var i = 0; i < markers.length; i++) {
	                  markers[i].setMap(null);
	               }
	               markers = [];
	               markerInfoMap = {};  // 초기화

	               // 같은 위치끼리 그룹핑
	               data.forEach(charger => {
	                     const key = charger.lat+","+charger.lng;
	                     if (!markerInfoMap[key]) {
	                        markerInfoMap[key] = [];
	                     }
	                     markerInfoMap[key].push(charger);
	                     // console.log(markerInfoMap[key]);
	               });

	               Object.entries(markerInfoMap).forEach(([key, chargers]) => {
	                     const [lat, lng] = key.split(',').map(Number);
	                     window.addMarkers(lat, lng, chargers);
	                     // console.log("chargers => ", chargers);
	               });
	            })
	            .catch(error => {
	               console.error("오류 발생 => ", error);
	            });
	         });

		}); // $(document).ready 끝
//	---------------------------------------------- 추가됨------------------------------


        // --- 즐겨찾기 관련 초기화 (이전 코드와 동일) ---
        async function initializeGlobalFavoriteStatus() { /* ... */ }
       document.addEventListener('DOMContentLoaded', function() {
            if (window.APP_USER_NO) { initializeGlobalFavoriteStatus(); }
        });
             
        // --- URL 파라미터를 통한 즐겨찾기 상세 정보 바로 표시 (페이지 로드 시) ---
        window.onload = function() {
            // 로그인 사용자 정보 및 즐겨찾기 목록 초기화는 DOMContentLoaded에서 이미 처리될 수 있음
            // 여기서는 URL 파라미터 처리만 집중
            const params = new URLSearchParams(window.location.search);
            const latFromUrl = parseFloat(params.get("lat"));
            const lngFromUrl = parseFloat(params.get("lng"));
            const statIdFromUrl = params.get("statId");
            const openDetail = params.get("openDetail");

            if (latFromUrl && lngFromUrl && statIdFromUrl && openDetail === "true") {
                console.log(`[window.onload] 즐겨찾기 링크로 상세 정보 표시 요청: statId=${statIdFromUrl}`);
                const apiUrl = "/favorites/markerInfo?statId=" + encodeURIComponent(statIdFromUrl);
                fetch(apiUrl)
                    .then(res => {
                        if (!res.ok) return res.json().then(err => { throw new Error(err.message || `서버 오류: ${res.status}`) });
                        return res.json();
                    })
                    .then(data => { // data는 [FavoriteDTO]
                        if (!data || data.length === 0 || (data[0] && data[0].status === 'error')) {
                            const errorMessage = (data && data[0] && data[0].message) ? data[0].message : "충전소 정보를 불러올 수 없습니다.";
                            alert(errorMessage); console.error("[window.onload] API 응답 오류:", data); return;
                        }
                        const chargerListFromApi = data; // [FavoriteDTO]
                        console.log("[window.onload] /favorites/markerInfo API 응답:", chargerListFromApi);

                        // 마커 생성 (클릭 시 /favorites/markerInfo 다시 호출)
                        window.addMarker_two(latFromUrl, lngFromUrl, chargerListFromApi); 
                        
                        if (map && typeof map.setCenter === 'function') {
                             map.setCenter(new kakao.maps.LatLng(latFromUrl, lngFromUrl - 0.003));
                             map.setLevel(3);
                        }

                        // 상세 정보 즉시 표시
                        if (window.updateStationDetailTwo) {
                            updateStationDetailTwo({
                                lat: latFromUrl,
                                lng: lngFromUrl,
                                chargerList: chargerListFromApi // FavoriteDTO가 담긴 배열 전달
                            });
                            if (document.getElementById('station-detail-sidebar')) { // 직접 ID로 확인
                                 document.getElementById('station-detail-sidebar').classList.add('active');
                            }
                        }
                    })
                    .catch(err => {
                        console.error("[window.onload] 즐겨찾기 충전소 정보 로드 실패:", err);
                        alert(err.message || "즐겨찾기 정보를 불러오는 중 오류 발생");
                    });
            } else {
                if (openDetail === "true") {
                     console.warn("[window.onload] 'openDetail=true'이지만, lat, lng, 또는 statId 파라미터가 누락되었습니다.");
                }
            }
        };
    </script>
</body>
</html>