-- @block
CREATE TABLE Users(
    id INT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(255) NOT NULL UNIQUE,
    bio TEXT,
    country VARCHAR(2)
);

-- @block 
INSERT INTO Users(email, bio, country)VALUES
('alice@example.com', 'Nature lover and traveler', 'US'),
('bob@example.com', 'Software engineer and blogger', 'CA'),
('carol@example.com', 'Photographer and adventurer', 'GB'),
('dave@example.com', 'Chef who loves street food', 'AU'),
('eve@example.com', 'Freelance writer and poet', 'NZ');

-- @block
SELECT * FROM Users
WHERE country = 'US'
ORDER BY id DESC

-- @block
CREATE INDEX email_index ON Users(email)

-- @block
SELECT * FROM Users

-- @block
CREATE TABLE Rooms(
    id INT AUTO_INCREMENT,
    street VARCHAR(255),
    owner_id INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (owner_id) REFERENCES Users(id)
);

-- @block
INSERT INTO Rooms (street, owner_id) VALUES 

-- @block
INSERT INTO Rooms (street, owner_id) VALUES 
('123 Palm Street', 1),
('456 Ocean Avenue', 2),
('789 Sunset Boulevard', 3),
('321 Maple Drive', 4),
('654 Cedar Road', 5);

-- @block 
SELECT * FROM Rooms

-- @block
SELECT * FROM Users
INNER JOIN Rooms
ON Rooms.owner_id = Users.id

-- @block
SELECT * FROM Users
LEFT JOIN Rooms
ON Rooms.owner_id = Users.id

-- @block
SELECT * FROM Users
RIGHT JOIN Rooms
ON Rooms.owner_id = Users.id

-- @block
CREATE TABLE Bookings(
    id INT AUTO_INCREMENT,
    guest_id INT NOT NULL,
    room_id INT NOT NULL,
    check_in DATETIME,
    PRIMARY KEY (id),
    FOREIGN KEY (guest_id) REFERENCES Users(id),
    FOREIGN KEY (room_id) REFERENCES Rooms(id)
);

-- @block
INSERT INTO Bookings (guest_id, room_id, check_in) VALUES
(3, 6, '2025-05-01 15:00:00'), -- Alice books Bob's room
(1, 7, '2025-05-02 16:00:00'), -- Bob books Carol's room
(5, 8, '2025-05-03 17:00:00'), -- Carol books Alice's room
(2, 9, '2025-05-04 18:00:00'), -- Dave books Eve's room
(4, 10, '2025-05-05 19:00:00'); -- Eve books Dave's room

-- @block Rooms a user has booked
SELECT 
    guest_id,
    street,
    check_in
FROM Bookings
INNER JOIN Rooms ON Rooms.owner_id = guest_id
WHERE guest_id = 1;

-- @block Guests who stayed in a room_id
SELECT
    room_id,
    guest_id,
    email,
    bio
FROM Bookings
INNER JOIN Users ON Users.id = guest_id
WHERE room_id = 2;

-- @block 
DELETE FROM Bookings;
ALTER TABLE Bookings AUTO_INCREMENT = 1;

DELETE FROM Rooms;
ALTER TABLE Rooms AUTO_INCREMENT = 1;

DELETE FROM Users;
ALTER TABLE Users AUTO_INCREMENT = 1;




