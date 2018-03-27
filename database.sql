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
UNIQUE (phone));

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
rid     integer, 
sid     integer, 
did     integer,
PRIMARY KEY (oid),
FOREIGN KEY (rid) REFERENCES restaurant(rid)
	ON DELETE CASCADE,
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
FOREIGN KEY (oid) REFERENCES orders(oid) ON DELETE CASCADE,
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
        12, 'Green Leaf', '7785191783', 51, 'W Broadway', 'Vancouver', 'BC');

INSERT INTO restaurant (
rid, name, phone, unitNo, street, city, province) 
VALUES (
	 13, 'Nuba', '7786191784', 41, 'Burrard St', 'Vancouver', 'BC');

INSERT INTO restaurant (
rid, name, phone, unitNo, street, city, province) 
VALUES (
	14, 'The Keg', '7787191785', 31, 'Granville St', 'Vancouver', 'BC');

INSERT INTO restaurant (
rid, name, phone, unitNo, street, city, province)
VALUES (
	15, 'Maenam', '6047305579', 1938, 'W 4th', 'Vancouver', 'BC');

INSERT INTO restaurant (
rid, name, phone, unitNo, street, city, province)
VALUES (
	16, 'Earls', '6047365663', 1601, 'W Broadway', 'Vancouver', 'BC');
	
INSERT INTO restaurant (
rid, name, phone, unitNo, street, city, province)
VALUES (
	17, 'Cactus Club Cafe', '6046207410', 1085, 'Canada Pl', 'Vancouver', 'BC');
	
INSERT INTO restaurant (
rid, name, phone, unitNo, street, city, province)
VALUES (
	18, 'Guu', '6046858678', 1698, 'Robson St', 'Vancouver', 'BC');
	
INSERT INTO restaurant (
rid, name, phone, unitNo, street, city, province)
VALUES (
	19, 'Guu',  '6046858817', 838, 'Thurlow St', 'Vancouver', 'BC');
	
INSERT INTO restaurant (
rid, name, phone, unitNo, street, city, province)
VALUES (
	20, 'Hapa Izakaya', '6046894272', 1479, 'Robson St', 'Vancouver', 'BC');

INSERT INTO restaurant (
rid, name, phone, unitNo, street, city, province)
VALUES (
	21, 'Miku', '6045683900', 200, 'Granville St', 'Vancouver', 'BC');
	
INSERT INTO restaurant (
rid, name, phone, unitNo, street, city, province)
VALUES (
	22, 'Tableau Bar Bistro', '6046398692', 1181, 'Melville St', 'Vancouver', 'BC');
	
INSERT INTO restaurant (
rid, name, phone, unitNo, street, city, province)
VALUES (
	23, 'Bambudda', '6044280301', 99, 'Powell St', 'Vancouver', 'BC');
	
INSERT INTO restaurant (
rid, name, phone, unitNo, street, city, province)
VALUES (
	24, 'Belgard Kitchen', '6045661989', 55, 'Dunlevy Ave', 'Vancouver', 'BC');
	
INSERT INTO restaurant (
rid, name, phone, unitNo, street, city, province)
VALUES (
	25, 'Cuchillo', '6045597585', 261, 'Powell St', 'Vancouver', 'BC');
	
INSERT INTO restaurant (
rid, name, phone, unitNo, street, city, province)
VALUES (
	26, 'Nicli Antica', '6046696985', 62, 'E Cordova St', 'Vancouver', 'BC');

INSERT INTO restaurant (
rid, name, phone, unitNo, street, city, province)
VALUES (
	27, 'Trattoria', '6044248779', 4501, 'Kingsway', 'Burnaby', 'BC');
	
INSERT INTO restaurant (
rid, name, phone, unitNo, street, city, province)
VALUES (
	28, 'Tenen', '6043366665', 7569, 'Royal Oak Avenue', 'Burnaby', 'BC');
	
	
