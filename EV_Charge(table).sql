-- 유저 테이블
create table EV_user (
			user_no int auto_increment primary key, 	-- 순서를 위한 자동 증가 번호
		    user_id varchar(50) not null unique,    	-- 사용자 ID
		    user_password varchar(100) not null,        -- 비밀번호
			user_name varchar(20) not null,         	-- 이름
			user_email varchar(50),            			-- 이메일
			user_province VARCHAR(50),                  -- 도
			user_city VARCHAR(50)                    	-- 시
		);
select * from EV_user;
-- 시/도 테이블
CREATE TABLE provinces (
    provinces_code VARCHAR(2) PRIMARY KEY,
    provinces_name VARCHAR(20) NOT NULL
);

-- 시/도 테이블 데이터
INSERT INTO provinces (provinces_code, provinces_name) VALUES
('11', '서울특별시'),
('21', '부산광역시'),
('22', '대구광역시'),
('23', '인천광역시'),
('24', '광주광역시'),
('25', '대전광역시'),
('26', '울산광역시'),
('31', '경기도'),
('32', '강원도'),
('33', '충청북도'),
('34', '충청남도'),
('35', '전라북도'),
('36', '전라남도'),
('37', '경상북도'),
('38', '경상남도'),
('39', '제주특별자치도'),
('41', '세종특별자치시');

-- 시/군/구 테이블
CREATE TABLE districts (
    districts_code VARCHAR(2) NOT NULL,
    districts_name VARCHAR(30) NOT NULL,
    provinces_code VARCHAR(2) NOT NULL
);

-- 시/군/구 테이블 데이터
INSERT INTO districts (districts_code, districts_name, provinces_code) VALUES
-- 서울특별시
('11', '종로구', '11'),
('12', '중구', '11'),
('13', '용산구', '11'),
('14', '성동구', '11'),
('15', '동대문구', '11'),
('16', '성북구', '11'),
('17', '도봉구', '11'),
('18', '은평구', '11'),
('19', '서대문구', '11'),
('20', '마포구', '11'),
('21', '강서구', '11'),
('22', '구로구', '11'),
('23', '영등포구', '11'),
('24', '동작구', '11'),
('25', '관악구', '11'),
('26', '강남구', '11'),
('27', '강동구', '11'),
('28', '송파구', '11'),
('29', '중랑구', '11'),
('30', '노원구', '11'),
('31', '서초구', '11'),
('32', '양천구', '11'),
('33', '광진구', '11'),
('34', '강북구', '11'),
('35', '금천구', '11'),
('99', '미분류', '11'),

-- 부산광역시
('11', '중구', '21'),
('12', '서구', '21'),
('13', '동구', '21'),
('14', '영도구', '21'),
('15', '부산진구', '21'),
('16', '동래구', '21'),
('17', '남구', '21'),
('18', '북구', '21'),
('19', '해운대구', '21'),
('20', '사하구', '21'),
('21', '금정구', '21'),
('22', '강서구', '21'),
('23', '연제구', '21'),
('24', '수영구', '21'),
('25', '사상구', '21'),
('30', '기장군', '21'),
('99', '미분류', '21'),

-- 대구광역시
('11', '중구', '22'),
('12', '동구', '22'),
('13', '서구', '22'),
('14', '남구', '22'),
('15', '북구', '22'),
('16', '수성구', '22'),
('17', '달서구', '22'),
('30', '달성군', '22'),
('99', '미분류', '22'),

-- 인천광역시
('11', '중구', '23'),
('12', '동구', '23'),
('13', '미추홀구', '23'),
('15', '서구', '23'),
('16', '남동구', '23'),
('17', '부평구', '23'),
('18', '계양구', '23'),
('19', '연수구', '23'),
('30', '강화군', '23'),
('31', '옹진군', '23'),
('99', '미분류', '23'),

-- 광주광역시
('11', '동구', '24'),
('12', '서구', '24'),
('13', '북구', '24'),
('14', '광산구', '24'),
('15', '남구', '24'),
('99', '미분류', '24'),

