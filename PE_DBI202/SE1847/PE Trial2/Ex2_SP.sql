drop database Q_trial2
create database Q_trial2
use Q_trial2

-- Create tables
drop table nhanvien

CREATE TABLE nhanvien (
  honv VARCHAR(20) NOT NULL,
  tenlot VARCHAR(20),
  ten VARCHAR(20) NOT NULL,
  manv varchar(9) primary key,
  ngsinh varchar(10),
  dchi  VARCHAR(255),
  phai varchar(3) not null CHECK(phai IN ('Nam', 'Nu')) DEFAULT 'Nam',
  luong int not null,
  ma_nql varchar(9),
  phg int
);


INSERT INTO nhanvien (honv, tenlot, ten, manv, ngsinh, dchi, phai, luong, ma_nql, phg)
VALUES ('Dinh', 'Ba', 'Tien', '123456789', '09/01/1995',
'731 Tran Hung Dao, Q1, TPHCM', 'Nam', 30000, '333445555', 5),

('Nguyen', 'Thanh', 'Tung', '333445555', '08/12/1945',
'638 Nguyen Van Cu Q5, TPHCM', 'Nam', 40000, '888665555', 5),

('Bui', 'Thuy', 'Vu', '999887777', '19/07/1958',
'332 Nguyen Thai Học Q1, TPHCM', 'Nam', 25000, '987654321', 4),

('Le', 'Thi', 'Nhan', '987654321', '20/06/1931',
'638 Nguyen Van Cu Q5, TPHCM', 'Nu', 43000, '888665555', 4),

('Nguyen', 'Manh', 'Hung', '666884444', '15/09/1952',
'975 Ba Ria, Vung Tau', 'Nam', 38000, '333445555', 5),

('Tran', 'Thanh', 'Tam', '453453453', '31/07/1962',
'543 Mai Thi Luu, Q1 TPHCM', 'Nam', 25000, '333445555', 5),

('Tran', 'Hong', 'Quan', '987987987', '29/03/1959',
'980Le Hong Phong Q10 TPHCM', 'Nam', 25000, '987654321', 4),

('Vuong', 'Ngoc', 'Quyen', '888665555', '10/10/1927',
'450 Trung Vuong HaNoi', 'Nu', 55000, null, 1)



CREATE TABLE phongban (
  tenphg VARCHAR(50) NOT NULL,
  maph int primary key,
  trphg varchar(9) not null references nhanvien(manv),
  ng_nhanchuc varchar(10)
);

INSERT INTO phongban (tenphg, maph, trphg, ng_nhanchuc)
VALUES ('Nghien cuu', 5, '333445555', '22/05/1978'),
('Dieu hanh', 4, '987987987', '01/01/1985'),
('Quan ly', 1, '888665555', '19/06/1971');

ALTER TABLE nhanvien
ADD CONSTRAINT FK_nv FOREIGN KEY (phg) references phongban(maph);

drop table diadiem_phg
CREATE TABLE diadiem_phg (
  maphg INT references phongban(maph),
  diadiem VARCHAR(50)
);

INSERT INTO diadiem_phg (maphg, diadiem)
VALUES (1, 'TP HCM'), 
 (4, 'HA NOI'), 
 (1, 'TP HCM'), 
 (5, 'VUNG TAU'), 
 (5, 'NHA TRANG'), 
 (5, 'TP HCM')

CREATE TABLE thannhan (
  ma_nvien varchar(9) not null references nhanvien(manv),
  tentn VARCHAR(20),
  phai varchar(3) not null CHECK(phai IN ('Nam', 'Nu')) DEFAULT 'Nam',
  ngsinh varchar(10),
  quanhe varchar(50)
  );


INSERT INTO thannhan (ma_nvien, tentn, phai, ngsinh, quanhe)
VALUES ('333445555', 'Quang', 'Nu', '05/04/1976', 'Con gai'),
('333445555', 'Khang', 'Nam', '25/10/1973', 'Con trai'),
('333445555', 'Duong', 'Nu', '03/05/1948', 'Vo chong'),
('987654321', 'Dang', 'Nam', '29/02/1932', 'Vo chong'),
('123456789', 'Duy', 'Nam', '05/04/1976', 'Con gai'),
('333445555', 'Quag', 'Nu', '01/01/1978', 'Con trai'),
('123456789', 'Chau', 'Nu', '31/12/1978', 'Con gai')



create table dean(
	tenda varchar(50),
	mada int primary key,
	ddiem_da varchar(50),
	phong int not null references phongban(maph)
)

INSERT INTO dean(tenda, mada, ddiem_da, phong)
VALUES 
('San pham X', 1, 'VUNG TAU', 5),
('San pham Y', 2, 'NHA TRANG', 5),
('San pham Z', 3, 'TP HCM', 5),
('Tin học hoa', 10, 'HA NOI', 4),
('Cap quang', 20, 'TP HCM', 1),
('Dao tao', 30, 'HA NOI', 4)


CREATE TABLE phancong (
  ma_nvien varchar(9) not null references nhanvien(manv),
  soda int  references dean(mada),
  thoigian decimal(10,1)
);
INSERT INTO phancong (ma_nvien, soda, thoigian)
VALUES ('123456789', 1, 32.5),
('123456789', 2, 7.5),
('666884444', 3, 40.0),
('453453453', 1, 20.0),
('453453453', 2, 20.0),
('333445555', 3, 10.0),
('333445555', 10, 10.0),
('333445555', 20, 10.0),
('999887777', 30, 30.0),
('999887777', 10, 10.0),
('987987987', 10, 35.0),
('987987987', 30, 5.0),
('987654321', 30, 20.0),
('987654321', 20, 15.0),
('888665555', 20, null)
