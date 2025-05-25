<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.fasterxml.jackson.databind.ObjectMapper" %>

<%
    ObjectMapper mapper = new ObjectMapper();
    String logJson = mapper.writeValueAsString(request.getAttribute("log_predictions"));
    String reserveJson = mapper.writeValueAsString(request.getAttribute("reserve_dtos"));
%>

<html>
<head>
    <title>충전소 분석 차트</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
    <div style="width: 400px; height: 800px;">
        <h2>혼잡도 예측 결과</h2>
        <canvas id="congestionChart" width="800" height="300"></canvas>
        <div id="congestionResult" style="margin-top: 12px; font-size: 1.2em; font-weight: bold;"></div>

        <h2>예약 현황</h2>
        <canvas id="reservationChart" width="800" height="600"></canvas>

        <h2>주변 충전소 목록</h2>
        <table border="1" cellpadding="8">
            <thead>
                <tr>
                    <th>충전소명</th>
                    <th>주소</th>
                    <th>운영기관</th>
                    <th>충전기타입</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="dto" items="${addr_dtos}">
                    <tr>
                        <td>${dto.stat_name}</td>
                        <td>${dto.addr}</td>
                        <td>${dto.busi_nm}</td>
                        <td>${dto.chger_type}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
    <script>
        const logData = <%= logJson %>;
        const reserveData = <%= reserveJson %>;
        console.log("logData 마지막 요소 확인:", logData[logData.length - 1]);

        // 시간대별 혼잡도 예측
        const timeLabels = logData.map((_, i) => "충전기" + (i + 1) + "번");
        const congestionRates = logData.map(d => d["1"] ?? Object.values(d)[1]);  // 혼잡 확률
        const nonCongestionRates = logData.map(d => d["0"] ?? Object.values(d)[0]);  // 비혼잡 확률

        // const final = logData[logData.length - 1];
        // const finalCongest = (final["1"] * 100).toFixed(1);
        // const finalResultText = final["1"] > 0.5 ? "⚠ 혼잡할 것으로 예상됩니다." : "✅ 혼잡하지 않을 것으로 예상됩니다.";

        const final = logData[logData.length - 1] || {};
        console.log("@# final =>" + final);
        const finalCongestRate = Number(final.prob_1);  // 숫자 변환
        console.log("@# finalCongestRate =>" + finalCongestRate);
        const finalCongest = isNaN(finalCongestRate) ? 0 : (finalCongestRate * 100).toFixed(1);
        console.log("@# finalCongest =>" + finalCongest);
        const finalResultText = finalCongestRate > 0.5
            ? "⚠ 혼잡할 것으로 예상됩니다."
            : "✅ 혼잡하지 않을 것으로 예상됩니다.";

        new Chart(document.getElementById('congestionChart'), {
            type: 'bar',
            data: {
                labels: timeLabels,
                datasets: [
                    {
                        label: '혼잡할 확률 (%)',
                        data: congestionRates.map(v => (v * 100).toFixed(1)),
                        backgroundColor: 'rgba(255, 99, 132, 0.8)',
                        stack: 'stack1'
                    },
                    {
                        label: '혼잡하지 않을 확률 (%)',
                        data: nonCongestionRates.map(v => (v * 100).toFixed(1)),
                        backgroundColor: 'rgba(54, 162, 235, 0.8)',
                        stack: 'stack1'
                    }
                ]
            },
            options: {
                indexAxis: 'y',
                responsive: true,
                plugins: {
                    legend: { position: 'top' },
                    tooltip: {
                        callbacks: {
                            label: ctx => `${ctx.dataset.label}: ${ctx.raw}%`
                        }
                    }
                },
                scales: {
                    x: {
                        max: 100,
                        title: { display: true, text: '확률 (%)' }
                    }
                }
            }
        });

        document.getElementById('congestionResult').innerText =
            finalCongest+"% 확률로" +finalResultText;

        // 예약 현황 꺾은선 그래프
        const groupedByTime = {};
        reserveData.forEach(item => {
            if (!groupedByTime[item.reservation_time]) {
                groupedByTime[item.reservation_time] = 0;
            }
            groupedByTime[item.reservation_time]++;
        });

        const sortedTimes = Object.keys(groupedByTime).sort();
        const countByTime = sortedTimes.map(time => groupedByTime[time]);

        new Chart(document.getElementById('reservationChart'), {
            type: 'line',
            data: {
                labels: sortedTimes,
                datasets: [{
                    label: '예약 수',
                    data: countByTime,
                    borderColor: 'rgba(255, 159, 64, 1)',
                    backgroundColor: 'rgba(255, 159, 64, 0.3)',
                    tension: 0.4,
                    fill: true
                }]
            },
            options: {
                responsive: true,
                scales: {
                    y: {
                        beginAtZero: true,
                        title: { display: true, text: '예약 건수' }
                    },
                    x: {
                        title: { display: true, text: '시간대' }
                    }
                }
            }
        });
    </script>
</body>
</html>
