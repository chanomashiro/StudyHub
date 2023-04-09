CREATE TABLESPACE
    tbs01 DATAFILE '/home/oracle/tablespace/tbs_01.dbf' SIZE 100 M AUTOEXTEND ON,
    '/home/oracle/tablespace/tbs_02.dbf' SIZE 100 M AUTOEXTEND ON;

CREATE TABLE
    tbl01(id NUMBER, col1 VARCHAR2(100)) TABLESPACE tbs01;

SELECT default_tablespace FROM DBA_USERS WHERE username = 'TEST';

DROP TABLESPACE tbs01;

DROP TABLESPACE tbs01 INCLUDING CONTENTS;

CREATE TABLESPACE
    order_tbs DATAFILE '/home/oracle/tablespace/order_tbs01.dbf' SIZE 100 M AUTOEXTEND ON;

CREATE USER
    order_app IDENTIFIED BY password QUOTA UNLIMITED ON order_tbs;

GRANT CREATE SESSION TO order_app;

CREATE TABLE
    order_app.tbl_customer (
        customer_no NUMBER(4) NOT NULL,
        customer_name VARCHAR2(40 CHAR) NOT NULL,
        customer_address VARCHAR2(200 CHAR) NOT NULL,
        CONSTRAINTS pk_customer_no PRIMARY KEY (customer_no)
    ) TABLESPACE order_tbs;

CREATE TABLE
    order_app.tbl_product(
        product_no CHAR(6) NOT NULL,
        product_name VARCHAR2(40 CHAR) NOT NULL,
        price NUMBER(10) NOT NULL CHECK (price > 0),
        CONSTRAINT pk_product_no PRIMARY KEY (product_no),
        CONSTRAINT uq_product_name UNIQUE (product_name)
    ) TABLESPACE order_tbs;

CREATE TABLE
    order_app.tbl_order(
        order_no NUMBER(4) NOT NULL,
        order_date DATE NOT NULL,
        pay_type VARCHAR2(10 CHAR) NOT NULL CHECK (pay_type IN ('現金払い', '銀行振込')),
        customer_no NUMBER(4) NOT NULL,
        CONSTRAINT pk_order_no PRIMARY KEY (order_no),
        CONSTRAINT fk_order_customer_no FOREIGN KEY (customer_no) REFERENCES order_app.tbl_customer (customer_no)
    ) TABLESPACE order_tbs;

CREATE TABLE
    order_app.tbl_order_item (
        order_no NUMBER(4) NOT NULL,
        order_item_no NUMBER(5) NOT NULL,
        product_no CHAR(6) NOT NULL,
        order_num NUMBER(10) NOT NULL CHECK (order_num > 0),
        item_account NUMBER(10) NOT NULL CHECK (item_account > 0),
        CONSTRAINT pk_order_item_no PRIMARY KEY (order_no, order_item_no),
        CONSTRAINT fk_order_item_order_no FOREIGN KEY (order_no) REFERENCES order_app.tbl_order (order_no),
        CONSTRAINT fk_order_item_product_no FOREIGN KEY (product_no) REFERENCES order_app.tbl_product (product_no)
    ) TABLESPACE order_tbs;

CREATE INDEX
    order_app.idx_order_date ON order_app.tbl_order (order_date) TABLESPACE order_tbs;