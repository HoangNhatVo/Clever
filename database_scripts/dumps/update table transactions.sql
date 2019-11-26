
ALTER TABLE transactions
MODIFY COLUMN transaction_amount int(11) default 0;

ALTER TABLE transactions
MODIFY COLUMN transaction_id int(11) NOT NULL AUTO_INCREMENT;

