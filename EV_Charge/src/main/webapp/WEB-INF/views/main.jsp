<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
   <!DOCTYPE html>
   <html lang="ko">

   <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <title>Document</title>
      <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
      <script src="${pageContext.request.contextPath}/js/jquery.js"></script>
      <script src="${pageContext.request.contextPath}/js/region.js"></script>
      <style>
         html, body {
            margin: 0;
            padding: 0;
            height: 100%;
            /* overflow: hidden; */
            }
            #reset{
               position: fixed;
               bottom: 50px;
               left: 1000px;
               z-index: 1000;
               padding: 10px 20px;
               border-radius: 30px;
               font-weight: bolder;
               background-color: #0475f4;
               color: white;
            }
            #reset:hover{
               background-color: #0062d3;
               cursor: pointer;
            }
            #reset i{
               transition: transform 0.7s ease;
            }
            #reset:hover i{
               transform: rotate(180deg);
            }
      </style>
   </head>

   <body>
      <script type="text/javascript"
         src="//dapi.kakao.com/v2/maps/sdk.js?appkey=109dd4a6fbdf108d896544146388b47e"></script>
	
	  <!-- 헤더 -->
      <jsp:include page="/WEB-INF/views/header.jsp" />
	  <!-- 사이드바 -->
      <jsp:include page="/WEB-INF/views/favorites_sidebar.jsp"/>
      <jsp:include page="/WEB-INF/views/station_detail.jsp"/>
      <jsp:include page="/WEB-INF/views/reservation.jsp"/>
	  <jsp:include page="/WEB-INF/views/findpath.jsp"/>
      <!-- 지도 표시 -->
      <div id="map" style="width:100%;height:93%;"></div>

      <div id="reset"><i class="fas fa-sync-alt"></i> &nbsp;현 지도에서 검색</i></div>

      <!-- 추후에 사용자 세션 받아서 blind 및 display 처리 요망. -->
      <!-- 사용자 세션 받으면 center_lat과 center_lng는 사용자 가입시 설정되는 area 값으로 지정 -->

      <script type="text/javascript">
         var mapContainer = document.getElementById('map'); // 지도를 표시할 div  
         var markers = [];
         var center_lat; // 서버에서 전달된 위도
         var center_lng; // 서버에서 전달된 경도
         if (center_lat == null && center_lng == null) {
            center_lat = 37.5400456;
            center_lng = 126.9921017;
         };

         var mapOption = {
            center: new kakao.maps.LatLng(center_lat, center_lng), // 지도의 중심좌표
            level: 3 // 지도의 확대 레벨
         };

         var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

         kakao.maps.event.addListener(map, 'center_changed', function () {
            var latlng = map.getCenter();
            center_lat = latlng.getLat();
            center_lng = latlng.getLng();
            console.log('현재 중심 좌표:', center_lat, center_lng);
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

         // 읍/면/동 옵션 업데이트 함수
         function updatearea_emd_nm() {
            const area_ctpy_nm = document.getElementById("area_ctpy_nm").value;
           const area_sgg_nm = document.getElementById("area_sgg_nm").value;
            const area_emd_nmSelect = document.getElementById("area_emd_nm");

            // 읍/면/동 초기화
           area_emd_nmSelect.innerHTML = '<option value="">선택하세요</option>';

          if (area_ctpy_nm && area_sgg_nm && regions[area_ctpy_nm] && regions[area_ctpy_nm][area_sgg_nm]) {
              const area_emd_nms = regions[area_ctpy_nm][area_sgg_nm];
               area_emd_nms.forEach(area_emd_nm => {
                  const option = document.createElement("option");
               option.value = area_emd_nm;
                 option.text = area_emd_nm;
                  area_emd_nmSelect.appendChild(option);
               });
           }
         }

         window.addMarker = function(address, lat, lng, name, rapid, slow, car) {
            const position = new kakao.maps.LatLng(lat, lng);
            const marker = new kakao.maps.Marker({
               position: position,
               map: map,
               name: name
            });
            console.log("마커를 찍었습니다. => "+lat+", "+lng);
            markers.push(marker); // 마커 배열에 추가

            var infowindow = new kakao.maps.InfoWindow({
               content: '<div style="padding:5px;font-size:12px;">'+name+'</div>'
            });

            let isOpen = false;

            // 마커 클릭
            kakao.maps.event.addListener(marker, 'click', function() {
               console.log("마커를 클릭했습니다. 위치: " + lat + ", " + lng + ", 이름: " + name);
      
               map.setCenter(new kakao.maps.LatLng(lat, lng-0.003));
               map.setLevel(3);

               infowindow.open(map, marker);

               $("#close-detail-sidebar,#close-sidebar").on("click", function () {
                  infowindow.close();
               });
               
               // if (isOpen) {
               //    infowindow.close();
               //    isOpen = false;
               // } else {
               //    infowindow.open(map, marker);
               //    isOpen = true;
               // }
               
               // 마커 클릭했을때 사이드바 생성 및 데이터 전달
               $(".station-sidebar").addClass("active");
               $(".station-sidebarA").addClass("active");
               var markerData = {
                  name: name
                  ,address: address
                  ,lat: lat
                  ,lng: lng
                  ,rapid: rapid
                  ,slow: slow
                  ,car: car
               }
               
               console.log(markerData);
               // 충전소 상세 정보 업데이트
               updateStationDetailTwo(markerData);
            });

			   // 지도 클릭 액션
            kakao.maps.event.addListener(map, 'click', function() {
               infowindow.close();
               isOpen = false;
               // $(".station-sidebar").removeClass("active");
               $(".station-sidebarA").removeClass("active");
               // 마커지우기
               // for (var i = 0; i < markers.length; i++) {
               //    markers[i].setMap(null);
               // }
               // markers = [];
            });
            return marker;
         };

         window.map = map;
         window.markers = markers;

         $(document).ready(function () {
            // 사이드바 관련 닫기
            $("#close-sidebar").on("click", function () {
               $(".station-sidebar").removeClass("active");
               $(".station-sidebarA").removeClass("active");
               // infowindow.close();
            });

            // 사이드바 관련 열기
            $("#bars").on("click", function () {
               $(".station-sidebar").toggleClass("active");
               if( $(".station-sidebarA").hasClass("active")){
                  $(".station-sidebarA").removeClass("active");                  
               }
            });

            // 검색 클릭
            $("#search_btn").on("click", function () {
               const area_ctpy_nm_val = $("#area_ctpy_nm").val();
               const area_sgg_nm_val = $("#area_sgg_nm").val();
               const area_ctpy_nm = $("#area_ctpy_nm option:selected").text();
               const area_sgg_nm = $("#area_sgg_nm option:selected").text();
               const area_emd_nm = $("#area_emd_nm").val();

               if (!area_ctpy_nm || !area_sgg_nm || !area_emd_nm) {
                  alert("모든 주소 항목을 선택해주세요.");
                  return;
               }
			   map.setLevel(3);
			   $(".station-sidebarA").removeClass("active");

               // findStationsNear 호출
               $.ajax({
                  type: "post",
                  url: "/findStationsNear",
                  data: {
                     area_ctpy_nm: area_ctpy_nm_val,
                     area_sgg_nm: area_sgg_nm_val
                  },
                  success: function (addr_place_list) {
                     // alert("1단계 성공: " + JSON.stringify(addr_list));
                     console.log("1단계 성공");
                     console.log(addr_place_list);
                     
                     //----------------------------------
                     // 폼 데이터를 서버로 전송
                     fetch('/updateMapCoordinates', {
                        method: 'POST',
                        headers: {
                           'Content-Type': 'application/json'
                        },
                        body: JSON.stringify({
                           area_ctpy_nm: area_ctpy_nm,
                           area_sgg_nm: area_sgg_nm,
                           area_emd_nm: area_emd_nm
                        })
                     })
                        .then(response => response.json())
                        .then(data => {
                           // 서버에서 받은 위도와 경도로 지도 중심 좌표 갱신
                           if (data.latitude && data.longitude) {
                              center_lat = data.latitude;
                              center_lng = data.longitude;
                              var newCenter = new kakao.maps.LatLng(center_lat, center_lng);
                              map.setCenter(newCenter);
                              console.log("@# 새로운 중심 좌표:", center_lat, center_lng);

                              fetch("/search_data", {
                                 method: "POST"
                                 ,headers: {
                                    "Content-Type": "application/json"
                                 }
                                 ,body: JSON.stringify({
                                    lat: center_lat,
                                    lng: center_lng,
                                    lat_n: 0.0025,
                                    lng_n: 0.005
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

                                 // 마커 찍기 (중복 없이)
                                 Object.entries(markerInfoMap).forEach(([key, chargers]) => {
                                       const [lat, lng] = key.split(',').map(Number);
                                       window.addMarker_two(lat, lng, chargers);
                                       // console.log("chargers => ", chargers);
                                 });
                              })
                              .catch(error => {
                                 console.error("오류 발생 => ", error);
                              });

                           } else {
                              alert("해당 정보는 없는 정보입니다.");
                           }
                        })
                        .catch(error => {
                           console.error("Error:", error);
                           alert("위도 경도 변환 중 오류가 발생했습니다.");
                        });
                  },
                  error: function () {
                     alert("1단계 오류");
                  }
               });
            });
         });

         window.addMarker_two = function(lat, lng, chargerList) {
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

               updateStationDetailTwo(markerData);
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
                     window.addMarker_two(lat, lng, chargers);
                     // console.log("chargers => ", chargers);
               });
            })
            .catch(error => {
               console.error("오류 발생 => ", error);
            });
         });

      
      </script>
   </body>

   </html>