-- 대전광역시
('11', '동구', '25'),
('12', '중구', '25'),
('13', '서구', '25'),
('14', '대덕구', '25'),
('15', '유성구', '25'),
('99', '미분류', '25'),

-- 울산광역시
('60', '북구', '26'),
('61', '동구', '26'),
('62', '중구', '26'),
('63', '남구', '26'),
('64', '울주군', '26'),
('99', '미분류', '26'),

-- 경기도
('13', '의정부시', '31'),
('15', '부천시', '31'),
('16', '광명시', '31'),
('17', '평택시', '31'),
('18', '동두천시', '31'),
('19', '안산시 상록구', '31'),
('21', '과천시', '31'),
('22', '구리시', '31'),
('23', '오산시', '31'),
('24', '군포시', '31'),
('25', '의왕시', '31'),
('26', '시흥시', '31'),
('27', '남양주시', '31'),
('28', '하남시', '31'),
('31', '양주시', '31'),
('33', '여주시', '31'),
('35', '화성시', '31'),
('37', '파주시', '31'),
('39', '광주시', '31'),
('40', '연천군', '31'),
('41', '포천시', '31'),
('42', '가평군', '31'),
('43', '양평군', '31'),
('44', '이천시', '31'),
('45', '용인시 처인구', '31'),
('46', '안성시', '31'),
('47', '김포시', '31'),
('48', '안산시', '31'),
('49', '안산시 단원구', '31'),
('61', '부천시 원미구', '31'),
('62', '부천시 소사구', '31'),
('63', '부천시 오정구', '31'),
('64', '부천시 남구', '31'),
('67', '성남시', '31'),
('68', '성남시 수정구', '31'),
('69', '성남시 중원구', '31'),
('70', '성남시 분당구', '31'),
('73', '수원시', '31'),
('74', '수원시 장안구', '31'),
('75', '수원시 권선구', '31'),
('76', '수원시 팔달구', '31'),
('77', '수원시 영통구', '31'),
('79', '안양시', '31'),
('80', '안양시 만안구', '31'),
('81', '안양시 동안구', '31'),
('84', '고양시', '31'),
('85', '고양시 덕양구', '31'),
('86', '고양시 일산동구', '31'),
('87', '고양시 일산서구', '31'),
('89', '용인시', '31'),
('90', '용인시 기흥구', '31'),
('91', '용인시 수지구', '31'),
('99', '미분류', '31'),

-- 강원도
('11', '춘천시', '32'),
('12', '원주시', '32'),
('13', '강릉시', '32'),
('14', '동해시', '32'),
('15', '태백시', '32'),
('16', '속초시', '32'),
('17', '삼척시', '32'),
('32', '홍천군', '32'),
('33', '횡성군', '32'),
('35', '영월군', '32'),
('36', '평창군', '32'),
('37', '정선군', '32'),
('38', '철원군', '32'),
('39', '화천군', '32'),
('40', '양구군', '32'),
('41', '인제군', '32'),
('42', '고성군', '32'),
('43', '양양군', '32'),
('99', '미분류', '32'),

-- 충청북도
('12', '충주시', '33'),
('13', '제천시', '33'),
('31', '청원군', '33'),
('32', '보은군', '33'),
('33', '옥천군', '33'),
('34', '영동군', '33'),
('35', '진천군', '33'),
('36', '괴산군', '33'),
('37', '음성군', '33'),
('40', '단양군', '33'),
('60', '청주시', '33'),
('61', '청주시 상당구', '33'),
('62', '청주시 흥덕구', '33'),
('63', '증평군', '33'),
('64', '청주시 청원구', '33'),
('65', '청주시 서원구', '33'),
('99', '미분류', '33'),

-- 충청남도
('11', '천안시', '34'),
('12', '아산시', '34'),
('13', '보령시', '34'),
('14', '공주시', '34'),
('15', '서산시', '34'),
('21', '천안시 동남구', '34'),
('22', '천안시 서북구', '34'),
('31', '금산군', '34'),
('33', '연기군', '34'),
('34', '계룡시', '34'),
('35', '논산시', '34'),
('36', '부여군', '34'),
('37', '서천군', '34'),
('39', '청양군', '34'),
('40', '홍성군', '34'),
('41', '예산군', '34'),
('43', '당진시', '34'),
('46', '태안군', '34'),
('99', '미분류', '34'),

