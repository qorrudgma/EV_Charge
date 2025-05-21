import json
import random

data_array_label_front = []

for _ in range(400000):
    label = random.randint(0, 2)
    features = [
        round(random.uniform(37.45, 37.55), 5),   # latitude
        round(random.uniform(126.95, 127.07), 5), # longitude
        random.randint(10, 90),                    # charge_level
        round(random.uniform(0, 10), 2),           # detour_distance
        random.randint(0, 60)                      # waiting_time
    ]
    sample = [label] + features
    data_array_label_front.append(sample)

file_path = "C:/Users/user/Desktop/station_charge_data.json"
with open(file_path, "w") as f:
    json.dump(data_array_label_front, f, ensure_ascii=False, indent=2)

file_path