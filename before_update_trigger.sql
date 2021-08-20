CREATE TABLE sales_info (  
    id INT AUTO_INCREMENT,  
    product VARCHAR(100) NOT NULL,  
    quantity INT NOT NULL DEFAULT 0,  
    fiscalYear SMALLINT NOT NULL,  
    CHECK(fiscalYear BETWEEN 2000 and 2050),  
    CHECK (quantity >=0),  
    UNIQUE(product, fiscalYear),  
    PRIMARY KEY(id)  
);  

INSERT INTO sales_info(product, quantity, fiscalYear)  
VALUES  
    ('2003 Maruti Suzuki',110, 2020),  
    ('2015 Avenger', 120,2020),  
    ('2018 Honda Shine', 150,2020),  
    ('2014 Apache', 150,2020);  
    
select * from sales_info;


DELIMITER $$    
CREATE TRIGGER before_update_salesInfo  
BEFORE UPDATE  
ON sales_info FOR EACH ROW  
BEGIN  
    DECLARE error_msg VARCHAR(255);  
    SET error_msg = ('The new quantity cannot be greater than 2 times the current quantity');  
    IF new.quantity > old.quantity * 2 THEN  
    SIGNAL SQLSTATE '45000'   
    SET MESSAGE_TEXT = error_msg;  
    END IF;  
END $$  
DELIMITER ;

# To signal a generic SQLSTATE value, use '45000', which means “unhandled user-defined exception.”

# we use the SIGNAL statement to return an error or warning condition to the caller from a stored program

UPDATE sales_info SET quantity = 220 WHERE id = 3; 
    

UPDATE sales_info SET quantity = 500 WHERE id = 3; 
    
select * from sales_info;