-- 전라북도
('12', '군산시', '35'),
('13', '익산시', '35'),
('14', '정읍시', '35'),
('15', '남원시', '35'),
('16', '김제시', '35'),
('31', '완주군', '35'),
('32', '진안군', '35'),
('33', '무주군', '35'),
('34', '장수군', '35'),
('35', '임실군', '35'),
('37', '순창군', '35'),
('39', '고창군', '35'),
('40', '부안군', '35'),
('60', '전주시', '35'),
('61', '전주시 덕진구', '35'),
('62', '전주시 완산구', '35'),
('99', '미분류', '35'),

-- 전라남도
('11', '목포시', '36'),
('12', '여수시', '36'),
('13', '순천시', '36'),
('14', '나주시', '36'),
('16', '광양시', '36'),
('32', '담양군', '36'),
('33', '곡성군', '36'),
('34', '구례군', '36'),
('38', '고흥군', '36'),
('39', '보성군', '36'),
('40', '화순군', '36'),
('41', '장흥군', '36'),
('42', '강진군', '36'),
('43', '해남군', '36'),
('44', '영암군', '36'),
('45', '무안군', '36'),
('47', '함평군', '36'),
('48', '영광군', '36'),
('49', '장성군', '36'),
('50', '완도군', '36'),
('51', '진도군', '36'),
('52', '신안군', '36'),
('99', '미분류', '36'),

-- 경상북도
('12', '경주시', '37'),
('13', '김천시', '37'),
('14', '안동시', '37'),
('15', '구미시', '37'),
('16', '영주시', '37'),
('17', '영천시', '37'),
('18', '상주시', '37'),
('19', '문경시', '37'),
('20', '경산시', '37'),
('32', '군위군', '37'),
('33', '의성군', '37'),
('35', '청송군', '37'),
('36', '영양군', '37'),
('37', '영덕군', '37'),
('42', '청도군', '37'),
('43', '고령군', '37'),
('44', '성주군', '37'),
('45', '칠곡군', '37'),
('50', '예천군', '37'),
('52', '봉화군', '37'),
('53', '울진군', '37'),
('54', '울릉군', '37'),
('60', '포항시', '37'),
('61', '포항시 남구', '37'),
('62', '포항시 북구', '37'),
('99', '미분류', '37'),

-- 경상남도
('13', '진주시', '38'),
('14', '창원시', '38'),
('15', '창원시 진해구', '38'),
('16', '통영시', '38'),
('17', '사천시', '38'),
('18', '김해시', '38'),
('19', '밀양시', '38'),
('20', '거제시', '38'),
('32', '의령군', '38'),
('33', '함안군', '38'),
('34', '창녕군', '38'),
('36', '양산시', '38'),
('42', '고성군', '38'),
('44', '남해군', '38'),
('45', '하동군', '38'),
('46', '산청군', '38'),
('47', '함양군', '38'),
('48', '거창군', '38'),
('49', '합천군', '38'),
('59', '울산시', '38'),
('60', '울산시 북구', '38'),
('61', '울산시 동구', '38'),
('62', '울산시 중구', '38'),
('63', '울산시 남구', '38'),
('64', '울산시 울주군', '38'),
('65', '창원시 마산합포구', '38'),
('66', '창원시 마산회원구', '38'),
('67', '창원시 의창구', '38'),
('68', '창원시 성산구', '38'),
('99', '미분류', '38'),

-- 제주특별자치도
('11', '제주시', '39'),
('12', '서귀포시', '39'),
('99', '미분류', '39'),

-- 세종특별자치시
('11', '세종시', '41'),
('99', '미분류', '41');

-- 충전소 카테고리 테이블
CREATE TABLE EV_station_category (
    station_category INT PRIMARY KEY,
    station_category_desc VARCHAR(100)
);