INSERT INTO restaurant (
rid, name, phone, unitNo, street, city, province)
VALUES (
	29, 'Chad Thai', '6046771489', 4010, 'E Hastings St', 'Burnaby', 'BC');
	
INSERT INTO restaurant (
rid, name, phone, unitNo, street, city, province)
VALUES (
	30, 'Tasty Indian Bistro', '6045079393', 8295, 'Scott Road', 'Surrey', 'BC');
	
INSERT INTO restaurant (
rid, name, phone, unitNo, street, city, province)
VALUES (
	31, 'The Greek Corner', '6045033780', 7218, 'King George Highway', 'Surrey', 'BC');

	
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

INSERT INTO supplier (
sid, name, phone) 
VALUES (
	3013, 'Bacon Bros', '7780002223');

INSERT INTO supplier (
sid, name, phone) 
VALUES (
	3015, 'Felton Foods', '7780002224');

INSERT INTO supplier (
sid, name, phone) 
VALUES (
	3017, 'Yo Gotti', '7780002225');

INSERT INTO supplier (
sid, name, phone) 
VALUES (
	3019, 'Kumar Enterprises', '7789941393');

INSERT INTO supplier (
sid, name, phone) 
VALUES (
	3021, 'Grewal Corp.', '6044451630');

-- ````````````````````````````````````````````````````````````

INSERT INTO distributor (
did, name, phone) 
VALUES (
	998, 'Cool Guys', '7782334123');

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
	1001, 'P=/=NP', '6049302121');

INSERT INTO distributor (
did, name, phone) 
VALUES (
	1002, 'Generic Distributors', '7782461233');

	
INSERT INTO distributor (
did, name, phone) 
VALUES (
	1003, 'Dis Tributors', '7787870024');

	
INSERT INTO distributor (
did, name, phone) 
VALUES (
	1004, 'Cheesecake Delivers', '7782465235');

	
INSERT INTO distributor (
did, name, phone) 
VALUES (
	1005, 'Penguins Delivery', '7787871236');

/*	
INSERT INTO distributor (
did, name, phone) 
VALUES (
	1006, 'Silver Knights Distribution', '7787783030');

	
INSERT INTO distributor (
did, name, phone) 
VALUES (
	1007, 'Kings Distribution', '7787371238');

	
INSERT INTO distributor (
did, name, phone) 
VALUES (
	1008, 'Canucks (Dont) Deliver', '7787700009');

	
INSERT INTO distributor (
did, name, phone) 
VALUES (
	1009, 'Supersonic Delivery', '7787787140');

	
INSERT INTO distributor (
did, name, phone) 
VALUES (
	1011, 'Mach 9 Distribution', '7787112241');

	
INSERT INTO distributor (
did, name, phone) 
VALUES (
	1012, 'Taka Logistics', '7787781242');


INSERT INTO distributor (
did, name, phone) 
VALUES (
	1013, 'Just Justin', '7787781203');  */ 

--````````````````````````````````````````````````````````````````````````

INSERT INTO product (
pid, name, category, price, sid) 
VALUES (
	99999, 'Crab', 'Seafood', '99.99', 3005);

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
	99996, 'Ketchup', 'Condiments', '42.99', 3009);

INSERT INTO product (
pid, name, category, price, sid) 
VALUES (
	99995, 'Soy Sauce', 'Condiments', '60.80', 3011);  

INSERT INTO product (
pid, name, category, price, sid) 
VALUES (
	99994, 'Mustard', 'Condiments', '40.99', 3009);
	
INSERT INTO product (
pid, name, category, price, sid) 
VALUES (
	99993, 'Romaine Lettuce', 'Produce', '39.99', 3003);
	
INSERT INTO product (
pid, name, category, price, sid) 
VALUES (
	99992, 'Tomatoes', 'Produce', '50.25', 3003);
		 
