<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/favorites_sidebar.css">
<c:if test="${not empty sessionScope.user}">
    <script>
        const user_no = ${sessionScope.user.user_no};
    </script>
</c:if>

<div id="station-sidebar" class="station-sidebar active">
    <div class="sidebar-header">
        <div class="sidebar-title">
            <i class="fas fa-charging-station"></i>
            <h3>충전소 목록</h3>
        </div>
        <div class="sidebar-actions">
            <button id="refresh-stations" class="action-btn" title="새로고침">
                <i class="fas fa-sync-alt"></i>
            </button>
            <button id="close-sidebar" class="action-btn" title="닫기">
                <i class="fas fa-times"></i>
            </button>
        </div>
    </div>

    <!-- <form id="station_searchfrm" onsubmit="event.preventDefault(); search(); return false;"> -->
    <form id="station_searchfrm">
        <div class="sidebar-search">
            <div class="search-container">
                <i class="fas fa-search search-icon"></i>
                <!-- <input type="text" id="station-search" placeholder="충전소 검색..." class="search-input"> -->
                <input type="search" name="address" id="station-search" placeholder="충전소 검색" class="search-input">
                <input type="hidden" name="radiusKm" value="3">
                <button class="search-clear" id="clear-search">
                    <i id="x" class="fas fa-times-circle"></i>
                </button>
                <input type="button" class="ev-search-button" value="검색" onclick="search()">
            </div>
        </div>
    </form>
    
    <div class="sidebar-filters">
        <div class="filter-chips">
            <button class="filter-chip active" data-filter="all">
                <span>전체</span>
                <span class="count">${stationList.size()}</span>
            </button>
            <button class="filter-chip" data-filter="available">
                <span>사용가능</span>
                <span class="count" id="available-count">0</span>
            </button>
            <button class="filter-chip" data-filter="favorite">
                <span>즐겨찾기</span>
                <i class="fas fa-star"></i>
            </button>
			
        </div>
    </div>
    
    <div class="sidebar-results">
        <h4 class="results-title">
            검색 결과 <span class="results-count">${stationList.size()}개</span>
        </h4>
    </div>
    
    <div class="sidebar-content">
        <div id="station-list" class="station-list">
            <c:choose>
                <c:when test="${not empty stationList}">
                    <c:forEach var="station" items="${stationList}" varStatus="status">
                        <div class="station-item" data-id="${station.stationId}" data-lat="${station.evseLocationLatitude}" data-lng="${station.evseLocationLongitude}">
                            <div class="station-status ${status.index % 3 == 0 ? 'available' : (status.index % 3 == 1 ? 'busy' : 'offline')}">
                                <i classㅋㅋer-alt"></i>
                                    <span>${station.stationAddress}</span>
                                </div>
                                
                                <div class="station-details">
                                    <div class="detail-item">
                                        <i class="fas fa-bolt"></i>
                                        <span>DC콤보 (100kW)</span>
                                    </div>
                                    <div class="detail-item">
                                        <i class="fas fa-plug"></i>
                                        <span>${status.index % 2 == 0 ? '2/4' : '1/2'} 사용가능</span>
                                    </div>
                                    <div class="detail-item">
                                        <i class="fas fa-route"></i>
                                        <span>${status.index * 0.5 + 0.5}km</span>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="station-actions">
                                <button class="action-button primary" onclick="navigateToStation('${station.evseLocationLatitude}', '${station.evseLocationLongitude}')">
                                    <i class="fas fa-directions"></i>
                                    <span>길찾기</span>
                                </button>
                                <button class="action-button secondary" onclick="showStationDetail('${station.stationId}')">
                                    <i class="fas fa-info-circle"></i>
                                    <span>상세정보</span>
                                </button>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="empty-state">
                        <div class="empty-icon">
                            <i class="fas fa-search"></i>
                        </div>
                        <h4>검색 결과가 없습니다</h4>
                        <p>검색 반경을 넓히거나 다른 위치에서 검색해보세요.</p>
                        <button class="action-button primary" onclick="resetSearch()">
                            <i class="fas fa-redo"></i>
                            <span>검색 초기화</span>
                        </button>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
    
    <div class="sidebar-footer">
        <div class="footer-info">
            <p>마지막 업데이트: <span id="last-updated">2023-10-25 14:30</span></p>
        </div>
    </div>
