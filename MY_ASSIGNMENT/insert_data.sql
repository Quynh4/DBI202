USE InternetCafe;
INSERT INTO Customer (customer_name, date_of_birth, phone)
VALUES
('John Doe', '1990-01-01', '1234567890'),
('Jane Doe', '1991-02-02', '0987654321'),
('Michael Smith', '1992-03-03', '2345678901'),
('Mary Smith', '1993-04-04', '1098765432'),
('Peter Jones', '1994-05-05', '3456789012'),
('Susan Jones', '1995-06-06', '2109876543'),
('David Williams', '1996-07-07', '4567890123'),
('Sarah Williams', '1997-08-08', '3210987654'),
('William Brown', '1998-09-09', '5678901234'),
('Elizabeth Brown', '1999-10-10', '4321098765');


INSERT INTO [Staff] (staff_name, salary, phone, date_of_birth, job_title)
VALUES
    ('John Smith', 2500.00, '1234567890', '1990-05-15', 'Cashier'),
    ('Jane Doe', 2500.00, '9876543210', '1992-08-10', 'Cashier'),
    ('Michael Johnson', 2500.00, '4567890123', '1988-12-03', 'Cashier'),
    ('Emily Brown', 2500.00, '7890123456', '1995-03-21', 'Cashier'),
    ('David Wilson', 2500.00, '2345678901', '1991-07-18', 'Security guard'),
    ('Jennifer Davis', 2500.00, '8901234567', '1993-11-27', 'Security guard');


INSERT INTO [Equipment] (equipment_name, condition)
VALUES 
    ('Printer', 'G'),
    ('CCTV Camera', 'G'),
    ('Wi-Fi Router', 'G'),
    ('Cash Register', 'G'),
    ('Router', 'G'),
    ('Switch', 'G'),
    ('USB', 'G');



INSERT INTO [Computer] (computer_name, [status], manufacturer)
VALUES
    ('Computer 1', 1, 'Manufacturer A'),
    ('Computer 2', 1, 'Manufacturer B'),
    ('Computer 3', 1, 'Manufacturer A'),
    ('Computer 4', 0, 'Manufacturer B'),
    ('Computer 5', 0, 'Manufacturer A'),
    ('Computer 6', 1, 'Manufacturer B'),
    ('Computer 7', 0, 'Manufacturer A'),
    ('Computer 8', 1, 'Manufacturer B'),
    ('Computer 9', 0, 'Manufacturer A'),
    ('Computer 10', 1, 'Manufacturer B'),
    ('Computer 11', 1, 'Manufacturer A'),
    ('Computer 12', 0, 'Manufacturer B'),
    ('Computer 13', 0, 'Manufacturer A'),
    ('Computer 14', 1, 'Manufacturer B'),
    ('Computer 15', 1, 'Manufacturer A'),
    ('Computer 16', 0, 'Manufacturer B'),
    ('Computer 17', 0, 'Manufacturer A'),
    ('Computer 18', 1, 'Manufacturer B'),
    ('Computer 19', 0, 'Manufacturer A'),
    ('Computer 20', 1, 'Manufacturer B');



INSERT INTO [Pantry] (item_name, unit, price_per_unit)
VALUES
    ('Coffee', 'Cup', 1.50),
    ('Tea', 'Cup', 1.00),
    ('Soft Drink', 'Can', 1.25),
    ('Snacks', 'Pack', 2.50),
    ('Sandwich', 'Piece', 4.00),
    ('Cookies', 'Pack', 2.00);


INSERT INTO [Account] (username, [password], remaining_time_in_seconds, customer_id)
VALUES
    ('user1', 'password1', 3600, 1),
    ('user2', 'password2', 7200, 2),
    ('user3', 'password3', 1800, 3),
    ('user4', 'password4', 5400, 4),
    ('user5', 'password5', 9000, 5),
    ('user6', 'password6', 2700, 6),
    ('user7', 'password7', 4500, 7),
    ('user8', 'password8', 6300, 8),
    ('user9', 'password9', 8100, 9),
    ('user10', 'password10', 9900, 10);

INSERT INTO [SessionLog] (computer_id, account_id, log_start, log_end, log_description)
VALUES
    (1, 1, '2023-10-28 09:00:00', '2023-10-28 10:00:00', 'User 1 logged in and used the computer.'),
    (2, 2, '2023-10-28 10:30:00', '2023-10-28 11:30:00', 'User 2 logged in and used the computer.'),
    (3, 3, '2023-10-28 12:00:00', '2023-10-28 13:00:00', 'User 3 logged in and used the computer.'),
    (4, 4, '2023-10-28 13:30:00', '2023-10-28 14:30:00', 'User 4 logged in and used the computer.'),
    (5, 5, '2023-10-28 15:00:00', '2023-10-28 16:00:00', 'User 5 logged in and used the computer.'),
    (6, 6, '2023-10-28 16:30:00', '2023-10-28 17:30:00', 'User 6 logged in and used the computer.'),
    (7, 7, '2023-10-28 18:00:00', '2023-10-28 19:00:00', 'User 7 logged in and used the computer.'),
    (8, 8, '2023-10-28 19:30:00', '2023-10-28 20:30:00', 'User 8 logged in and used the computer.'),
    (9, 9, '2023-10-28 21:00:00', '2023-10-28 22:00:00', 'User 9 logged in and used the computer.'),
    (10, 10, '2023-10-28 22:30:00', '2023-10-28 23:30:00', 'User 10 logged in and used the computer.');

INSERT INTO [PaymentMethod] ([name])
VALUES
    ('Cash'),
    ('Credit Card'),
    ('Debit Card'),
    ('PayPal');

INSERT INTO [Promotion] ([name], [description])
VALUES
    ('Student Discount', 'Get special discounts for students!'),
    ('Weekend Special', 'Exclusive offers for weekends!'),
    ('First-Time User', 'Special promotion for first-time users.'),
    ('Birthday Treat', 'Enjoy a free hour on your birthday.')


-- Inserting data into ProviderType table
INSERT INTO [ProviderType] ([name], [description])
VALUES
    ('Pantry Provider', 'Provides pantry supplies for the internet cafe.'),
    ('Equipment Provider', 'Provides equipment and peripherals for the internet cafe.'),
    ('Computer Provider', 'Provides computers for the internet cafe.');

-- Inserting data into Provider table
INSERT INTO [Provider] ([name], phone, [address], [type_id])
VALUES
    ('ABC Pantry', '1234567890', '123 Main Street', 1), -- Pantry Provider
    ('XYZ Equipment', '9876543210', '456 Elm Street', 2), -- Equipment Provider
    ('123 Computers', '5555555555', '789 Oak Street', 3), -- Computer Provider
    ('Cafe Snacks', '1112223333', '789 Maple Avenue', 1), -- Additional Pantry Provider
    ('Tech Solutions', '4445556666', '321 Pine Road', 2), -- Additional Equipment Provider
    ('PC World', '7778889999', '555 Cedar Lane', 3); -- Additional Computer Provider

