<%@ page contentType="text/html; charset=UTF-8" %>
    <html>

    <head>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    </head>

    <body>

        <h2>즐겨찾기 관리</h2>

        <!-- 예시 충전소 ID 버튼 -->
        <button onclick="addFavorite(101)">즐겨찾기 추가</button>
        <button onclick="removeFavorite(101)">즐겨찾기 삭제</button>

        <div id="favoriteList"></div>

        <script>
            const user_no = 1; // 세션값 사용 시 세션으로 바꿀 수 있음
            const user_id = "user1";

            function addFavorite(station_id) {
                $.ajax({
                    url: "/favorites/add",
                    type: "POST",
                    contentType: "application/json",
                    data: JSON.stringify({
                        user_no: user_no,
                        user_id: user_id,
                        station_id: station_id
                    }),
                    success: function (res) {
                        alert("추가 완료");
                        getFavorites();
                    }
                });
            }

            function removeFavorite(station_id) {
                $.ajax({
                    url: "/favorites/remove",
                    type: "POST",
                    contentType: "application/json",
                    data: JSON.stringify({
                        user_no: user_no,
                        user_id: user_id,
                        station_id: station_id
                    }),
                    success: function (res) {
                        alert("삭제 완료");
                        getFavorites();
                    }
                });
            }

            function getFavorites() {
                $.ajax({
                    url: "/favorites/list",
                    type: "GET",
                    data: {
                        user_no: user_no,
                        user_id: user_id
                    },
                    success: function (data) {
                        let html = "<ul>";
                        console.log("@# test1")
                        $.each(data, function (index, item) {
                            html += `<li>충전소 ID: ${item.station_id}</li>`;
                        });
                        html += "</ul>";
                        $("#favoriteList").html(html);
                    }
                });
            }
            service.getFavorites(dto)

            $(document).ready(function () {
                getFavorites();
            });
        </script>

    </body>

    </html>