import json
import random

data_array_label_front = []
top_busi_nm = [
    "한국전력공사", "환경부", "현대오일뱅크", "GS칼텍스", "SK에너지",
    "차지비", "이카플러그", "에버온", "파워큐브", "클린일렉스", "기타"
]

# 30분 단위 시간대 생성 (06:00 ~ 23:30)
time_slots = []
hour = 6
minute = 0
while hour < 24:
    time_str = f"{hour:02}:{minute:02}"
    time_slots.append(time_str)
    minute += 30
    if minute == 60:
        minute = 0
        hour += 1

# 100 충전소 × 36 시간대 = 3600 샘플 생성
for _ in range(100):  # 충전소 100개 생성
    latitude = round(random.uniform(37.45, 37.55), 5)
    longitude = round(random.uniform(126.95, 127.07), 5)
    charge_level = random.randint(1, 400)
    detour_distance = round(random.uniform(0, 10), 2)
    waiting_time = random.randint(0, 60)
    busi_nm = random.choice(top_busi_nm)

    for time in time_slots:
        reservation_count = random.randint(0, 20)  # 예약자 수 (label)

        sample = {
            "lat": latitude,
            "lng": longitude,
            "charge_level": charge_level,
            "detour_distance": detour_distance,
            "waiting_time": waiting_time,
            "busi_nm": busi_nm,
            "time": time,
            "label": reservation_count
        }

        data_array_label_front.append(sample)

# 파일로 저장
file_path = "C:/Users/user/Desktop/station_reservation_data.json"
with open(file_path, "w", encoding="utf-8") as f:
    json.dump(data_array_label_front, f, ensure_ascii=False, indent=2)

print(f"{len(data_array_label_front)}개의 학습 샘플이 저장되었습니다.")
print(f"출력 파일: {file_path}")