-- 충전기 상태 테이블
CREATE TABLE EV_charger_stat (
    charger_stat INT PRIMARY KEY,
    charger_stat_desc VARCHAR(50)
);

-- 충전기 타입 테이블
CREATE TABLE EV_charger_type (
    charger_type INT PRIMARY KEY,
    charger_type_desc VARCHAR(100)
);


CREATE TABLE EV_station (
    station_id INT PRIMARY KEY,
    station_category INT,
    charger_id INT,
    station_name VARCHAR(100),
    station_lat INT,
    station_lng INT,
    station_addr VARCHAR(100),
    station_addr_detail VARCHAR(150),
    station_use_time VARCHAR(50),
    station_traffic_yn CHAR(1),
    station_parking_free_yn CHAR(1),
    station_note VARCHAR(200),
    FOREIGN KEY (charger_id) REFERENCES EV_charger(charger_id),
    FOREIGN KEY (station_category) REFERENCES EV_station_category(station_category)
);

-- 충전기 테이블
CREATE TABLE EV_charger (
    charger_id INT PRIMARY KEY,
    charger_stat INT,
    charger_type INT,
    FOREIGN KEY (charger_stat) REFERENCES EV_charger_stat(charger_stat),
    FOREIGN KEY (charger_type) REFERENCES EV_charger_type(charger_type)
);

-- 즐겨찾기 테이블
drop table ev_user_favorites;
CREATE TABLE ev_user_favorites (
  favorite_id INT AUTO_INCREMENT PRIMARY KEY,
  user_no INT NOT NULL,
  stat_id VARCHAR(20) NOT NULL,              -- ev_charger_data 테이블의 stat_id (문자열)
  stat_name varchar(200),
  addr VARCHAR(200),                            -- 주소
  addr_detail VARCHAR(200),                      -- 주소상세
    location VARCHAR(200),                         -- 상세위치
    lat DOUBLE,                               -- 위도
    lng DOUBLE,                               -- 경도
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- 즐겨찾기 추가 일시

  UNIQUE KEY uq_user_station (user_no, stat_id), -- 사용자별 충전소 즐겨찾기 중복 방지
  FOREIGN KEY (user_no) REFERENCES EV_user(user_no) ON DELETE CASCADE ON UPDATE CASCADE
);

