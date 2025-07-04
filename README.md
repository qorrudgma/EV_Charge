# EV_Charge 
<img src="EV_Charge/src/main/resources/static/image/EV_Charge.png" alt="EV Charge 로고" width="200"/>

**EV_Charge**는 전국의 전기차 충전소 위치 및 실시간 충전 가능 여부를 확인할 수 있는 웹사이트입니다.  
사용자는 지도를 통해 가까운 충전소를 쉽게 찾고, 실시간 상태를 확인하여 효율적으로 충전소를 이용할 수 있습니다.

---

## 🌟 주요 기능(기여도: 상: ⭐/ 중: ★/ 하: ☆)

 ✅*개발 완료*
| 기능명 | 설명 | 기여도 |
|--------|------|--------|
| **전국 전기차 충전소 위치 시각화** | Kakao Map API를 활용해 지도 기반 충전소 위치 제공 | 중 ★ |
| **실시간 충전 가능 여부 표시** | 공공데이터 API로 실시간 충전 상태 시각화 | 상 ⭐ |
| **다양한 검색 기능** <br> (지역 / 현재 지도 / 키워드) | Redis 캐시로 빠른 검색 + Elasticsearch로 정확도 높은 검색 | 상 ⭐ |
| **게시판 및 공지사항 기능** | 커뮤니티 게시판 + 관리자 공지사항 등록/관리 | 중 ★ |

⏳*개발 예정*<br>
| 기능명 | 설명 |
|--------|------|
| **즐겨찾기 기능** | 로그인 사용자 기반의 즐겨찾기 등록 및 <br> 마이페이지에서 관리 기능 제공 |
| **리뷰 및 별점 기능** | 사용자 리뷰 등록/수정/삭제 및 <br> 충전소 별점 평균 표시 |
| **마이페이지 기능** | 내 정보, 즐겨찾기, 내가 쓴 글/리뷰 등 <br> 개인화 정보 제공 |


---

## 🛠 사용 기술 스택

- 🎨 Frontend<br>
<img src="https://img.shields.io/badge/HTML5-E34F26?style=flat&logo=html5&logoColor=white" height="25" /> <img src="https://img.shields.io/badge/CSS3-1572B6?style=flat&logo=css3&logoColor=white" height="25" /> <img src="https://img.shields.io/badge/JavaScript-F7DF1E?style=flat&logo=javascript&logoColor=black" height="25" /> <img src="https://img.shields.io/badge/jQuery-0769AD?style=flat&logo=jquery&logoColor=white" height="25" />

- 🔧 Backend<br>
<img src="https://img.shields.io/badge/Java-17-007396?style=flat&logo=java&logoColor=white" height="25" /> <img src="https://img.shields.io/badge/SpringBoot-6DB33F?style=flat&logo=springboot&logoColor=white" height="25" /> <img src="https://img.shields.io/badge/AJAX-0054A6?style=flat&logo=code&logoColor=white" height="25" /> <img src="https://img.shields.io/badge/FETCH-00A9E0?style=flat&logo=javascript&logoColor=white" height="25" />

- 🗃 Database<br>
       <img src="https://img.shields.io/badge/MySQL-005C84?style=flat&logo=mysql&logoColor=white" height="25" />

- 🔍 Data Processing & Search<br>
<img src="https://img.shields.io/badge/Hadoop-66CCFF?style=flat&logo=apachehadoop&logoColor=black" height="25" /> <img src="https://img.shields.io/badge/Spark-FF9900?style=flat&logo=apachespark&logoColor=white" height="25" /> <img src="https://img.shields.io/badge/Elasticsearch-005571?style=flat&logo=elasticsearch&logoColor=white" height="25" />

- ☁️ 실행 환경 (Infra)<br>
<img src="https://img.shields.io/badge/Docker-2496ED?style=flat&logo=docker&logoColor=white" height="25" /> <img src="https://img.shields.io/badge/Redis-DC382D?style=flat&logo=redis&logoColor=white" height="25" /><br>
`Elasticsearch / Redis 실행 환경 구성용`

- 🔗 API & 외부 데이터<br>
<img src="https://img.shields.io/badge/Kakao%20Map-FFCD00?style=flat&logo=kakaotalk&logoColor=black" height="25" /> <img src="https://img.shields.io/badge/Public%20Data%20API-0064FF?style=flat&logo=data&logoColor=white" height="25" />

- 🛠 개발 도구 & 빌드<br>
<img src="https://img.shields.io/badge/Gradle-02303A?style=flat&logo=gradle&logoColor=white" height="25" /> <img src="https://img.shields.io/badge/Visual%20C++-00599C?style=flat&logo=visualstudio&logoColor=white" height="25" />


---

## ERD
![image](https://github.com/user-attachments/assets/f5c43908-7c2a-4d65-a080-eb0821ac3b8c)


---

## 주요 화면 설명
메인화면
![image](https://github.com/user-attachments/assets/1e83b888-6e2c-4794-8b65-a0082a7c33da)

로그인
![image](https://github.com/user-attachments/assets/3ac0aa19-adc2-42dd-b76a-6b827453e50d)

회원가입
![image](https://github.com/user-attachments/assets/5a03242a-ffa3-4c5a-abbc-d7842d8dfda2)
![image](https://github.com/user-attachments/assets/65e79261-605e-4a20-b0e4-84d2ac728bde)
![image](https://github.com/user-attachments/assets/6be4515c-ab76-44b4-86a9-6183dcbc5b1f)

상단 지역 기반 검색
![image](https://github.com/user-attachments/assets/72ce9e03-f8c7-4079-9efe-484493fbc2dc)

현위치 기반 검색
![image](https://github.com/user-attachments/assets/c0a795f1-c9ed-426f-80b3-e874dede9be1)

검색어 기반 검색
![image](https://github.com/user-attachments/assets/a78f9dd6-2d4b-4e3e-8481-c1466e165e37)

상세정보 클릭
![image](https://github.com/user-attachments/assets/c5346d40-c8ae-4200-a440-3d8b4862e984)

예약하기 클릭
![image](https://github.com/user-attachments/assets/a366b26a-792d-4609-82b2-01b502196f0e)

길찾기 클릭
![image](https://github.com/user-attachments/assets/deb0db30-6e8a-4edf-9770-51861889b22b)