INSERT INTO product (
pid, name, category, price, sid) 
VALUES (
	99991, 'Kale', 'Produce', '46.00', 3003);
	
INSERT INTO product (
pid, name, category, price, sid) 
VALUES (
	99990, 'Dragonfruit', 'Produce', '64.50', 3019);
	
INSERT INTO product (
pid, name, category, price, sid) 
VALUES (
	99989, 'Brie', 'Dairy Products', '75.75', 3017);

INSERT INTO product (
pid, name, category, price, sid) 
VALUES (
	99988, 'Bell Peppers', 'Produce', '35.00', 3003);
	
INSERT INTO product (
pid, name, category, price, sid) 
VALUES (
	99987, 'Oranges', 'Produce', '37.89', 3003);

INSERT INTO product (
pid, name, category, price, sid) 
VALUES (
	99986, 'Oysters', 'Seafood', '89.99', 3005);

INSERT INTO product (
pid, name, category, price, sid) 
VALUES (
	99985, 'Tuna', 'Seafood', '85.75', 3005);
	
INSERT INTO product (
pid, name, category, price, sid) 
VALUES (
	99984, 'Chicken', 'Poultry', '82.45', 3005);
	
INSERT INTO product (
pid, name, category, price, sid) 
VALUES (
	99983, 'Salmon', 'Seafood', '104.99', 3005);

INSERT INTO product (
pid, name, category, price, sid) 
VALUES (
	99982, 'Tuna', 'Seafood', '92.45', 3007);

INSERT INTO product (
pid, name, category, price, sid) 
VALUES (
	99981, 'Veal', 'Seafood', '125.00', 3007);

INSERT INTO product (
pid, name, category, price, sid) 
VALUES (
	99980, 'Mussels', 'Seafood', '101.99', 3007);
	
INSERT INTO product (
pid, name, category, price, sid) 
VALUES (
	99979, 'Hamburger Buns', 'Baked Goods', '26.99', 3009);

INSERT INTO product (
pid, name, category, price, sid) 
VALUES (
	99978, 'Hot Dog Buns', 'Baked Goods', '23.99', 3009);

INSERT INTO product (
pid, name, category, price, sid) 
VALUES (
	99977, '100% WW Bread', 'Baked Goods', '22.99', 3009);
	
INSERT INTO product (
pid, name, category, price, sid) 
VALUES (
	99976, '60% WW Bread', 'Baked Goods', '22.99', 3009);

INSERT INTO product (
pid, name, category, price, sid) 
VALUES (
	99975, 'Everything Bagels', 'Baked Goods', '18.00', 3009);
	
INSERT INTO product (
pid, name, category, price, sid) 
VALUES (
	99974, 'Cran Raisin Bagels', 'Baked Goods', '18.00', 3009);

INSERT INTO product (
pid, name, category, price, sid) 
VALUES (
	99973, 'Blueberry Muffins', 'Baked Goods', '26.50', 3009);

INSERT INTO product (
pid, name, category, price, sid) 
VALUES (
	99972, 'Choc. Chip Muffins', 'Baked Goods', '27.50', 3009);

INSERT INTO product (
pid, name, category, price, sid) 
VALUES (
	99971, 'White Vinegar', 'Oil and Vinegar', '36.00', 3011);

INSERT INTO product (
pid, name, category, price, sid) 
VALUES (
	99970, 'Rice Vinegar', 'Oil and Vinegar', '44.20', 3011);

INSERT INTO product (
pid, name, category, price, sid) 
VALUES (
	99969, 'Olive Oil', 'Oil and Vinegar', '79.99', 3011);
	
INSERT INTO product (
pid, name, category, price, sid) 
VALUES (
	99968, 'Canola Oil', 'Oil and Vinegar', '44.20', 3011);
	
INSERT INTO product (
pid, name, category, price, sid) 
VALUES (
	99967, 'Olive Oil', 'Oil and Vinegar', '89.99', 3013);
	
