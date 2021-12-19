CREATE TABLE KHACH_HANG (
MAKH varchar(6) NOT NULL PRIMARY KEY ,
TenKH varchar(50),
DiaChi varchar(50),
SoDT char(11)
)

CREATE TABLE PHONG (
MaPhong varchar(5) NOT NULL PRIMARY KEY ,
LoaiPhong varchar(6),
SoKhachToiDa int(2),
GiaPhong DECIMAL(6,3),
MoTa varchar(255)
)

CREATE TABLE DICH_VU_DI_KEM(
MaDV varchar(5) NOT NULL PRIMARY KEY,
TenDV varchar(10),
DonViTinh varchar(3),
DonGia DECIMAL(6,3)
)

CREATE TABLE DAT_PHONG (
MaDatPhong varchar(5) NOT NULL PRIMARY KEY,
MaPhong varchar(5),
MaKH varchar(6),
NgayDat date,
GioBatDau TIME,
GioKetThuc TIME,
TienDatCoc DECIMAL(6,3),
GhiChu varchar(255),
TrangThaiDat varchar(50),
FOREIGN KEY (MaPhong) REFERENCES PHONG(MaPhong) ON DELETE CASCADE,
FOREIGN KEY (MaKH) REFERENCES KHACH_HANG(MaKH) ON DELETE CASCADE
)

CREATE TABLE CHI_TIET_SU_DUNG_DV(
MaDatPhong varchar(5) NOT NULL,
MaDV varchar(5),
SoLuong int(2),
PRIMARY KEY (MaDatPhong ,MaDV),
FOREIGN KEY (MaDatPhong) REFERENCES DAT_PHONG(MaDatPhong) ON DELETE CASCADE
)

INSERT INTO `phong` (`MAPHONG`, `LOAIPHONG`, `SOKHACHTOIDA`, `GIAPHONG`, `MOTA`) VALUES
('P0001', 'LOAI 1', 20, 60.000, ''),
('P0002', 'LOAI 2', 25, 80.000, ''),
('P0003', 'LOAI 3', 15, 50.000, ''),
('P0004', 'LOAI 4', 20, 50.000, '');
 
INSERT INTO `khach_hang` (`MAKH`, `TENKH`, `DIACHI`, `SODT`) VALUES
('KH0001', 'Nguyen Huu Thang', 'Hai Phong', '097973454'),
('KH0002', 'Ha Van Duong', 'Hai Phong', '123224'),
('KH0003', 'Le Thi Thu', 'Hai Phong', '867868786'),
('KH0004', 'Vuong Thu Huong', 'Hai Phong', '2234324');
 
INSERT INTO `dich_vu_di_kem` (`MADV`, `TENDV`, `DONVITINH`, `DONGIA`) VALUES
('DV001', 'HOT GIRL', 'EM', '10.000'),
('DV002', 'HOA HAU', 'EM', '20.000'),
('DV003', 'BEER', 'LON', '10.000'),
('DV004', 'TRAI CAY', 'DIA', '35.000');
 
 
INSERT INTO `dat_phong` (`MADATPHONG`, `MAPHONG`, `MAKH`, `NGAYDAT`, `GIOBATDAU`, `GIOKETTHUC`, `TIENDATCOC`, `GHICHU`, `TRANGTHAIDAT`) VALUES
('DP001', 'P0001', 'KH0002', '2018-03-26', '11:00:00', '13:00:00', '100.000', '', 'DA DAT'),
('DP002', 'P0002', 'KH0003', '2018-03-27', '17:15:00', '19:15:00', '50.000', '', 'DA HUY'),
('DP003', 'P0002', 'KH0002', '2018-03-26', '20:30:00', '22:15:00', '100.000', '', 'DA DAT'),
('DP004', 'P0003', 'KH0001', '2018-04-01', '19:30:00', '21:15:00', '200.000', '', 'DA DAT');
 
INSERT INTO `chi_tiet_su_dung_dv` (`MADATPHONG`, `MADV`, `SOLUONG`) VALUES
('DP001','DV001', 20),
('DP001', 'DV002', 10),
('DP001', 'DV003', 3),
('DP002', 'DV002', 10),
('DP002', 'DV003', 1),
('DP003', 'DV003', 2),
('DP003', 'DV004', 10);