-- 충전소 위치 테이블 (공간 인덱스 추가 포함)
CREATE TABLE ev_charger_data (
    ev_charger_id INT AUTO_INCREMENT PRIMARY KEY,             -- 자동증가 기본키
    stat_id VARCHAR(20) NOT NULL,                             -- 충전소 ID
    chger_id VARCHAR(10) NOT NULL,                            -- 충전기 ID
    stat_name VARCHAR(100),                                   -- 충전소명
    chger_type VARCHAR(10),                                   -- 충전기 타입
    addr VARCHAR(200),                                        -- 주소
    addr_detail VARCHAR(200),                                 -- 주소 상세
    location VARCHAR(200),                                    -- 상세 위치
    lat DOUBLE,                                               -- 위도
    lng DOUBLE,                                               -- 경도
	-- 공간 좌표 (공간 인덱스를 위한 POINT 타입)
    location_point POINT NOT NULL SRID 4326,
    use_time VARCHAR(100),                                    -- 이용가능 시간
    busi_id VARCHAR(10),                                      -- 기관 ID
    bnm VARCHAR(100),                                         -- 기관명
    busi_nm VARCHAR(100),                                     -- 운영기관명
    busi_call VARCHAR(50),                                    -- 운영기관 연락처
    output VARCHAR(10),                                       -- 충전 용량
    method VARCHAR(20),                                       -- 충전 방식
    zcode VARCHAR(10),                                        -- 지역 코드
    zscode VARCHAR(10),                                       -- 지역 상세 코드
    kind VARCHAR(10),                                         -- 충전소 구분 코드
    kind_detail VARCHAR(10),                                  -- 충전소 상세 코드
    parking_free CHAR(1),                                     -- 주차료 무료 여부
    note TEXT,                                                -- 충전소 안내
    limit_yn CHAR(1),                                         -- 이용 제한 여부
    limit_detail TEXT,                                        -- 이용 제한 상세
    del_yn CHAR(1),                                           -- 삭제 여부
    del_detail TEXT,                                          -- 삭제 상세
    traffic_yn CHAR(1),                                       -- 편의 제공 여부
    year INT,                                                 -- 설치년도
    
    -- 유니크 키
    UNIQUE KEY unique_stat_chger (stat_id, chger_id),

    -- 공간 인덱스
    SPATIAL INDEX idx_location_point (location_point)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

select zcode, zscode from ev_charger_data;

select count(*) from ev_charger_data;
select location_point from ev_charger_data;
SELECT ST_AsText(location_point) FROM ev_charger_data;
SELECT ST_SRID(location_point) FROM ev_charger_data LIMIT 1;

create table ev_notice_board(
ev_notice_boardNo int primary key auto_increment, 
ev_notice_boardName varchar(20),
ev_notice_boardTitle varchar(100),
ev_notice_boardContent varchar(300),
ev_notice_boardDate timestamp default current_timestamp,
ev_notice_boardHit int default 0,
user_no int default 0
);

CREATE TABLE ev_reservation (
    reservation_id       INT AUTO_INCREMENT PRIMARY KEY,  -- 예약 고유 ID
    stat_id              VARCHAR(20) NOT NULL,                    -- 충전소 ID (충전소 테이블 외래키)
    user_no              INT NOT NULL,                    -- 사용자 ID (회원 테이블 외래키)
    reservation_date     DATE NOT NULL,                      -- 예약 날짜 (yyyy-MM-dd)
    reservation_time     TIME NOT NULL,                      -- 예약 시간 (HH:mm, 30분 단위)
    duration_minutes     INT DEFAULT 30,                     -- 예약 시간 (기본 30분)
    status               VARCHAR(20) DEFAULT 'PENDING',      -- 예약 상태: PENDING, CONFIRMED, CANCELLED, COMPLETED
    created_at           TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at           TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE tbl_board (
	boardNo int auto_increment primary key,
	boardName varchar(20),
	boardTitle varchar(100),
	boardContent varchar(300),
	boardDate datetime default current_timestamp,
	boardHit int default 0
);
call proc_generate_random_reservations_random_time('2025-05-25');

DELIMITER //

CREATE PROCEDURE proc_generate_random_reservations_random_time(
    IN in_date DATE     -- 예약 날짜 (예: '2025-05-23')
)
BEGIN
    DECLARE i INT DEFAULT 0;
    DECLARE total_count INT DEFAULT 500;

    DECLARE rand_hour INT;
    DECLARE rand_minute INT;
    DECLARE rand_user INT;
    DECLARE rand_stat_id INT;
    DECLARE rand_duration INT;
    DECLARE time_slot TIME;

    WHILE i < total_count DO
        -- 랜덤 시간 (0~23시) + (0 또는 30분)
        SET rand_hour = FLOOR(RAND() * 24);             -- 0 ~ 23
        SET rand_minute = IF(RAND() < 0.5, 0, 30);       -- 0 or 30
        SET time_slot = MAKETIME(rand_hour, rand_minute, 0);

        SET rand_user = FLOOR(RAND() * 1000) + 1;        -- user_no 1~1000
        SET rand_stat_id = FLOOR(RAND() * 10) + 1;       -- stat_id 1~10
        SET rand_duration = (FLOOR(RAND() * 3) + 1) * 30;-- 30, 60, 90분

        INSERT INTO ev_reservation (
            stat_id,
            user_no,
            reservation_date,
            reservation_time,
            duration_minutes,
            status,
            created_at,
            updated_at
        ) VALUES (
            rand_stat_id,
            rand_user,
            in_date,
            time_slot,
            rand_duration,
            '예약됨',
            NOW(),
            NOW()
        );

        SET i = i + 1;
    END WHILE;
END //

DELIMITER ;