INSERT INTO product (
pid, name, category, price, sid) 
VALUES (
	99966, 'White Sugar', 'Baking', '50.00', 3013);
	
INSERT INTO product (
pid, name, category, price, sid) 
VALUES (
	99965, 'Baking Soda', 'Baking', '15.23', 3013);
	
INSERT INTO product (
pid, name, category, price, sid) 
VALUES (
	99964, 'White Sugar', 'Baking', '50.00', 3013);

INSERT INTO product (
pid, name, category, price, sid) 
VALUES (
	99963, 'Vanilla Extract', 'Baking', '50.00', 3013);

INSERT INTO product (
pid, name, category, price, sid) 
VALUES (
	99962, 'Whole Wheat Flour', 'Baking', '67.80', 3015);
	
INSERT INTO product (
pid, name, category, price, sid) 
VALUES (
	99961, 'Bran Flour', 'Baking', '65.75', 3015);

INSERT INTO product (
pid, name, category, price, sid) 
VALUES (
	99960, 'Egg Yolk', 'Baking', '66.00', 3015);

INSERT INTO product (
pid, name, category, price, sid) 
VALUES (
	99959, 'Muffin Pan', 'Baking Supplies', '80.00', 3015);

INSERT INTO product (
pid, name, category, price, sid) 
VALUES (
	99958, 'Cooling Rack', 'Baking Supplies', '200.00', 3015);
	
-- Suppliers 3017, 3018, 3019, 3021

--``````````````````````````````````````````````````````````````````````````
INSERT INTO orders (
oid, cost, status, orderDate, shipDate, rid, sid, did) 
VALUES (
	99, '0.00', 'delivered', '1/01/18', '1/01/18', 10, 3003, 998);

INSERT INTO orders (
oid, cost, status, orderDate, shipDate, rid, sid, did) 
VALUES (
	 100, '0.00', 'delivered', '3/01/18', '3/01/18', 11, 3005, 999);

INSERT INTO orders (
oid, cost, status, orderDate, shipDate, rid, sid, did) 
VALUES (
	101, '0.00', 'delivered', '5/01/18', '5/01/18', 12, 3007, 1000);

INSERT INTO orders (
oid, cost, status, orderDate, shipDate, rid, sid, did) 
VALUES (
	102, '0.00', 'delivered', '10/01/18', '11/01/18', 13, 3009, 1001);

INSERT INTO orders (
oid, cost, status, orderDate, shipDate, rid, sid, did) 
VALUES (
	103, '0.00', 'shipped', '16/02/18', '16/02/18', 14, 3011, 1002);


-- ``````````````````````````````````````````````````````````````````````
INSERT INTO warehouse (
wid, phone, unitNo, street, city, province, sid) 
VALUES (
	000, '7784444445', 204, 'Main St', 'Vancouver', 'BC', 3003);

INSERT INTO warehouse (
wid, phone, unitNo, street, city, province, sid) 
VALUES (
	010, '7784444446', 304, 'Cambie St', 'Vancouver', 'BC', 3005);

INSERT INTO warehouse (
wid, phone, unitNo, street, city, province, sid) 
VALUES (
	020, '7784444447', 404, 'Victoria St', 'Vancouver', 'BC', 3007);

INSERT INTO warehouse (
wid, phone, unitNo, street, city, province, sid) 
VALUES (
	030, '7784444448', 504, 'Scott Road', 'Surrey', 'BC', 3009) ;

INSERT INTO warehouse (
wid, phone, unitNo, street, city, province, sid) 
VALUES (
	040, '7784444449', 604, 'Wesbrooke Avenue', 'Vancouver', 'BC', 3011) ;

INSERT INTO warehouse (
wid, phone, unitNo, street, city, province, sid) 
VALUES (
	050, '7784444450', 704, 'Commercial', 'Vancouver', 'BC', 3013) ;