</div>
<script>

    document.addEventListener('DOMContentLoaded', function() {
        // // 사이드바 토글
        // const sidebar = document.getElementById('station-sidebar');
        // const closeSidebarBtn = document.getElementById('close-sidebar');
        
        // // 사이드바 열기 함수 (외부에서 호출 가능)
        // window.openSidebar = function() {
        //     sidebar.classList.add('active');
        // };
        
        // // 사이드바 닫기
        // closeSidebarBtn.addEventListener('click', function() {
        //     sidebar.classList.remove('active');
        // });
        
        // 검색 입력 지우기
        const searchInput = document.getElementById('station-search');
        const clearSearchBtn = document.getElementById('clear-search');
        
        clearSearchBtn.addEventListener('click', function() {
            searchInput.value = '';
            searchInput.focus();
            filterStations('');
        });
        
        // 검색 기능
        searchInput.addEventListener('input', function(e) {
            // console.log("검색 클릭");
            // e.preventDefault();
            filterStations(this.value.toLowerCase());
        });
        
        function filterStations(query) {
            const stations = document.querySelectorAll('.station-item');
            let visibleCount = 0;
            
            stations.forEach(station => {
                const name = station.querySelector('.station-name').textContent.toLowerCase();
                const address = station.querySelector('.station-address span').textContent.toLowerCase();
                
                if (name.includes(query) || address.includes(query)) {
                    station.style.display = '';
                    visibleCount++;
                } else {
                    station.style.display = 'none';
                }
            });
            
            // 결과 카운트 업데이트
            document.querySelector('.results-count').textContent = visibleCount + '개';
            
            // 결과가 없을 때 빈 상태 표시
            const emptyState = document.querySelector('.empty-state');
            if (emptyState) {
                if (visibleCount === 0) {
                    emptyState.style.display = 'flex';
                } else {
                    emptyState.style.display = 'none';
                }
            }
        }
        
        // 필터 기능
        const filterChips = document.querySelectorAll('.filter-chip');
        
        filterChips.forEach(chip => {
            chip.addEventListener('click', function() {
                // 활성화된 필터 변경
                filterChips.forEach(c => c.classList.remove('active'));
                this.classList.add('active');
                
                const filter = this.getAttribute('data-filter');
                applyFilter(filter);
            });
        });
        
        function applyFilter(filter) {
            const stations = document.querySelectorAll('.station-item');
            let visibleCount = 0;
			let hasFavorite = false;

            stations.forEach(station => {
                if (filter === 'all') {
                    station.style.display = '';
                    visibleCount++;
                } else if (filter === 'available') {
                    if (station.querySelector('.station-status.available')) {
                        station.style.display = '';
                        visibleCount++;
                    } else {
                        station.style.display = 'none';
                    }
                } else if (filter === 'favorite') {
                    if (station.querySelector('.favorite-btn.active')) {
                        station.style.display = '';
                        visibleCount++;
                        // console.log("favorite");
                        hasFavorite = true;
                    } else {
                        station.style.display = 'none';
                    }
                }
            });

            if (filter === "favorite" && hasFavorite) {
                // 즐겨찾기 리스트 호출
                console.log("myFavoriteList() 준비!");
                myFavoriteList(user_no);
            }
            
            // 결과 카운트 업데이트
            document.querySelector('.results-count').textContent = visibleCount + '개';
        }
		
		function myFavoriteList(userNo) {
       console.log("myFavoriteList() 실행");
       console.log("@# userNo =>"+userNo);
       
       if (!userNo) {
           alert("로그인이 필요합니다.");
           return;
       }

       fetch(`/favorite/list?user_no=${userNo}`)
           .then(response => response.json())
           .then(stationList => {
               console.log("@# test2 =>");
               const $list = document.querySelector('#station-list');
               $list.innerHTML = '';
               document.querySelector('.results-count').textContent = stationList.length + '개';

               stationList.forEach((station, index) => {
		                const statusIndex = index % 3;
		                const statusClass = statusIndex === 0 ? 'available' : (statusIndex === 1 ? 'busy' : 'offline');
		                const statusText = statusIndex === 0 ? '사용가능' : (statusIndex === 1 ? '사용중' : '점검중');
		                const statusIcon = statusIndex === 0 ? 'fa-check-circle' : (statusIndex === 1 ? 'fa-clock' : 'fa-exclamation-circle');
		                const availableText = index % 2 === 0 ? '2/4' : '1/2';
		                const distance = (index * 0.5 + 0.5).toFixed(1);
						
		                const html = `
		                <div class="station-item" data-id="${station.stationId || ''}" data-lat="${station.evseLocationLatitude}" data-lng="${station.evseLocationLongitude}">
		                    <div class="station-status ${statusClass}">
		                        <i class="fas ${statusIcon}"></i>
		                        <span>${statusText}</span>  
		                    </div>
		                    
		                    <div class="station-content">
		                        <div class="station-header">
		                            <h4 class="station-name">${station.stnPlace}</h4>
		                            <button 
		                                class="favorite-btn active"
		                                data-stnaddr="${station.stnAddr}"
		                                data-stnplace="${station.stnPlace}"
		                                data-rapidcnt="${station.rapidCnt}"
		                                data-slowcnt="${station.slowCnt}"
		                                data-cartype="${station.carType}"
		                                onclick="saveFavorite(event)">
		                                <i class="fas fa-star"></i>
		                            </button>
		                        </div>
		                        
		                        <div class="station-address">
		                            <i class="fas fa-map-marker-alt"></i>
		                            <span>${station.stnAddr}</span>
		                        </div>
		                        
		                        <div class="station-details">
		                            <div class="detail-item">
		                                <i class="fas fa-bolt"></i>
		                                <span>DC콤보 (100kW)</span>
		                            </div>
		                            <div class="detail-item">
		                                <i class="fas fa-plug"></i>
		                                <span>${availableText} 사용가능</span>
		                            </div>
		                            <div class="detail-item">
		                                <i class="fas fa-route"></i>
		                                <span>${distance}km</span>
		                            </div>
		                        </div>
		                    </div>
		                    
		                    <div class="station-actions">
		                        <button class="action-button primary" onclick="navigateToStation('${station.evseLocationLatitude}', '${station.evseLocationLongitude}')">
		                            <i class="fas fa-directions"></i>
		                            <span>길찾기</span>
		                        </button>
		                        <button class="action-button secondary" onclick="showStationDetail('${station.evseLocationLatitude}', '${station.evseLocationLongitude}', '${station.stnPlace}', ${station.rapidCnt}, ${station.slowCnt}, '${station.carType}')">
		                            <i class="fas fa-info-circle"></i>
		                            <span>상세정보</span>
		                        </button>
		                    </div>
		                </div>`;

		                $list.insertAdjacentHTML('beforeend', html);

		                // 마커 추가 (함수 내부에 정의되어 있어야 함)
		                window.addMarker(
		                    station.stnAddr,
		                    station.evseLocationLatitude,
		                    station.evseLocationLongitude,
		                    station.stnPlace,
		                    station.rapidCnt,
		                    station.slowCnt,
		                    station.carType
		                );
		            });
           })
           .catch(error => {
               console.error("즐겨찾기 목록 가져오기 실패:", error);
           });
   }

		
        
        // 즐겨찾기 토글
        const favoriteButtons = document.querySelectorAll('.favorite-btn');
        
        favoriteButtons.forEach(btn => {
            btn.addEventListener('click', function(e) {
                e.preventDefault();
                this.classList.toggle('active');
                
                // 여기에 즐겨찾기 API 호출 추가
                const stationId = this.closest('.station-item').getAttribute('data-id');
                const isFavorite = this.classList.contains('active');
                
                console.log(`충전소 ${stationId} 즐겨찾기 ${isFavorite ? '추가' : '제거'}`);
                
                // 즐겨찾기 필터가 활성화된 경우 목록 업데이트
                const activeFilter = document.querySelector('.filter-chip.active');
                if (activeFilter && activeFilter.getAttribute('data-filter') === 'favorite') {
                    applyFilter('favorite');
                }
            });
        });
        
        // 사용 가능한 충전소 수 계산
        const availableStations = document.querySelectorAll('.station-status.available');
        document.getElementById('available-count').textContent = availableStations.length;
        
        // 충전소 클릭 시 지도에 표시
        const stationItems = document.querySelectorAll('.station-item');
        
        stationItems.forEach(item => {
            item.addEventListener('click', function(e) {
                // 버튼 클릭은 제외
                if (e.target.closest('.favorite-btn') || e.target.closest('.action-button')) {
                    return;
                }
                
                const lat = parseFloat(this.getAttribute('data-lat'));
                const lng = parseFloat(this.getAttribute('data-lng'));
                const id = this.getAttribute('data-id');
                
                // 지도 중심 이동 및 마커 표시 함수 호출 (외부에 구현 필요)
                if (window.centerMapOnStation) {
                    window.centerMapOnStation(lat, lng, id);
                }
                
                // 모바일에서는 사이드바 닫기
                if (window.innerWidth <= 768) {
                    sidebar.classList.remove('active');
                }
            });
        });
        
        // 더 보기 버튼
        const loadMoreBtn = document.getElementById('load-more');
        if (loadMoreBtn) {
            loadMoreBtn.addEventListener('click', function() {
                // 여기에 추가 데이터 로드 로직 구현
                console.log('더 많은 충전소 로드');
                this.disabled = true;
                this.innerHTML = '<i class="fas fa-spinner fa-spin"></i> <span>로딩 중...</span>';
                
                // 예시: 3초 후 버튼 상태 복원
                setTimeout(() => {
                    this.disabled = false;
                    this.innerHTML = '<i class="fas fa-plus"></i> <span>더 보기</span>';
                }, 3000);
            });
        }
    });
    
    // 길찾기 함수
    function navigateToStation(lat, lng) {
        // 카카오맵 또는 네이버맵 등 외부 내비게이션 앱/웹 연결
        console.log(`길찾기: 위도 ${lat}, 경도 ${lng}`);
        
        // 예시: 카카오맵 웹 URL 스키마 사용
        const url = `https://map.kakao.com/link/to,목적지,${lat},${lng}`;
        window.open(url, '_blank');
    }
    
    // 충전소 상세정보 표시 함수
    // function showStationDetail(stationId) {
    //     console.log(`충전소 상세정보: ${stationId}`);
    //     // 상세정보 모달 또는 새 페이지로 이동
    //     // 예시: 모달 표시
    //     if (window.showStationDetailModal) {
    //         window.showStationDetailModal(stationId);
    //     }
    // }
    function showStationDetail(lat, lng, name, rapid, slow, car) {
        console.log("충전소 상세정보 => "+lat+", "+lng+", "+ name+", "+rapid+", "+slow+", "+car);
        
        // 지도 중심 이동 (카카오맵 API 사용)
        if (map) {
            // 지도 중심 이동 (약간 아래쪽으로 이동하여 마커가 중앙에 오도록)
            map.setCenter(new kakao.maps.LatLng(lat, lng-0.003));
            map.setLevel(3); // 줌 레벨 설정 (낮을수록 더 확대됨)
            
            // 해당 위치의 마커 찾기 및 정보창 열기
            for (var i = 0; i < markers.length; i++) {
                var markerPosition = markers[i].getPosition();
                if (markerPosition.getLat() == lat && markerPosition.getLng() == lng) {
                    // 마커 위치에 정보창 열기
                    var infowindow = new kakao.maps.InfoWindow({
                        content: '<div style="padding:5px;font-size:12px;">' + name + '</div>'
                    });
                    infowindow.open(map, markers[i]);
                    break;
                }
            }
        }
        
        // 상세 정보 사이드바 표시 (있는 경우)
        $(".station-sidebarA").addClass("active");
        
        // 충전소 상세 정보 업데이트 (있는 경우)
        if (window.updateStationDetail) {
            var markerData = {
                name: name,
                lat: lat,
                lng: lng,
                rapid: rapid,
                slow: slow,
                car: car
            };
            window.updateStationDetail(markerData);
        }
    }

    
    // 검색 초기화 함수
    function resetSearch() {
        document.getElementById('station-search').value = '';
        
        // 모든 충전소 표시
        const stations = document.querySelectorAll('.station-item');
        stations.forEach(station => {
            station.style.display = '';
        });
        
        // 필터 초기화
        const filterChips = document.querySelectorAll('.filter-chip');
        filterChips.forEach(chip => {
            chip.classList.remove('active');
            if (chip.getAttribute('data-filter') === 'all') {
                chip.classList.add('active');
            }
        });
        
        // 결과 카운트 업데이트
        const totalCount = document.querySelectorAll('.station-item').length;
        document.querySelector('.results-count').textContent = totalCount + '개';
    }
