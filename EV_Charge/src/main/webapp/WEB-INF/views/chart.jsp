<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.fasterxml.jackson.databind.ObjectMapper" %>

<%
    ObjectMapper mapper = new ObjectMapper();
    String logJson = mapper.writeValueAsString(request.getAttribute("log_predictions"));
    String reserveJson = mapper.writeValueAsString(request.getAttribute("reserve_dtos"));
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>충전소 분석 차트</title>
    <link rel="stylesheet" href="chart.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
    <div class="chart-container">
        <!-- 헤더 -->
        <div class="chart-header">
            <h1>충전소 분석 대시보드</h1>
        </div>

        <!-- 메인 콘텐츠 -->
        <div class="chart-content">
            <!-- 혼잡도 예측 섹션 -->
            <div class="chart-section">
                <div class="section-header">
                    <div class="section-icon">⚡</div>
                    <h2>혼잡도 예측 결과</h2>
                </div>
                <div class="chart-wrapper">
                    <div class="chart-canvas">
                        <canvas id="congestionChart" width="800" height="300"></canvas>
                    </div>
                    <div id="congestionResult" class="congestion-result"></div>
                </div>
            </div>

            <!-- 예약 현황 섹션 -->
            <div class="chart-section">
                <div class="section-header">
                    <div class="section-icon">📅</div>
                    <h2>예약 현황</h2>
                </div>
                <div class="chart-wrapper">
                    <div class="chart-canvas">
                        <canvas id="reservationChart" width="800" height="400"></canvas>
                    </div>
                </div>
            </div>

            <!-- 주변 충전소 목록 섹션 -->
            <div class="chart-section">
                <div class="section-header">
                    <div class="section-icon">🗺️</div>
                    <h2>주변 충전소 목록</h2>
                </div>
                <div class="stations-table-container">
                    <table class="stations-table">
                        <thead>
                            <tr>
                                <th>충전소명</th>
                                <th>주소</th>
                                <th>운영기관</th>
                                <th>충전기타입</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="dto" items="${addr_dtos}" varStatus="status">
                                <tr style="animation-delay: ${status.index * 0.05}s;">
                                    <td class="station-name">${dto.stat_name}</td>
                                    <td class="station-address">${dto.addr}</td>
                                    <td class="station-operator">${dto.busi_nm}</td>
                                    <td>
                                        <span class="charger-type ${dto.chger_type == '급속' ? 'fast' : 'slow'}">
                                            ${dto.chger_type}
                                        </span>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <script>
        const logData = <%= logJson %>;
        const reserveData = <%= reserveJson %>;
        console.log("logData 마지막 요소 확인:", logData[logData.length - 1]);

        // Chart.js 기본 설정
        Chart.defaults.font.family = "'Noto Sans KR', sans-serif";
        Chart.defaults.color = '#374151';

        // 시간대별 혼잡도 예측
        const timeLabels = logData.map((_, i) => "충전기" + (i + 1) + "번");
        const congestionRates = logData.map(d => d["1"] ?? Object.values(d)[1]);  // 혼잡 확률
        const nonCongestionRates = logData.map(d => d["0"] ?? Object.values(d)[0]);  // 비혼잡 확률

        const final = logData[logData.length - 1] || {};
        console.log("@# final =>", final);
        const finalCongestRate = Number(final.prob_1);  // 숫자 변환
        console.log("@# finalCongestRate =>", finalCongestRate);
        const finalCongest = isNaN(finalCongestRate) ? 0 : (finalCongestRate * 100).toFixed(1);
        console.log("@# finalCongest =>", finalCongest);
        const finalResultText = finalCongestRate > 0.5
            ? "⚠️ 혼잡할 것으로 예상됩니다."
            : "✅ 혼잡하지 않을 것으로 예상됩니다.";

        // 혼잡도 차트 생성
        new Chart(document.getElementById('congestionChart'), {
            type: 'bar',
            data: {
                labels: timeLabels,
                datasets: [
                    {
                        label: '혼잡할 확률 (%)',
                        data: congestionRates.map(v => (v * 100).toFixed(1)),
                        backgroundColor: 'rgba(239, 68, 68, 0.8)',
                        borderColor: 'rgba(239, 68, 68, 1)',
                        borderWidth: 1,
                        borderRadius: 4,
                        stack: 'stack1'
                    },
                    {
                        label: '혼잡하지 않을 확률 (%)',
                        data: nonCongestionRates.map(v => (v * 100).toFixed(1)),
                        backgroundColor: 'rgba(16, 185, 129, 0.8)',
                        borderColor: 'rgba(16, 185, 129, 1)',
                        borderWidth: 1,
                        borderRadius: 4,
                        stack: 'stack1'
                    }
                ]
            },
            options: {
                indexAxis: 'y',
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: { 
                        position: 'top',
                        labels: {
                            usePointStyle: true,
                            padding: 20,
                            font: {
                                size: 12,
                                weight: '500'
                            }
                        }
                    },
                    tooltip: {
                        backgroundColor: 'rgba(0, 0, 0, 0.8)',
                        titleColor: '#ffffff',
                        bodyColor: '#ffffff',
                        borderColor: '#10b981',
                        borderWidth: 1,
                        cornerRadius: 8,
                        callbacks: {
                            label: ctx => `${ctx.dataset.label}: ${ctx.raw}%`
                        }
                    }
                },
                scales: {
                    x: {
                        max: 100,
                        grid: {
                            color: '#f3f4f6'
                        },
                        title: { 
                            display: true, 
                            text: '확률 (%)',
                            font: {
                                size: 12,
                                weight: '600'
                            }
                        }
                    },
                    y: {
                        grid: {
                            display: false
                        }
                    }
                }
            }
        });

        // 결과 텍스트 업데이트
        const resultElement = document.getElementById('congestionResult');
        resultElement.innerHTML = `<strong>${finalCongest}%</strong> 확률로 ${finalResultText}`;
        resultElement.className = `congestion-result ${finalCongestRate > 0.5 ? 'warning' : 'success'}`;

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
                    borderColor: '#10b981',
                    backgroundColor: 'rgba(16, 185, 129, 0.1)',
                    pointBackgroundColor: '#10b981',
                    pointBorderColor: '#ffffff',
                    pointBorderWidth: 2,
                    pointRadius: 6,
                    pointHoverRadius: 8,
                    tension: 0.4,
                    fill: true,
                    borderWidth: 3
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        display: false
                    },
                    tooltip: {
                        backgroundColor: 'rgba(0, 0, 0, 0.8)',
                        titleColor: '#ffffff',
                        bodyColor: '#ffffff',
                        borderColor: '#10b981',
                        borderWidth: 1,
                        cornerRadius: 8,
                        callbacks: {
                            title: function(context) {
                                return `시간: ${context[0].label}`;
                            },
                            label: function(context) {
                                return `예약 건수: ${context.raw}건`;
                            }
                        }
                    }
                },
                scales: {
                    y: {
                        beginAtZero: true,
                        grid: {
                            color: '#f3f4f6'
                        },
                        title: { 
                            display: true, 
                            text: '예약 건수',
                            font: {
                                size: 12,
                                weight: '600'
                            }
                        }
                    },
                    x: {
                        grid: {
                            color: '#f3f4f6'
                        },
                        title: { 
                            display: true, 
                            text: '시간대',
                            font: {
                                size: 12,
                                weight: '600'
                            }
                        }
                    }
                },
                interaction: {
                    intersect: false,
                    mode: 'index'
                }
            }
        });

        // 페이지 로드 애니메이션
        document.addEventListener('DOMContentLoaded', function() {
            const sections = document.querySelectorAll('.chart-section');
            sections.forEach((section, index) => {
                section.style.opacity = '0';
                section.style.transform = 'translateY(20px)';
                
                setTimeout(() => {
                    section.style.transition = 'opacity 0.6s ease, transform 0.6s ease';
                    section.style.opacity = '1';
                    section.style.transform = 'translateY(0)';
                }, index * 200);
            });
        });
    </script>
</body>
</html>