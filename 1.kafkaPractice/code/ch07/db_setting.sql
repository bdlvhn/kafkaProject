CREATE TABLE ec_uriage (
	seq bigint PRIMARY KEY,
	sales_time timestamp,
	sales_id varchar(80),
	item_id varchar(80),
	amount int,
	unit_price int);

CREATE USER connectuser with password 'connectpass';
GRANT ALL ON ec_uriage TO connectuser;

INSERT INTO ec_uriage(seq, sales_time, sales_id, item_id, amount, unit_price)
	VALUES (1, '2018-10-05 11:11:11', 'ECSALES00001', 'ITEM001', 2, 300);
INSERT INTO ec_uriage(seq, sales_time, sales_id, item_id, amount, unit_price)
	VALUES (2, '2018-10-01 11:11:11', 'ECSALES00001', 'ITEM002', 1, 5800);
INSERT INTO ec_uriage(seq, sales_time, sales_id, item_id, amount, unit_price)
	VALUES (3, '2018-10-02 12:12:12', 'ECSALES00002', 'ITEM001', 4, 298);
INSERT INTO ec_uriage(seq, sales_time, sales_id, item_id, amount, unit_price)
	VALUES (4, '2018-10-02 12:12:12', 'ECSALES00002', 'ITEM003', 1, 2500);
INSERT INTO ec_uriage(seq, sales_time, sales_id, item_id, amount, unit_price)
	VALUES (5, '2018-10-02 12:12:12', 'ECSALES00002', 'ITEM004', 1, 198);
INSERT INTO ec_uriage(seq, sales_time, sales_id, item_id, amount, unit_price)
	VALUES (6, '2018-10-02 12:12:12', 'ECSALES00002', 'ITEM005', 1, 273);

CREATE TABLE pos_uriage (
	seq bigint PRIMARY KEY,
	sales_time timestamp,
	sales_id varchar(80),
	shop_id varchar(80),
	item_id varchar(80),
	amount int,
	unit_price int);

CREATE USER 'connectuser' IDENTIFIED BY 'connectpass';
GRANT ALL PRIVILEGES ON pos_uriage TO connectuser;

INSERT INTO pos_uriage(seq, sales_time, sales_id, shop_id, item_id, amount, unit_price)
	VALUES (1, '2018-10-11 21:21:21', 'POSSALES00001', 'SHOP001', 'ITEM001', 2, 300);
INSERT INTO pos_uriage(seq, sales_time, sales_id, shop_id, item_id, amount, unit_price)
	VALUES (2, '2018-10-11 21:21:21', 'POSSALES00001', 'SHOP001', 'ITEM004', 5, 198);
INSERT INTO pos_uriage(seq, sales_time, sales_id, shop_id, item_id, amount, unit_price)
	VALUES (3, '2018-10-11 21:21:21', 'POSSALES00001', 'SHOP001', 'ITEM005', 4, 273);
INSERT INTO pos_uriage(seq, sales_time, sales_id, shop_id, item_id, amount, unit_price)
	VALUES (4, '2018-10-12 22:22:22', 'POSSALES00002', 'SHOP002', 'ITEM001', 1, 300);
INSERT INTO pos_uriage(seq, sales_time, sales_id, shop_id, item_id, amount, unit_price)
	VALUES (5, '2018-10-12 22:22:22', 'POSSALES00002', 'SHOP002', 'ITEM006', 1, 512);
INSERT INTO pos_uriage(seq, sales_time, sales_id, shop_id, item_id, amount, unit_price)
	VALUES (6, '2018-10-12 23:23:23', 'POSSALES00003', 'SHOP003', 'ITEM006', 2, 512);

INSERT INTO ec_uriage(seq, sales_time, sales_id, item_id, amount, unit_price)
	VALUES (7, '2018-10-02 13:13:13', 'ECSALES00003', 'ITEM001', 1, 300);
INSERT INTO ec_uriage(seq, sales_time, sales_id, item_id, amount, unit_price)
	VALUES (8, '2018-10-02 14:14:14', 'ECSALES00004', 'ITEM001', 1, 300);
INSERT INTO ec_uriage(seq, sales_time, sales_id, item_id, amount, unit_price)
	VALUES (9, '2018-10-02 14:14:14', 'ECSALES00004', 'ITEM002', 1, 5800);

INSERT INTO pos_uriage(seq, sales_time, sales_id, shop_id, item_id, amount, unit_price)
	VALUES (7, '2018-10-13 04:04:04', 'POSSALES00004', 'SHOP001', 'ITEM001', 2, 300);
INSERT INTO pos_uriage(seq, sales_time, sales_id, shop_id, item_id, amount, unit_price)
	VALUES (8, '2018-10-13 05:05:05', 'POSSALES00004', 'SHOP001', 'ITEM006', 1, 300);
INSERT INTO pos_uriage(seq, sales_time, sales_id, shop_id, item_id, amount, unit_price)
	VALUES (9, '2018-10-13 05:05:05', 'POSSALES00004', 'SHOP001', 'ITEM004', 1, 198);

INSERT INTO pos_uriage(seq, sales_time, sales_id, shop_id, item_id, amount, unit_price, age)
	VALUES (10, '2018-10-21 11:11:11', 'POSSALES00008', 'SHOP001', 'ITEM008', 1, 422, 25);
INSERT INTO pos_uriage(seq, sales_time, sales_id, shop_id, item_id, amount, unit_price, age)
	VALUES (11, '2018-10-21 11:11:11', 'POSSALES00008', 'SHOP001', 'ITEM009', 1, 120, 25);
INSERT INTO pos_uriage(seq, sales_time, sales_id, shop_id, item_id, amount, unit_price, age)
	VALUES (12, '2018-10-21 11:11:11', 'POSSALES00008', 'SHOP001', 'ITEM010', 1, 140, 25);