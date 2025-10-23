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

### 메인 페이지 <br><br>
   ![image](https://github.com/user-attachments/assets/1e83b888-6e2c-4794-8b65-a0082a7c33da)
   전국의 전기차 충전소의 위치를 검색!<br>

### 로그인 페이지 <br><br>
   ![image](https://github.com/user-attachments/assets/3ac0aa19-adc2-42dd-b76a-6b827453e50d)
   로그인으로 자주가는 충전소를 저장해 보세요!<br>

### 회원가입 페이지 <br><br>
   ![image](https://github.com/user-attachments/assets/5a03242a-ffa3-4c5a-abbc-d7842d8dfda2)
   ![image](https://github.com/user-attachments/assets/65e79261-605e-4a20-b0e4-84d2ac728bde)
   ![image](https://github.com/user-attachments/assets/6be4515c-ab76-44b4-86a9-6183dcbc5b1f)
   회원가입을 위해 개인정보를 작성하기!<br>
&nbsp;&nbsp;&nbsp;&nbsp;- 회원가입시 나의 위치를 작성해 근처 충정소를 찾아보세요.<br><br><br>

### 상단 지역 기반 검색 페이지 <br><br>
   ![image](https://github.com/user-attachments/assets/72ce9e03-f8c7-4079-9efe-484493fbc2dc)
   원하는 지역에 전기차 충전소의 위치를 찾아보기!<br>
&nbsp;&nbsp;&nbsp;&nbsp;- 현 위치나 저장된 위치가 아닌 지역명을 직접 선택하여 해당 위치에 있는 충전소를 검색할 수 있습니다.<br>
&nbsp;&nbsp;&nbsp;&nbsp;- 지역이름 역시 갑작스럽게 변경되지 않기 때문에, 실시간이 아니라 DB에서 가져옵니다.(일정주기로 업데이트 진행)<br>
&nbsp;&nbsp;&nbsp;&nbsp;- 충전소들의 위치는 마커를 통해 표시되고 여러 정보들을 가지고 있습니다.<br><br><br>

### 현위치 기반 검색 페이지 <br><br>
   ![image](https://github.com/user-attachments/assets/c0a795f1-c9ed-426f-80b3-e874dede9be1)
   현재 위치에서의 충전소 찾아보기!<br>
&nbsp;&nbsp;&nbsp;&nbsp;- 현 지도에서 검색 할 때마다, 지도의 경도 위도를 기준으로 전기차 충전소들의 위치를 표시합니.<br>
&nbsp;&nbsp;&nbsp;&nbsp;- 충전소의 위치는 갑작스럽게 변경되지 않기 때문에, 실시간이 아니라 DB에서 가져옵니다.(일정주기로 업데이트 진행)<br>
&nbsp;&nbsp;&nbsp;&nbsp;- 위치정보를 가져올때는 공간 인덱스를 활용해서 효율적인 거리 기반 탐색이 가능합니다.<br><br><br>

### 검색어 기반 검색 페이지 <br><br>
   ![image](https://github.com/user-attachments/assets/a78f9dd6-2d4b-4e3e-8481-c1466e165e37)
   충전소 이름으로 찾아보기!<br>
&nbsp;&nbsp;&nbsp;&nbsp;- 충전소 이름이나 관련 키워드를 입력하여 원하는 충전소를 검색할 수 있습니다.<br>
&nbsp;&nbsp;&nbsp;&nbsp;- 형태소 분석기와 Elasticsearch를 활용하여 단어의 의미를 분리하고, 유사한 단어나 일부 오타가 포함된 검색어도 인식할 수 있습니다.<br>
&nbsp;&nbsp;&nbsp;&nbsp;- 검색 결과는 가장 유사한 충전소가 상단에 노출됩니다.<br>
&nbsp;&nbsp;&nbsp;&nbsp;- 정확한 이름을 몰라도 원하는 충전소를 빠르고 정확하게 찾을 수 있습니다.<br><br><br>

### 상세정보 클릭 페이지 <br><br>
   ![image](https://github.com/user-attachments/assets/c5346d40-c8ae-4200-a440-3d8b4862e984)
   충전소의 다양한 정보 제공!<br>
&nbsp;&nbsp;&nbsp;&nbsp;- 충전소 주소, 충전기 수, 타입, 여러 상세정보들이 나옵니다.<br>
&nbsp;&nbsp;&nbsp;&nbsp;- 해당 위치로 지도 자동 확대.<br>
&nbsp;&nbsp;&nbsp;&nbsp;- 정보들은 검색한 시점을 기준으로 실시간 데이터와 연동됩니다.<br><br><br>

### 예약하기 클릭 페이지 <br><br>
   ![image](https://github.com/user-attachments/assets/a366b26a-792d-4609-82b2-01b502196f0e)
   충전소 예약!<br>
&nbsp;&nbsp;&nbsp;&nbsp;- 충전소를 예약할수있는 페이지가 나옵니다.<br><br><br>

### 길찾기 클릭 페이지 <br><br>
   ![image](https://github.com/user-attachments/assets/deb0db30-6e8a-4edf-9770-51861889b22b)
   충전소 까지의 길찾기!<br>
&nbsp;&nbsp;&nbsp;&nbsp;- 해당 충전소까지 가는 길을 찾아줍니다.<br><br><br>
