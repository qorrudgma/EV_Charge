import json
import random

data_array_label_front = []
top_busi_nm = [
    "한국전력공사", "환경부", "현대오일뱅크", "GS칼텍스", "SK에너지",
    "차지비", "이카플러그", "에버온", "파워큐브", "클린일렉스"
]

for _ in range(4000):
    label = random.randint(0, 1)  # 혼잡 여부 (0: 비혼잡, 1: 혼잡)

    # 피처 생성
    latitude = round(random.uniform(37.45, 37.55), 5)
    longitude = round(random.uniform(126.95, 127.07), 5)
    charge_level = random.randint(1, 400)
    detour_distance = round(random.uniform(0, 10), 2)
    waiting_time = random.randint(0, 60)
    busi_nm = random.choice(top_busi_nm + ['기타'])

    # 리스트 형태로 저장
    sample = {
        "label": label,
        "lat": latitude, # 위도
        "lng": longitude, # 경도
        "charge_level": charge_level, # 충전기 충전속도
        "detour_distance": detour_distance, #우회 거리(추가이동 거리)
        "waiting_time": waiting_time, # 대기시간
        "busi_nm": busi_nm # 사업자 번호
    }

    data_array_label_front.append(sample)

# 파일로 저장
file_path = "C:/Users/user/Desktop/station_charge_data.json"
with open(file_path, "w", encoding="utf-8") as f:
    json.dump(data_array_label_front, f, ensure_ascii=False, indent=2)

print(file_path)
