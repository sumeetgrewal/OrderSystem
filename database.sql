--```````````````````````````````````````````````````````````

drop table contain CASCADE CONSTRAINTS;
drop table product CASCADE CONSTRAINTS;
drop table orders CASCADE CONSTRAINTS;
drop table stores CASCADE CONSTRAINTS;
drop table contracts CASCADE CONSTRAINTS;
drop table distributor CASCADE CONSTRAINTS;
drop table warehouse CASCADE CONSTRAINTS; 
drop table restaurant CASCADE CONSTRAINTS;
drop table supplier CASCADE CONSTRAINTS;


CREATE TABLE restaurant (
rid     integer, 
name    char(20), 
phone   char(20), 
unitNo  integer, 
street  char(20), 
city    char(20),
province char(20),
PRIMARY KEY (rid),
UNIQUE (unitNo, street, city, province),
UNIQUE (phone),
ON DELETE CASCADE);

 grant all on restaurant to public;

-- ``````````````````````````````````````````````````````````````````````````

CREATE TABLE supplier (
sid     integer,
name    char(20),
phone   char(20),
PRIMARY KEY (sid),
UNIQUE (phone, name));

grant all on supplier to public;
 
 --`````````````````````````````````````````````````````````````````

CREATE TABLE distributor (
did      integer, 
name     char(20), 
phone    char(20),
PRIMARY KEY (did),
UNIQUE (phone, name));

grant all on distributor to public;

--```````````````````````````````````````````````````````````````````
CREATE TABLE orders (
oid      integer, 
cost     numeric(10,2),
status   char(20), 
orderDate date, 
shipDate date, 
rid     integer NOT NULL, 
sid     integer NOT NULL, 
did     integer,
PRIMARY KEY (oid),
FOREIGN KEY (rid) REFERENCES restaurant(rid),
FOREIGN KEY (sid) REFERENCES supplier(sid),
FOREIGN KEY (did) REFERENCES distributor(did));

grant all on orders to public;

--```````````````````````````````````````````````````````````

CREATE TABLE product (
pid      integer, 
name     char(20), 
category char(20), 
price    numeric(10,2), 
sid      integer,
PRIMARY KEY (pid, sid),
FOREIGN KEY (sid) REFERENCES supplier(sid));

grant all on product to public;

--``````````````````````````````````````````````````````````````

CREATE TABLE warehouse (
wid      integer, 
phone    char(20), 
unitNo   integer, 
street   char(20), 
city     char(20), 
province char(20), 
sid      integer,
PRIMARY KEY (wid),
FOREIGN KEY (sid) REFERENCES supplier(sid),
UNIQUE (unitNo, street, city, province),
UNIQUE (phone));

grant all on warehouse to public;

--```````````````````````````````````````````````````````````````

CREATE TABLE contracts (
sid   integer, 
did   integer,
PRIMARY KEY (sid, did),	
FOREIGN KEY (sid) REFERENCES supplier(sid));

grant all on contracts to public;

--````````````````````````````````````````````````````

CREATE TABLE contain (
oid      integer, 
pid      integer, 
sid      integer, 
quantity integer,
PRIMARY KEY (oid, pid, sid),
FOREIGN KEY (oid) REFERENCES orders(oid),
FOREIGN KEY (pid, sid) REFERENCES product(pid, sid));

grant all on contain to public;

--``````````````````````````````````````````````````````````
CREATE TABLE stores (
wid    integer, 
pid    integer, 
sid    integer, 
onHand integer, 
status char(20),
PRIMARY KEY (wid, pid, sid),
FOREIGN KEY (wid) REFERENCES warehouse(wid), 
FOREIGN KEY (pid, sid) REFERENCES product(pid, sid)) ;

grant all on stores to public;

--````````````````````````````````````````````````````````````````````````````

INSERT INTO restaurant (
rid, name, phone, unitNo, street, city, province) 
VALUES (
	10, 'Miku', '7783191781', 71, '129a', 'Vancouver', 'BC');

INSERT INTO restaurant (
rid, name, phone, unitNo, street, city, province) 
VALUES (
	11, 'Minami', '7784191782', 61, '139a', 'Vancouver', 'BC');

INSERT INTO restaurant (
rid, name, phone, unitNo, street, city, province) 
VALUES (
        12, 'Green Leaf', '7785191783', 51, 'Broadway', 'Vancouver', 'BC');

INSERT INTO restaurant (
rid, name, phone, unitNo, street, city, province) 
VALUES (
	 13, 'Nuba', '7786191784', 41, 'Burrard', 'Vancouver', 'BC');

INSERT INTO restaurant (
rid, name, phone, unitNo, street, city, province) 
VALUES (
	14, 'The Keg', '7787191785', 31, 'Granville', 'Vancouver', 'BC');


--````````````````````````````````````````````````````````````````````````````````


INSERT INTO supplier (
sid, name, phone) 
VALUES (
	3003, 'Yen Foods', '7780001110');

INSERT INTO supplier (
sid, name, phone) 
VALUES (
	3005, 'GREDOS', '7780001111');

INSERT INTO supplier (
sid, name, phone) 
VALUES (
	3007, 'Phresh', '7780001112');

INSERT INTO supplier (
sid, name, phone) 
VALUES (
	3009, 'Gluten Free', '7781110111');

INSERT INTO supplier (
sid, name, phone) 
VALUES (
	3011, 'Nam Foods', '7780002222');

-- `````````````````````````````````````````````````````````````