INSERT INTO warehouse (
wid, phone, unitNo, street, city, province, sid) 
VALUES (
	060, '7784444451', 804, 'Davie St', 'Vancouver', 'BC', 3015) ;

INSERT INTO warehouse (
wid, phone, unitNo, street, city, province, sid) 
VALUES (
	070, '7784444452', 904, 'Burrard St', 'Vancouver', 'BC', 3017) ;

INSERT INTO warehouse (
wid, phone, unitNo, street, city, province, sid) 
VALUES (
	080, '7784444453', 104, 'Clown St', 'Burnaby', 'BC', 3019) ;

INSERT INTO warehouse (
wid, phone, unitNo, street, city, province, sid) 
VALUES (
	090, '7784444454', 114, 'Cheese St', 'Vancouver', 'BC', 3021) ;

INSERT INTO warehouse (
wid, phone, unitNo, street, city, province, sid) 
VALUES (
	100, '7784444455', 214, 'Canal St', 'Surrey', 'BC', 3009) ;

INSERT INTO warehouse (
wid, phone, unitNo, street, city, province, sid) 
VALUES (
	110, '7784444456', 314, 'Colebrook Avenue', 'Surrey', 'BC', 3011) ;
	
INSERT INTO warehouse (
wid, phone, unitNo, street, city, province, sid) 
VALUES (
	120, '7784444457', 414, 'Cardinal Avenue', 'Abbotsford', 'BC', 3013) ;

INSERT INTO warehouse (
wid, phone, unitNo, street, city, province, sid) 
VALUES (
	130, '7784444458', 514, 'Azure', 'Abbotsford', 'BC', 3015) ;

INSERT INTO warehouse (
wid, phone, unitNo, street, city, province, sid) 
VALUES (
	140, '7784444459', 614, 'Crimson St', 'Abbotsford', 'BC', 3015) ;

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

INSERT INTO contracts (
sid, did) 
VALUES (
	3013, 1003);

INSERT INTO contracts (
sid, did) 
VALUES (
	3015, 1004);
	
INSERT INTO contracts (
sid, did) 
VALUES (
	3015, 1005);
	
INSERT INTO contracts (
sid, did) 
VALUES (
	3015, 1006);

INSERT INTO contracts (
sid, did) 
VALUES (
	3017, 1002);
	
INSERT INTO contracts (
sid, did) 
VALUES (
	3017, 1005);

INSERT INTO contracts (
sid, did) 
VALUES (
	3019, 1000);
	
INSERT INTO contracts (
sid, did) 
VALUES (
	3019, 1001);
	
INSERT INTO contracts (
sid, did) 
VALUES (
	3011, 1006);

INSERT INTO contracts (
sid, did) 
VALUES (
	3019, 1005);

INSERT INTO contracts (
sid, did) 
VALUES (
	3021, 1004);


--`````````````````````````````````````````````````````````````````````````


INSERT INTO contain (
oid, pid, sid, quantity) 
VALUES (
	99, 99999, 3005, 100); 


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
	000, 99999, 3005, 110, 'Available'); 

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

INSERT INTO stores (
wid, pid, sid, onHand, status) 
VALUES (
	050, 99994, 3009, 0, 'Unavailable');

INSERT INTO stores (
wid, pid, sid, onHand, status) 
VALUES (
	060, 99993, 3003, 0, 'Unavailable');

INSERT INTO stores (
wid, pid, sid, onHand, status) 
VALUES (
	070, 99992, 3003, 0, 'Unavailable');

INSERT INTO stores (
wid, pid, sid, onHand, status) 
VALUES (
	080, 99991, 3003, 0, 'Unavailable');

INSERT INTO stores (
wid, pid, sid, onHand, status) 
VALUES (
	090, 99990, 3019, 0, 'Unavailable');

INSERT INTO stores (
wid, pid, sid, onHand, status) 
VALUES (
	100, 99989, 3017, 0, 'Unavailable');            