<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
   <!DOCTYPE html>
   <html lang="ko">

   <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <title>Document</title>
      <script src="${pageContext.request.contextPath}/js/jquery.js"></script>
      <script src="${pageContext.request.contextPath}/js/region.js"></script>
      <style>
         html, body {
            margin: 0;
            padding: 0;
            height: 100%;
            /* overflow: hidden; */
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
      <!-- 지도 표시 -->
      <div id="map" style="width:100%;height:93%;"></div>

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
      </script>
      <script>
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

         function addMarker(address, lat, lng, name, rapid, slow, car) {
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
				
				if (isOpen) {
					infowindow.close();
					isOpen = false;
				} else {
					infowindow.open(map, marker);
					isOpen = true;
				}
				
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
				updateStationDetail(markerData);
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
         }

         $(document).ready(function () {
            // 사이드바 관련 닫기
            $("#close-sidebar").on("click", function () {
               $(".station-sidebar").removeClass("active");
               $(".station-sidebarA").removeClass("active");
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
                           } else {
                              alert("해당 정보는 없는 정보입니다.");
                           }
                        })
                        .catch(error => {
                           console.error("Error:", error);
                           alert("위도 경도 변환 중 오류가 발생했습니다.");
                        });
                     //----------------------------------
                     //  두 번째 fetch 요청
                     // 검색 클릭 이벤트 핸들러 내부의 updateMapCoordinates_two 응답 처리 부분
                     fetch('/updateMapCoordinates_two', {
                        method: 'POST',
                        headers: {
                           'Content-Type': 'application/json'
                        },
                        body: JSON.stringify(addr_place_list)
                     }).then(response => response.json())
                        .then(data => {
                           console.log("@# 2단계");
                           console.log("@# 서버 응답 데이터:", data);
                           // 기존 마커 제거 (추가하기)
                           for (var i = 0; i < markers.length; i++) {
                              markers[i].setMap(null);
                           }
                           markers = [];
                           
                           // 새로운 응답 형식 처리
                           if (data.coordinates && data.coordinates.length > 0) {
                              // 모든 좌표에 대해 마커 추가
                              data.coordinates.forEach(coord => {
                                 console.log(`@#@# 마커 추가: ${coord.latitude}, ${coord.longitude}`);
                                 addMarker(coord.address, coord.latitude, coord.longitude, coord.name, coord.rapid, coord.slow, coord.car);
                              });
                           } else {
                              alert("해당 정보는 없는 정보입니다.(two)");
                           }
                        }).catch(error => {
                           console.error("Error:", error);
                           alert("위도 경도 변환 중 오류가 발생했습니다.(two)");
                        });
                  },
                  error: function () {
                     alert("1단계 오류");
                  }
               });
            });
         });         

      </script>
   </body>

   </html>