</script>
<script>
    $(document).ready(function() {
        // 폼 제출 이벤트 처리
        $("#station_searchfrm").on("submit", function(e) {
            e.preventDefault();
            search();
            return false;
        });
        
        // 검색 입력 필드에서 엔터 키 처리
        $("#station-search").on("keydown", function(e) {
            if (e.key === "Enter") {
                e.preventDefault();
                search();
                return false;
            }
        });
    });

    function search() {
    const address = $('#station-search').val();
    const radiusKm = $('input[name="radiusKm"]').val();

    $.ajax({
        type: "get",
        url: "sidebar",
        data: { address, radiusKm },
        dataType: "json", // 응답 데이터 타입을 JSON으로 지정
        success: function(stationList) {
            console.log("서버 응답:", stationList); // 응답 데이터 확인용
			console.log("결과 확인용"+stationList[0].evseLocationLatitude+", "+stationList[0].evseLocationLongitude);

            // 지역 중심으로 이동
            map.setCenter(new kakao.maps.LatLng(stationList[0].evseLocationLatitude, stationList[0].evseLocationLongitude));
            map.setLevel(5);
            //----------------//
            
            const $list = $('#station-list');
            $list.empty();

            if (!stationList || stationList.length === 0) {
                $list.html(`
                    <div class="empty-state">
                        <div class="empty-icon">
                            <i class="fas fa-search"></i>
                        </div>
                        <h4>검색 결과가 없습니다</h4>
                        <p>검색 반경을 넓히거나 다른 위치에서 검색해보세요.</p>
                        <button class="action-button primary" onclick="resetSearch()">
                            <i class="fas fa-redo"></i>
                            <span>검색 초기화</span>
                        </button>
                    </div>
                `);
                
                // 결과 카운트 업데이트
                document.querySelector('.results-count').textContent = '0개';
                return;
            }

            // 결과 카운트 업데이트
            document.querySelector('.results-count').textContent = stationList.length + '개';

            stationList.forEach((station, index) => {
                const statusIndex = index % 3;
                const statusClass = statusIndex === 0 ? 'available' : (statusIndex === 1 ? 'busy' : 'offline');
                const statusText = statusIndex === 0 ? '사용가능' : (statusIndex === 1 ? '사용중' : '점검중');
                const statusIcon = statusIndex === 0 ? 'fa-check-circle' : (statusIndex === 1 ? 'fa-clock' : 'fa-exclamation-circle');
                const favoriteActive = index % 5 === 0 ? 'active' : '';
                const availableText = index % 2 === 0 ? '2/4' : '1/2';
                const distance = (index * 0.5 + 0.5).toFixed(1);

                console.log(stationList[index].stationName);

                const html = `
                <div class="station-item" data-id="${stationList.stationId}" data-lat="${station.evseLocationLatitude}" data-lng="${station.evseLocationLongitude}">
                    <div class="station-status ${statusClass}">
                        <i class="fas ${statusIcon}"></i>
                        <span>${statusText}</span>  
                    </div>
                    
                    <div class="station-content">
                        <div class="station-header">
                            <h4 class="station-name">` + stationList[index].stationName + `</h4>
							
							    <button 
							        class="favorite-btn ${station.favoriteActive}"
									data-stnaddr="` + stationList[index].stationAddress + `"
									data-stnplace="` + stationList[index].stationName + `"
									data-rapidcnt="` + stationList[index].rapid + `"
									data-slowcnt="` + stationList[index].slow + `"
									data-cartype="` + stationList[index].car + `"
							        onclick="saveFavorite(event)">
							        <i class="fas fa-star"></i>
							    </button>

                        </div>
                        
                        <div class="station-address">
                            <i class="fas fa-map-marker-alt"></i>
                            <span>` + stationList[index].stationAddress + `</span>
                        </div>
                        
                        <div class="station-details">
                            <div class="detail-item">
                                <i class="fas fa-bolt"></i>
                                <span>DC콤보 (100kW)</span>
                            </div>
                            <div class="detail-item">
                                <i class="fas fa-plug"></i>
                                <span>${availableText} 사용가능</span>
                            </div>
                            <div class="detail-item">
                                <i class="fas fa-route"></i>
                                <span>${distance}km</span>
                            </div>
                        </div>
                    </div>
                    
                    <div class="station-actions">
                        <button class="action-button primary" onclick="navigateToStation('${station.evseLocationLatitude}', '${station.evseLocationLongitude}')">
                            <i class="fas fa-directions"></i>
                            <span>길찾기</span>
                        </button>
                        <button class="action-button secondary" onclick="showStationDetail('`+stationList[index].evseLocationLatitude+`', '`+stationList[index].evseLocationLongitude+`', '`+stationList[index].stationName+`', ` + stationList[index].rapid + `, ` + stationList[index].slow + `, '` + stationList[index].car + `')">
                            <i class="fas fa-info-circle"></i>
                            <span>상세정보</span>
                        </button>
                    </div>
                </div>`;
                
                // <button class="action-button secondary" onclick="showStationDetail('${station.stationId}')">
                $list.append(html);
				
                console.log("사이드바 마커 찍기~");
                console.log("index => "+stationList[index].stationAddress);
                
                var address = stationList[index].stationAddress;
                var lat = stationList[index].evseLocationLatitude;
                var lng = stationList[index].evseLocationLongitude;
                var name = stationList[index].stationName;
                var rapid = stationList[index].rapid;
                var slow = stationList[index].slow;
                var car = stationList[index].car;
                console.log(address);
	            // window.addMarker(stationList[index].stationAddress, stationList[index].evseLocationLatitude, stationList[index].evseLocationLongitude, stationList[index].stationName, "0", "0", "0");
	            window.addMarker(address, lat, lng, name, rapid, slow, car);

            });
            
            // 이벤트 리스너 다시 연결
            // 즐겨찾기 토글
            const favoriteButtons = document.querySelectorAll('.favorite-btn');
            favoriteButtons.forEach(btn => {
                btn.addEventListener('click', function(e) {
                    e.preventDefault();
                    this.classList.toggle('active');
                    
                    const stationId = this.closest('.station-item').getAttribute('data-id');
                    const isFavorite = this.classList.contains('active');
                    
                    console.log(`충전소 ${stationId} 즐겨찾기 ${isFavorite ? '추가' : '제거'}`);
                    
                    const activeFilter = document.querySelector('.filter-chip.active');
                    if (activeFilter && activeFilter.getAttribute('data-filter') === 'favorite') {
                        applyFilter('favorite');
                    }
                });
            });
            
            // 사용 가능한 충전소 수 업데이트
            const availableStations = document.querySelectorAll('.station-status.available');
            document.getElementById('available-count').textContent = availableStations.length;

            alert("성공적으로 검색되었습니다.");
        },
        error: function(xhr, status, error) {
            console.error("AJAX 오류:", status, error);
            console.log("응답 텍스트:", xhr.responseText);
            alert("서버 요청 중 오류가 발생했습니다.");
        }
    });
}


