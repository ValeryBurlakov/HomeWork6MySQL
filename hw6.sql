DROP DATABASE IF EXISTS homework6;
CREATE DATABASE homework6;
USE homework6;

-- Создайте функцию, которая принимает кол-во сек и формат их в кол-во дней, часов, минут и секунд.
-- Пример: 123456 ->'1 days 10 hours 17 minutes 36 seconds '
DROP PROCEDURE IF EXISTS format_seconds;
DELIMITER //
CREATE FUNCTION format_seconds(seconds INT) RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
    DECLARE days INT;
    DECLARE hours INT;
    DECLARE minutes INT;
    DECLARE result VARCHAR(100);

    SET days = FLOOR(seconds / 86400);
    SET seconds = seconds - (days * 86400); -- 3600*24
    SET hours = FLOOR(seconds / 3600);
    SET seconds = seconds - (hours * 3600); -- 60*60
    SET minutes = FLOOR(seconds / 60);
    SET seconds = seconds - (minutes * 60);

    SET result = CONCAT(days, ' days ', hours, ' hours ', minutes, ' minutes ', seconds, ' seconds');

    RETURN result;
END //
DELIMITER ;

SELECT format_seconds(123456);

-- Выведите только четные числа от 1 до 10 (Через цикл).
-- Пример: 2,4,6,8,10

DROP PROCEDURE IF EXISTS print_even_numbers;
DELIMITER //

CREATE PROCEDURE print_even_numbers()
BEGIN
    DECLARE counter INT DEFAULT 1;
    DECLARE result VARCHAR(255) DEFAULT '';

    WHILE counter <= 10 DO
        IF counter % 2 = 0 THEN
            SET result = CONCAT(result, counter, ' ');
        END IF;
        SET counter = counter + 1;
    END WHILE;

    SELECT result AS even_numbers;
END //

DELIMITER ;
CALL print_even_numbers();


-- Создайте хранимую функцию hello(), которая будет возвращать приветствие, 
-- в зависимости от текущего времени суток. С 6:00 до 12:00 функция должна 
-- возвращать фразу "Доброе утро", с 12:00 до 18:00 функция должна 
-- возвращать фразу "Добрый день", с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи".

DROP PROCEDURE IF EXISTS hello;
DELIMITER //

CREATE PROCEDURE hello()
BEGIN
    DECLARE curr_time TIME;
    
    SET curr_time = CURRENT_TIME();
    
    IF curr_time >= '06:00:00' AND curr_time < '12:00:00' THEN
        SELECT 'Доброе утро';
    ELSEIF curr_time >= '12:00:00' AND curr_time < '18:00:00' THEN
        SELECT 'Добрый день';
    ELSEIF curr_time >= '18:00:00' AND curr_time < '00:00:00' THEN
        SELECT 'Добрый вечер';
    ELSE
        SELECT 'Доброй ночи';
    END IF;
    
END //

DELIMITER ;

CALL hello();