/*Câu 1:Liệt kê MaDatPhong, MaDV, SoLuong của tất cả các dịch vụ có số lượng lớn hơn 3 và nhỏ hơn 10.*/
SELECT * FROM chi_tiet_su_dung_dv WHERE SoLuong > 3 AND SoLuong <10;
/*Câu 2 : Cập nhật dữ liệu trên trường GiaPhong thuộc bảng PHONG tăng lên 10,000 VNĐ so với giá phòng hiện tại, chỉ cập
 nhật giá phòng của những phòng có số khách tối đa lớn hơn 10.*/
 SET SQL_SAFE_UPDATES = 0;
 UPDATE phong SET GiaPhong = GiaPhong + 10
 WHERE SoKhachToiDa > 10;
 /*Câu 3: Xóa tất cả những đơn đặt phòng (từ bảng DAT_PHONG) có trạng thái đặt (TrangThaiDat) là “Da huy”.*/
 DELETE FROM dat_phong WHERE TRANGTHAIDAT = 'DA HUY';
 /*Câu 4: Hiển thị TenKH của những khách hàng có tên bắt đầu là một trong các ký tự “H”, “N”, “M” và có độ dài tối đa 
 là 20 ký tự.*/
 SELECT TenKH FROM khach_hang WHERE TenKH LIKE "N%" OR TenKH LIKE "N%" OR TenKH LIKE "M%" AND LENGTH(TenKH) <=30;
 /*Câu 5: Hiển thị TenKH của tất cả các khách hàng có trong hệ thống, TenKH nào trùng nhau thì chỉ hiển thị một lần. 
 Sử dụng hai cách khác nhau.
 */
 SELECT TenKH FROM khach_hang GROUP BY TenKH;
 SELECT distinct TenKH FROM khach_hang;
 /*Câu 6: Hiển thị MaDV, TenDV, DonViTinh, DonGia của những dịch vụ đi kèm có DonViTinh là “lon” và 
 có DonGia lớn hơn 10,000 VNĐ hoặc những dịch vụ đi kèm có DonViTinh là “Cai” và có DonGia nhỏ hơn 5,000 VNĐ.
 */
 SELECT * FROM dich_vu_di_kem WHERE (DonViTinh LIKE "lon" and DonGia>10) OR (DonViTinh LIKE "Cai" and DonGia<5) ;
 /*Câu 7: Hiển thị MaDatPhong, MaPhong, LoaiPhong, SoKhachToiDa, GiaPhong, MaKH, TenKH, SoDT, NgayDat, GioBatDau, GioKetThuc, MaDichVu, SoLuong, DonGia của những 
 đơn đặt phòng có năm đặt phòng là “2016”, “2017” và đặt những phòng có giá phòng > 50,000 VNĐ/ 1 giờ. 
 */
 SELECT *
FROM dat_phong 
INNER JOIN phong ON dat_phong.MaPhong = phong.MaPhong
INNER JOIN khach_hang ON dat_phong.MaKH = khach_hang.MaKH
INNER JOIN chi_tiet_su_dung_dv ON dat_phong.MaDatPhong=chi_tiet_su_dung_dv.MaDatPhong
WHERE (YEAR(NgayDat) = 2016 OR YEAR(NgayDat)=2017) AND GiaPhong>50

/*Câu 8 : Hiển thị MaDatPhong, MaPhong, LoaiPhong, GiaPhong, TenKH, NgayDat, TongTienHat, TongTienSuDungDichVu, 
TongTienThanhToan tương ứng với từng mã đặt phòng có trong bảng DAT_PHONG. 
Những đơn đặt phòng nào không sử dụng dịch vụ đi kèm thì cũng liệt kê thông tin của đơn đặt phòng đó ra.
TongTienHat = (GioKetThuc - GioBatDau)*GiaPhong
TongTienSuDungDichVu = SoLuong * DonGia
*/
SELECT dp.MaDatPhong, p.MaPhong, p.LoaiPhong, p.GiaPhong, kh.TenKH, dp.NgayDat,
 p.GiaPhong * (GioKetThuc - GioBatDau)  AS TongTienHat, SUM(ctsd.SoLuong * dvdk.DonGia) AS TongTienSuDungDv, 
 ( p.GiaPhong * (GioKetThuc - GioBatDau) + SUM(ctsd.SoLuong* dvdk.DonGia )) AS TongTienThanhToan
FROM dat_phong dp 
JOIN khach_hang kh ON dp.MaKH = kh.MaKH
JOIN phong p ON dp.MaPhong = p.MaPhong
JOIN chi_tiet_su_dung_dv ctsd ON dp.MaDatPhong = ctsd.MaDatPhong
JOIN dich_vu_di_kem dvdk ON ctsd.MaDV = dvdk.MaDV

/*Câu 9: Hiển thị MaKH, TenKH, DiaChi, SoDT của những khách hàng đã từng đặt phòng karaoke có địa chỉ ở 
“Hà Nội”.*/
SELECT kh.MaKH, kh.TenKH,kh.DiaChi,kh.SoDT FROM
khach_hang kh INNER JOIN dat_phong dp ON kh.MaKH = dp.MaKH
WHERE kh.DiaChi = "Hai Phong"

/*Câu 10: Hiển thị MaPhong, LoaiPhong, SoKhachToiDa, GiaPhong, SoLanDat của những phòng được khách hàng đặt 
có số lần đặt bé hơn 2 lần và trạng thái đặt là “Da dat”.
*/
SELECT p.MaPhong,p.LoaiPhong FROM dat_phong dp
INNER JOIN phong p ON dp.MaPhong = p.MaPhong
WHERE TrangThaiDat = "DA DAT"
GROUP BY p.MaPhong
HAVING COUNT(dp.MaPhong) <2 
