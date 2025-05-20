<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>예약자 수 그래프</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>

<h2>30분 단위 예약자 수</h2>
<div style="width: 800px; height: 400px;"><canvas id="reservationChart" width="400" height="200"></canvas></div>

<script>
    // JSP에서 호출하는 REST API URL 맞게 변경할 것
    fetch('<c:url value="/reservation/data" />')
        .then(response => response.json())
        .then(data => {
            const labels = Object.keys(data);
            const values = Object.values(data);

            const ctx = document.getElementById('reservationChart').getContext('2d');
            new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: labels,
                    datasets: [{
                        label: '예약자 수',
                        data: values,
                        backgroundColor: 'rgba(54, 162, 235, 0.7)',
                    }]
                },
                options: {
                    scales: {
                        y: {
                            beginAtZero: true,
                            stepSize: 1
                        }
                    }
                }
            });
        })
        .catch(err => console.error('데이터 로드 실패:', err));
</script>

</body>
</html>
