/*Problem 1
Insert the data from the example above.
-- Alter table persons and make person_id a primary key. 
-- Create a foreign key between persons and passports by using passport_id column. 
-- Think about which passport field should be UNIQUE*/
CREATE TABLE `passports`(
	`passport_id` INT PRIMARY KEY AUTO_INCREMENT,
    `passport_number` VARCHAR(20) UNIQUE
);


CREATE TABLE `people`(
	`person_id` INT PRIMARY KEY AUTO_INCREMENT,
    `first_name` VARCHAR(20) NOT NULL,
    `salary` DECIMAL(10, 2),
    `passport_id` INT UNIQUE,
    
    CONSTRAINT fk_people_passports
    FOREIGN KEY (`passport_id`)
    REFERENCES `passports` (`passport_id`)
);


INSERT INTO `passports`
VALUES
	(101, 'N34FG21B'),
	(102, 'K65LO4R7'),
	(103, 'ZE657QP2');
    
    
INSERT INTO `people` (`first_name`, `salary`, `passport_id`)
VALUES
	('Roberto', 43300, 102),
	('Tom', 56100, 103),
	('Yana', 60200, 101);
    
SELECT * FROM `people`;



/*Problem 2
Insert the data from the example above. 
-- Add primary and foreign keys.*/
CREATE TABLE `manufacturers`(
	`manufacturer_id` INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(20) NOT NULL,
    `established_on` DATE
);

CREATE TABLE `models` (
	`model_id` INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(20) NOT NULL,
    `manufacturer_id` INT,
    
    CONSTRAINT fk_models_manufacturers
    FOREIGN KEY (`manufacturer_id`)
    REFERENCES `manufacturers` (`manufacturer_id`)
);


INSERT INTO `manufacturers` (`name`, `established_on`)
VALUES
	('BMW', '1916-01-03'),
	('Tesla', '2003-01-01'),
	('Lada', '1966-01-05');

INSERT INTO `models`
VALUES
('101', 'X1', 1),
('102', 'i6', 1),
('103', 'Model S', 2),
('104', 'Model X', 2),
('105', 'Model 3', 2),
('106', 'Nova', 3);



/*Problem 3
Insert the data from the example above.
-- Add primary keys and foreign keys. 
-- Have in mind that table student_exams should have a composite primary key.*/
CREATE TABLE `students`(
	`student_id` INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(30) NOT NULL
);

CREATE TABLE `exams`(
	`exam_id` INT PRIMARY KEY AUTO_INCREMENT,
	`name` VARCHAR(30) NOT NULL
);

INSERT INTO `students` (`student_id`, `name`)
VALUES
('Mila'),
('Toni'),
('Ron');

INSERT INTO `exams` (`exam_id`, `name`)
VALUES
(101, 'Spring MVC'),
(102, 'Neo4j'),
(103, 'Oracle 11g');


CREATE TABLE `students_exams`(
	`student_id` INT,
	`exam_id` INT,

	CONSTRAINT pk_students_exams
    PRIMARY KEY (`student_id`, `exam_id`),
    
    CONSTRAINT fk_students_exams_students
    FOREIGN KEY(`student_id`)
    REFERENCES students(`student_id`),
    
    CONSTRAINT fk_students_exams_exams
    FOREIGN KEY (`exam_id`)
    REFERENCES exams(`exam_id`)
);


INSERT INTO `students_exams` 
VALUES
(1, 101),
(1, 102),
(2, 101),
(3, 103),
(2, 102),
(2, 103);

/* как да започне ауто инкремента от определна цифра
ALTER TABLE `students` AUTO_INCREMENT = 200;
*/




/*Problem 4
Insert the data from the example above.
-- Add primary keys and foreign keys. 
-- The foreign key should be between manager_id and teacher_id.*/
CREATE TABLE `teachers`(
	`teacher_id` INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(20) NOT NULL,
    `manager_id` INT
);


INSERT INTO `teachers`
VALUES
	(101, 'John', NULL),
	(102, 'Maya', 106),
	(103, 'Silvia', 106),
	(104, 'Ted', 105),
	(105, 'Mark', 101),
	(106, 'Greta', 101);

