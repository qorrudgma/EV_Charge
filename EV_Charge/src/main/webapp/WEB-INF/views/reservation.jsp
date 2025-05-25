<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
    <title>EV 예약</title>
    <style>
        body {
            font-family: 'Noto Sans KR', sans-serif;
            margin: 0;
        }

        .reservation-sidebar {
            position: fixed;
            top: 140px;
            right: 0;
            width: 360px;
            background-color: #fff;
            border: #11C287 solid 4px;
            box-shadow: 0 0 10px rgba(0,0,0,0.15);
            border-radius: 20px;
            z-index: 1011;
            /* display: flex; */
            flex-direction: column;
            padding: 20px;
            display: flex;
            transform: translateX(100%);
            transition: transform 0.3s ease;
        }

        .reservation-sidebar.active {
            transform: translateX(-10%);
        }

        #close-reservation {
            align-self: flex-end;
            background-color: transparent;
            border: none;
            font-size: 16px;
            cursor: pointer;
            color: #888;
        }

        h2 {
            margin: 10px 0 20px;
            color: #11C287;
            text-align: left;
        }

        label {
            display: block;
            margin-bottom: 15px;
            color: #333;
        }

        input[type="date"] {
            padding: 8px;
            border-radius: 8px;
            border: 1px solid #ccc;
            width: 100%;
        }

        .time-button {
            display: inline-block;
            padding: 10px 14px;
            margin: 6px 4px;
            border: 1px solid #ccc;
            background-color: #f9f9f9;
            color: #333;
            border-radius: 8px;
            cursor: pointer;
            font-size: 14px;
        }

        .time-button.selected {
            background-color: #10B981;
            color: white;
            border-color: #10B981;
        }

        .time-button.disabled {
            background-color: #eee;
            cursor: not-allowed;
            color: #aaa;
        }

        #timeSlots {
            margin: 20px 0;
            text-align: center;
        }

        input[type="submit"] {
            padding: 12px;
            background-color: #11C287;
            border: none;
            color: white;
            border-radius: 10px;
            cursor: pointer;
            width: 100%;
            font-size: 16px;
            margin-top: auto;
        }

        input[type="submit"]:hover {
            background-color: #10B981;
        }
    </style>
</head>
<body>

<div class="reservation-sidebar" id="reservationSidebar">
    <button id="close-reservation">✕</button>
    <h2>충전소 예약</h2>

    <form id="reservationForm" action="reservation_ok" method="post">
        <input type="hidden" name="stat_id" id="reserve_stat"> <%-- 충전소 ID --%>

        <label>
            <input type="date" id="reservation_date" name="reservation_date" value="${current_date}" required>
        </label>

        <div id="timeSlots"></div>
        <div id="selectedTimesContainer"></div>
        <c:choose>
            <c:when test="${not empty sessionScope.user}">
                <input type="submit" value="예약하기">
            </c:when>
            <c:otherwise>
                <p style="text-align: center;">로그인 후 이용 가능합니다.</p>
            </c:otherwise>
        </c:choose>
    </form>
</div>

<script>
    // 최소 날짜 설정
    const today = new Date().toISOString().split('T')[0];
    document.getElementById("reservation_date").setAttribute("min", today);

    const MAX_SELECT = 4;
    const timeSlots = [];
    for (let hour = 9; hour <= 22; hour++) {
        timeSlots.push((hour < 10 ? "0" + hour : hour) + ":00");
        if (hour <= 22) timeSlots.push((hour < 10 ? "0" + hour : hour) + ":30");
    }

    const timeSlotsDiv = document.getElementById("timeSlots");
    const selectedTimesContainer = document.getElementById("selectedTimesContainer");

    function renderTimeSlots(disabledTimes = []) {
        timeSlotsDiv.innerHTML = "";

        timeSlots.forEach((time, idx) => {
            const btn = document.createElement("div");
            btn.className = "time-button";
            btn.textContent = time;
            btn.dataset.time = time;

            if (disabledTimes.includes(time)) {
                btn.classList.add("disabled");
            }

            btn.onclick = function () {
                if (btn.classList.contains("disabled")) return;

                const isSelected = btn.classList.contains("selected");
                const selectedButtons = document.querySelectorAll(".time-button.selected");

                if (!isSelected && selectedButtons.length >= MAX_SELECT) {
                    alert(`최대 ${MAX_SELECT}개(약 2시간)까지만 예약할 수 있습니다.`);
                    return;
                }

                btn.classList.toggle("selected");

                const inputs = selectedTimesContainer.querySelectorAll("input[name='reservation_time[]']");
                const existingInput = Array.from(inputs).find(input => input.getAttribute("data-time") === time);

                if (btn.classList.contains("selected")) {
                    if (!existingInput) {
                        const input = document.createElement("input");
                        input.type = "hidden";
                        input.name = "reservation_time[]";
                        input.value = time;
                        input.setAttribute("data-time", time);
                        selectedTimesContainer.appendChild(input);
                    }
                } else {
                    if (existingInput) existingInput.remove();
                }
            };

            timeSlotsDiv.appendChild(btn);

            if ((idx + 1) % 4 === 0) {
                timeSlotsDiv.appendChild(document.createElement("br"));
            }
        });
    }

    renderTimeSlots();

    document.getElementById("reservation_date").addEventListener("change", async function () {
        const selectedDate = this.value;
        const stat_id = $("#stat_id").val();

        $("#reserve_stat").val(stat_id)

        const currentSelectedTimes = Array.from(
            document.querySelectorAll("input[name='reservation_time[]']")
        ).map(input => input.value);

        try {
            console.log(selectedDate);
            console.log(stat_id);

            const response = await fetch("change_date?reservation_date="+ selectedDate + "&stat_id=" +stat_id);
            const disabledTimes = await response.json();

            console.log(response);
            console.log(disabledTimes);

            renderTimeSlots(disabledTimes);

            // 선택 시간 복원 (예약 안된 것만)
            currentSelectedTimes.forEach(time => {
                const btn = document.querySelector(`.time-button[data-time='${time}']`);
                if (btn && !btn.classList.contains("disabled")) {
                    btn.classList.add("selected");

                    const input = document.createElement("input");
                    input.type = "hidden";
                    input.name = "reservation_time[]";
                    input.value = time;
                    input.setAttribute("data-time", time);
                    selectedTimesContainer.appendChild(input);
                }
            });

        } catch (error) {
            console.error("시간 슬롯 불러오기 실패:", error);
        }
    });


    document.getElementById("reservationForm").addEventListener("submit", function (e) {
        const selectedTimes = Array.from(document.querySelectorAll("input[name='reservation_time[]']"))
            .map(input => input.value)
            .sort();

        if (selectedTimes.length < 1) {
            alert("예약 시간을 선택해주세요.");
            e.preventDefault();
            return;
        }

        const toMinutes = time => {
            const [h, m] = time.split(":").map(Number);
            return h * 60 + m;
        };

        const minutesArray = selectedTimes.map(toMinutes);
        for (let i = 1; i < minutesArray.length; i++) {
            if (minutesArray[i] - minutesArray[i - 1] !== 30) {
                alert("30분 간격으로 연속된 시간만 선택 가능합니다.");
                e.preventDefault();
                return;
            }
        }
    });

    // 예약 사이드바 열기
    function reservationStation() {
        document.getElementById("reservationSidebar").classList.add("active");
    }

    // 예약 사이드바 닫기
    document.getElementById("close-reservation").addEventListener("click", function () {
        document.getElementById("reservationSidebar").classList.remove("active");
    });
</script>
</body>
</html>
