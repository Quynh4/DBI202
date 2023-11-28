
-- Insert data into the tblDepartment table
INSERT INTO tblDepartment (depNum, depName, mgrSSN, mgrAssDate)
VALUES (1, N'Phỏng Phần mềm trong nước', '30121050037', '2003-01-10'),
       (2, N'Phòng Phần mềm nước ngoài', '30121050142', '2005-01-06'),
       (3, N'Phòng Giải pháp mạng truyền thông', '30121050254', '2000-01-01');

-- Insert data into the tblLocation table
INSERT INTO tblLocation (locNum, locName)
VALUES (1, N'TP Hà Nội'),
       (2, N'TP Hải Phòng'),
       (3, N'TP Đà Nẵng');


-- Insert data into the tblProject table
INSERT INTO tblProject (proNum, proName, locNum, depNum)
VALUES (1, 'Project A', 1, 1),
       (2, 'Project B', 2, 2),
       (3, 'ProjectC', 3, 2)