// 모든 즐겨찾기 버튼에 클릭 이벤트를 추가
document.querySelectorAll('.filter-chip').forEach(button => {
    button.addEventListener('click', function() {
        // 버튼의 data-filter 값이 'favorite'인 경우만 처리
        if (this.dataset.filter === 'favorite') {
            saveFavorite();
        }
    });
});

// 모든 즐겨찾기 버튼에 클릭 이벤트를 추가
document.querySelectorAll('.filter-chip').forEach(button => {
    button.addEventListener('click', function() {
        if (this.dataset.filter === 'favorite') {
            // 서버로 즐겨찾기 데이터 전송
            saveFavorite(favoriteData);
        }
    });
});

//--------------------------여기 추가
function saveFavorite(e) {
    const button = e.target.closest('.favorite-btn');

    // 1) payload 구성
    const data = {
        user_no: user_no,   // JSP에서 정의한 전역 변수
        stnAddr: button.dataset.stnaddr,
        stnPlace: button.dataset.stnplace,
        rapidCnt: parseInt(button.dataset.rapidcnt, 10),
        slowCnt: parseInt(button.dataset.slowcnt, 10),
        carType: button.dataset.cartype
    };

    // 2) active 여부에 따라 URL 결정
    const isActive = button.classList.contains('active');
    const url = isActive ? '/favorite/delete' : '/favorite/add';

    // 3) fetch 호출
    fetch(url, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(data)
    })
    .then(res => res.text())
    .then(result => {
        console.log('서버 응답:', result);

        // 4) 서버에서 "success" 반환 시에만 UI 토글
        if (result === 'success') {
            button.classList.toggle('active');
        } else {
            alert(result);
        }
    })
    .catch(err => {
        console.error('통신 오류:', err);
        alert('서버와 통신 중 오류가 발생했습니다.');
    });
}

// 모든 .favorite-btn 에 이 함수 바인딩 (inline onclick 대신 사용 가능)
document.querySelectorAll('.favorite-btn')
        .forEach(btn => btn.addEventListener('click', saveFavorite));
</script>