ALTER TABLE `teachers`
ADD CONSTRAINT fk_teachers_managers
FOREIGN KEY (`manager_id`)
REFERENCES `teachers`(`teacher_id`);










/*Problem 5
Online Store Database*/
CREATE TABLE `cities`(
	`city_id` INT PRIMARY KEY AUTO_INCREMENT,
	`name` VARCHAR(50)
);
CREATE TABLE `customers`(
	`customer_id` INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(50),
    `birthday` DATE,
    `city_id` INT,
    
    CONSTRAINT fk_customers_cities
    FOREIGN KEY (`city_id`)
    REFERENCES `cities`(`city_id`)
);
CREATE TABLE `orders`(
	`order_id` INT PRIMARY KEY AUTO_INCREMENT,
    `customer_id` INT,
    
    CONSTRAINT fk_orders_customers
    FOREIGN KEY (`customer_id`)
    REFERENCES `customers` (`customer_id`)
);
CREATE TABLE `item_types`(
	`item_type_id` INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(50)
);
CREATE TABLE `items`(
	`item_id` INT PRIMARY KEY AUTO_INCREMENT,
	`name`  VARCHAR(50),
    `item_type_id` INT ,
    
    CONSTRAINT fk_items_item_type
    FOREIGN KEY (`item_type_id`)
    REFERENCES `item_types`(`item_type_id`)
);

CREATE TABLE `order_items`(
	`order_id` INT,
	`item_id` INT,
    
    CONSTRAINT pk_order_items
    PRIMARY KEY (`order_id`,`item_id`),
    
    CONSTRAINT fk_order_items_orders
    FOREIGN KEY (`order_id`)
    REFERENCES `orders`(`order_id`),
    
    CONSTRAINT fk_order_items_items
    FOREIGN KEY (`item_id`)
    REFERENCES `items`(`item_id`)
);


/*Problem 6	
University Database*/
CREATE DATABASE `university`;
USE `university`;

CREATE TABLE `subjects` (
	`subject_id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `subject_name` VARCHAR(50) NOT NULL
);

CREATE TABLE `majors` (
	`major_id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(50) NOT NULL
);

CREATE TABLE `students` (
	`student_id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `student_number` VARCHAR(12) NOT NULL,
    `student_name` VARCHAR(50) NOT NULL,
    `major_id` INT NOT NULL,
	CONSTRAINT `fk_students_majors` 
		FOREIGN KEY (`major_id`)
        REFERENCES `majors` (`major_id`)
);

CREATE TABLE `payments` (
	`payment_id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `payment_date` DATE NOT NULL,
    `payment_amount` DECIMAL(8, 2) NOT NULL,
    `student_id` INT NOT NULL,
	CONSTRAINT `fk_payments_students` 
		FOREIGN KEY (`student_id`)
        REFERENCES `students` (`student_id`)
);

CREATE TABLE `agenda` (
    `student_id` INT NOT NULL,
    `subject_id` INT NOT NULL,
    CONSTRAINT `pk_agenda` PRIMARY KEY (`student_id` , `subject_id`),
    CONSTRAINT `fk_agendar_students` FOREIGN KEY (`student_id`)
        REFERENCES `students` (`student_id`),
    CONSTRAINT `fk_agenda_subjects` FOREIGN KEY (`subject_id`)
        REFERENCES `subjects` (`subject_id`)
);


/*09.	
Peaks in Rila
-- Display all peaks for "Rila" mountain_range. 
-- Include:
-- mountain_range
-- peak_name
-- peak_elevation
-- Peaks should be sorted by peak_elevation descending*/
 
USE `geography`;
 
SELECT 
    m.mountain_range,
    p.peak_name,
    p.elevation AS 'peak_elevation'
FROM
    `mountains` AS m
        JOIN
    `peaks` AS p ON m.id = p.mountain_id
WHERE
    m.mountain_range = 'Rila'
ORDER BY p.elevation DESC;