INSERT INTO distributor (
did, name, phone) 
VALUES (
	998, 'Cool Guys', '772334123');

INSERT INTO distributor (
did, name, phone) 
VALUES (
	999, 'Not Cool Guys', '7785674567');

INSERT INTO distributor (
did, name, phone) 
VALUES (
	1000, 'P=NP', '7782223456');

INSERT INTO distributor (
did, name, phone) 
VALUES (
	1001, 'P=/=NP', '7786544321');

INSERT INTO distributor (
did, name, phone) 
VALUES (
	1002, 'Generic Distributors', '77877871233');

--````````````````````````````````````````````````````````````````````````


INSERT INTO product (
pid, name, category, price, sid) 
VALUES (
	99999, 'Crab', 'Crustaceans', '99.99', 3003);

INSERT INTO product (
pid, name, category, price, sid) 
VALUES (
	99998, 'Snapper', 'Seafood', '59.99', 3005);

INSERT INTO product (
pid, name, category, price, sid) 
VALUES (
	99997, 'Salmon', 'Seafood', '109.99', 3007);

INSERT INTO product (
pid, name, category, price, sid) 
VALUES (
	99996, 'Ketchup', 'Condiments', '159.99', 3009);

INSERT INTO product (
pid, name, category, price, sid) 
VALUES (
	99995, 'Soy Sauce', 'Condiments', '259.99', 3011);

--``````````````````````````````````````````````````````````````````````````
INSERT INTO orders (
oid, cost, status, orderDate, shipDate, rid, sid, did) 
VALUES (
	99, '99.99', 'delivered', '1/01/18', '1/01/18', 10, 3003, 998);

INSERT INTO orders (
oid, cost, status, orderDate, shipDate, rid, sid, did) 
VALUES (
	 100, '59.99', 'delivered', '3/01/18', '3/01/18', 11, 3005, 999);

INSERT INTO orders (
oid, cost, status, orderDate, shipDate, rid, sid, did) 
VALUES (
	101, '109.99', 'delivered', '5/01/18', '5/01/18', 12, 3007, 1000);

INSERT INTO orders (
oid, cost, status, orderDate, shipDate, rid, sid, did) 
VALUES (
	102, '159.99', 'delivered', '10/01/18', '11/01/18', '13', '3009', 1001);

INSERT INTO orders (
oid, cost, status, orderDate, shipDate, rid, sid, did) 
VALUES (
	103, '259.99', 'shipped', '16/02/18', '16/02/18', 14, 3011, 1002);


-- ``````````````````````````````````````````````````````````````````````
INSERT INTO warehouse (
wid, phone, unitNo, street, city, province, sid) 
VALUES (
	000, '7784444445', 204, 'Main', 'Vancouver', 'BC', 3003);

INSERT INTO warehouse (
wid, phone, unitNo, street, city, province, sid) 
VALUES (
	010, '7784444446', 304, 'Cambie', 'Vancouver', 'BC', 3005);

INSERT INTO warehouse (
wid, phone, unitNo, street, city, province, sid) 
VALUES (
	020, '7784444447', 404, 'Victoria', 'Vancouver', 'BC', 3007);

INSERT INTO warehouse (
wid, phone, unitNo, street, city, province, sid) 
VALUES (
	030, '7784444448', 504, 'Scott Road', 'Surrey', 'BC', 3009) ;

INSERT INTO warehouse (
wid, phone, unitNo, street, city, province, sid) 
VALUES (
	040, '7784444449', 604, 'Westbrooke', 'Vancouver', 'BC', 3011) ;

--`````````````````````````````````````````````````````````````````````````
INSERT INTO contracts (
sid, did) 
VALUES (
	3003, 998); 

INSERT INTO contracts (
sid, did) 
VALUES (
	3005, 999);
INSERT INTO contracts (
sid, did) 
VALUES (
	3007, 1000);
INSERT INTO contracts (
sid, did) 
VALUES (
	3009, 1001);
INSERT INTO contracts (
sid, did) 
VALUES (
	3011, 1002);

--`````````````````````````````````````````````````````````````````````````


INSERT INTO contain (
oid, pid, sid, quantity) 
VALUES (
	99, 99999, 3003, 100); 


INSERT INTO contain (
oid, pid, sid, quantity) 
VALUES (
	100, 99998, 3005, 150); 


INSERT INTO contain (
oid, pid, sid, quantity) 
VALUES (
	101, 99997, 3007, 200); 

INSERT INTO contain (
oid, pid, sid, quantity) 
VALUES (
	102, 99996, 3009, 105); 


INSERT INTO contain (
oid, pid, sid, quantity) 
VALUES (
	103, 99995, 3011, 105); 

--``````````````````````````````````````````````````````````````````````
INSERT INTO stores (
wid, pid, sid, onHand, status) 
VALUES (
	000, 99999, 3003, 110, 'Available'); 

INSERT INTO stores (
wid, pid, sid, onHand, status) 
VALUES (
	010, 99998, 3005, 150, 'Available'); 

INSERT INTO stores (
wid, pid, sid, onHand, status) 
VALUES (
	020, 99997, 3007, 200, 'Available'); 

INSERT INTO stores (
wid, pid, sid, onHand, status) 
VALUES (
	030, 99996, 3009, 110, 'Available'); 

INSERT INTO stores (
wid, pid, sid, onHand, status) 
VALUES (
	040, 99995, 3011, 0, 'Unavailable');  
