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
UNIQUE (oid, sid),
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
FOREIGN KEY (sid) REFERENCES supplier(sid),
FOREIGN KEY (did) REFERENCES distributor(did));

grant all on contracts to public;

--````````````````````````````````````````````````````

CREATE TABLE contain (
oid      integer, 
pid      integer, 
osid     integer,
sid      integer,   
quantity integer,
PRIMARY KEY (oid, pid, sid),
FOREIGN KEY (oid, osid) REFERENCES orders(oid, sid) ON DELETE CASCADE,
FOREIGN KEY (pid, sid) REFERENCES product(pid, sid),
CONSTRAINT check_sid_integ CHECK (osid=sid),
CONSTRAINT check_qty_integ CHECK (quantity<=1000));


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
	14, 'Nicli Antica', '6046696985', 62, 'E Cordova St', 'Vancouver', 'BC');

INSERT INTO restaurant (
rid, name, phone, unitNo, street, city, province)
VALUES (
	15, 'Maenam', '6047305579', 1938, 'W 4th', 'Vancouver', 'BC');

INSERT INTO restaurant (
rid, name, phone, unitNo, street, city, province)
VALUES (
	16, 'Trattoria', '6044248779', 4501, 'Kingsway', 'Burnaby', 'BC');
	
INSERT INTO restaurant (
rid, name, phone, unitNo, street, city, province)
VALUES (
	17, 'Tenen', '6043366665', 7569, 'Royal Oak Avenue', 'Burnaby', 'BC');
	
INSERT INTO restaurant (
rid, name, phone, unitNo, street, city, province)
VALUES (
	18, 'Guu', '6046858678', 1698, 'Robson St', 'Vancouver', 'BC');
	
INSERT INTO restaurant (
rid, name, phone, unitNo, street, city, province)
VALUES (
	19, 'Tasty Indian Bistro', '6045079393', 8295, 'Scott Road', 'Surrey', 'BC');
	
INSERT INTO restaurant (
rid, name, phone, unitNo, street, city, province)
VALUES (
	20, 'Hapa Izakaya', '6046894272', 1479, 'Robson St', 'Vancouver', 'BC');

INSERT INTO restaurant (
rid, name, phone, unitNo, street, city, province)
VALUES (
	21, 'Miku', '6045683900', 200, 'Granville St', 'Vancouver', 'BC');

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
	3013, 'Baking Bros', '7780002223');

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


INSERT INTO distributor (
did, name, phone) 
VALUES (
	1006, 'Silver Knights Dist', '7787783030');

/*	
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
	99966, 'Cane Sugar', 'Baking', '42.00', 3013);
	
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
	
INSERT INTO product (
pid, name, category, price, sid) 
VALUES (
	99957, 'Oregano', 'Spices', '45.98', 3017);
	
INSERT INTO product (
pid, name, category, price, sid) 
VALUES (
	99956, 'Paprika', 'Spices', '42.98', 3017);
	
INSERT INTO product (
pid, name, category, price, sid) 
VALUES (
	99955, 'Organic Turmeric', 'Spices', '40.98', 3017);
	
INSERT INTO product (
pid, name, category, price, sid) 
VALUES (
	99954, 'Garam Masala', 'Spices', '55.90', 3017);
	
INSERT INTO product (
pid, name, category, price, sid) 
VALUES (
	99953, 'Vanilla Extract', 'Baking Supplies', '46.25', 3017);

INSERT INTO product (
pid, name, category, price, sid) 
VALUES (
	99952, 'Almond Extract', 'Baking Supplies', '60.25', 3017);

INSERT INTO product (
pid, name, category, price, sid) 
VALUES (
	99951, 'Garbage Bags', 'Cleaning Supplies', '92.35', 3019);

INSERT INTO product (
pid, name, category, price, sid) 
VALUES (
	99950, 'Dish Detergent', 'Cleaning Supplies', '104.50', 3019);
	
INSERT INTO product (
pid, name, category, price, sid) 
VALUES (
	99949, 'Mop Heads', 'Cleaning Supplies', '35.99', 3019);
	
INSERT INTO product (
pid, name, category, price, sid) 
VALUES (
	99948, 'Sanitizer', 'Cleaning Supplies', '120.50', 3019);
	
INSERT INTO product (
pid, name, category, price, sid) 
VALUES (
	99947, 'Bar Cloth', 'Cleaning Supplies', '21.00', 3019);
	
INSERT INTO product (
pid, name, category, price, sid) 
VALUES (
	99946, '12 OZ Mug', 'SmallWares', '40.00', 3021);
	
INSERT INTO product (
pid, name, category, price, sid) 
VALUES (
	99945, '16 OZ Mug', 'SmallWares', '40.00', 3021);
	
INSERT INTO product (
pid, name, category, price, sid) 
VALUES (
	99944, '16 OZ Glass', 'SmallWares', '45.00', 3021);
	
INSERT INTO product (
pid, name, category, price, sid) 
VALUES (
	99943, '5 LB Bag', 'Packaging', '52.99', 3021);

INSERT INTO product (
pid, name, category, price, sid) 
VALUES (
	99942, 'Plastic Bag', 'Packaging', '50.99', 3021);

INSERT INTO product (
pid, name, category, price, sid) 
VALUES (
	99941, 'Soup Container', 'Packaging', '46.50', 3021);

INSERT INTO product (
pid, name, category, price, sid) 
VALUES (
	99940, 'Soup Container Lid', 'Packaging', '34.50', 3021);

--``````````````````````````````````````````````````````````````````````````
INSERT INTO orders (
oid, cost, status, orderDate, shipDate, rid, sid, did) 
VALUES (
	100, '0.00', 'delivered', '1/03/18', '19/03/18', 10, 3003, 998);

INSERT INTO orders (
oid, cost, status, orderDate, shipDate, rid, sid, did) 
VALUES (
	101, '0.00', 'ordered', '14/03/18', '01/04/18', 11, 3005, 999);

INSERT INTO orders (
oid, cost, status, orderDate, shipDate, rid, sid, did) 
VALUES (
	102, '0.00', 'processing', '06/04/18', '12/04/18', 11, 3007, 1000);

INSERT INTO orders (
oid, cost, status, orderDate, shipDate, rid, sid, did) 
VALUES (
	103, '0.00', 'processing', '27/03/18', '31/03/18', 11, 3015, 1004);

INSERT INTO orders (
oid, cost, status, orderDate, shipDate, rid, sid, did) 
VALUES (
	104, '0.00', 'delivered', '16/02/18', '20/02/18', 12, 3007, 1000);

INSERT INTO orders (
oid, cost, status, orderDate, shipDate, rid, sid, did) 
VALUES (
	105, '0.00', 'delivered', '14/02/18', '19/02/18', 13, 3013, 1003);

INSERT INTO orders (
oid, cost, status, orderDate, shipDate, rid, sid, did) 
VALUES (
	106, '0.00', 'ordered', '14/03/18', '01/04/18', 14, 3021, 1004);

INSERT INTO orders (
oid, cost, status, orderDate, shipDate, rid, sid, did) 
VALUES (
	107, '0.00', 'delivered', '31/01/18', '02/02/18', 14, 3011, 1006);

INSERT INTO orders (
oid, cost, status, orderDate, shipDate, rid, sid, did) 
VALUES (
	108, '0.00', 'ordered', '16/03/18', '02/04/18', 15, 3009, 1001);

INSERT INTO orders (
oid, cost, status, orderDate, shipDate, rid, sid, did) 
VALUES (
	109, '0.00', 'delivered', '06/03/18', '12/03/18', 15, 3017, 1005);

INSERT INTO orders (
oid, cost, status, orderDate, shipDate, rid, sid, did) 
VALUES (
	110, '0.00', 'processing', '28/03/18', '5/04/18', 16, 3019, 1005);

INSERT INTO orders (
oid, cost, status, orderDate, shipDate, rid, sid, did) 
VALUES (
	111, '0.00', 'ordered', '20/03/18', '15/04/18', 17, 3017, 1002);

INSERT INTO orders (
oid, cost, status, orderDate, shipDate, rid, sid, did) 
VALUES (
	112, '0.00', 'ordered', '15/03/18', '6/04/18', 18, 3013, 1003);

INSERT INTO orders (
oid, cost, status, orderDate, shipDate, rid, sid, did) 
VALUES (
	113, '0.00', 'delivered', '01/03/18', '12/03/18', 18, 3021, 1004);

INSERT INTO orders (
oid, cost, status, orderDate, shipDate, rid, sid, did) 
VALUES (
	114, '0.00', 'ordered', '19/03/18', '10/04/18', 19, 3003, 998);

INSERT INTO orders (
oid, cost, status, orderDate, shipDate, rid, sid, did) 
VALUES (
	115, '0.00', 'delivered', '1/03/18', '19/03/18', 20, 3003, 998);

INSERT INTO orders (
oid, cost, status, orderDate, shipDate, rid, sid, did) 
VALUES (
	116, '0.00', 'ordered', '14/03/18', '01/04/18', 10, 3005, 999);

INSERT INTO orders (
oid, cost, status, orderDate, shipDate, rid, sid, did) 
VALUES (
	117, '0.00', 'processing', '06/04/18', '12/04/18', 10, 3007, 1000);

INSERT INTO orders (
oid, cost, status, orderDate, shipDate, rid, sid, did) 
VALUES (
	118, '0.00', 'processing', '27/03/18', '31/03/18', 16, 3015, 1005);

INSERT INTO orders (
oid, cost, status, orderDate, shipDate, rid, sid, did) 
VALUES (
	119, '0.00', 'delivered', '16/02/18', '20/02/18', 21, 3007, 1000);

INSERT INTO orders (
oid, cost, status, orderDate, shipDate, rid, sid, did) 
VALUES (
	120, '0.00', 'delivered', '14/02/18', '19/02/18', 18, 3013, 1003);

INSERT INTO orders (
oid, cost, status, orderDate, shipDate, rid, sid, did) 
VALUES (
	121, '0.00', 'ordered', '14/03/18', '01/04/18', 21, 3021, 1004);

INSERT INTO orders (
oid, cost, status, orderDate, shipDate, rid, sid, did) 
VALUES (
	122, '0.00', 'delivered', '31/01/18', '02/02/18', 19, 3011, 1002);

INSERT INTO orders (
oid, cost, status, orderDate, shipDate, rid, sid, did) 
VALUES (
	123, '0.00', 'ordered', '16/03/18', '02/04/18', 12, 3009, 1001);

INSERT INTO orders (
oid, cost, status, orderDate, shipDate, rid, sid, did) 
VALUES (
	124, '0.00', 'delivered', '06/03/18', '12/03/18', 11, 3017, 1002);

INSERT INTO orders (
oid, cost, status, orderDate, shipDate, rid, sid, did) 
VALUES (
	125, '0.00', 'processing', '28/03/18', '5/04/18', 11, 3019, 1000);

INSERT INTO orders (
oid, cost, status, orderDate, shipDate, rid, sid, did) 
VALUES (
	126, '0.00', 'ordered', '20/03/18', '15/04/18', 10, 3017, 1002);

INSERT INTO orders (
oid, cost, status, orderDate, shipDate, rid, sid, did) 
VALUES (
	127, '0.00', 'ordered', '15/03/18', '6/04/18', 14, 3013, 1003);

INSERT INTO orders (
oid, cost, status, orderDate, shipDate, rid, sid, did) 
VALUES (
	128, '0.00', 'delivered', '01/03/18', '12/03/18', 15, 3021, 1004);

INSERT INTO orders (
oid, cost, status, orderDate, shipDate, rid, sid, did) 
VALUES (
	129, '0.00', 'ordered', '19/03/18', '10/04/18', 15, 3003, 998);

INSERT INTO orders (
oid, cost, status, orderDate, shipDate, rid, sid, did) 
VALUES (
	130, '0.00', 'delivered', '31/01/18', '02/02/18', 11, 3011, 1006);

-- restaurants 10-19 have orders, 20-23
	
-- ``````````````````````````````````````````````````````````````````````
INSERT INTO warehouse (
wid, phone, unitNo, street, city, province, sid) 
VALUES (
	150, '7784444445', 204, 'Main St', 'Vancouver', 'BC', 3003);

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

INSERT INTO contain VALUES (100, 99993, 3003, 3003, 64);
INSERT INTO contain VALUES (100, 99992, 3003, 3003, 186);
INSERT INTO contain VALUES (100, 99991, 3003, 3003, 259);
INSERT INTO contain VALUES (100, 99988, 3003, 3003, 287);
INSERT INTO contain VALUES (100, 99987, 3003, 3003, 18);

INSERT INTO contain VALUES (114, 99987, 3003, 3003, 142);

INSERT INTO contain VALUES (115, 99993, 3003, 3003, 51);
INSERT INTO contain VALUES (115, 99992, 3003, 3003, 61);
INSERT INTO contain VALUES (115, 99988, 3003, 3003, 167);
INSERT INTO contain VALUES (115, 99987, 3003, 3003, 155);

INSERT INTO contain VALUES (129, 99993, 3003, 3003, 265);
INSERT INTO contain VALUES (129, 99988, 3003, 3003, 20);
INSERT INTO contain VALUES (129, 99987, 3003, 3003, 181);

INSERT INTO contain VALUES (101, 99999, 3005, 3005, 19);
INSERT INTO contain VALUES (101, 99998, 3005, 3005, 161);
INSERT INTO contain VALUES (101, 99986, 3005, 3005, 28);
INSERT INTO contain VALUES (101, 99985, 3005, 3005, 14);
INSERT INTO contain VALUES (101, 99984, 3005, 3005, 184);
INSERT INTO contain VALUES (101, 99983, 3005, 3005, 204);

INSERT INTO contain VALUES (116, 99999, 3005, 3005, 146);
INSERT INTO contain VALUES (116, 99986, 3005, 3005, 59);
INSERT INTO contain VALUES (116, 99985, 3005, 3005, 178);
INSERT INTO contain VALUES (116, 99984, 3005, 3005, 98);
INSERT INTO contain VALUES (116, 99983, 3005, 3005, 184);

INSERT INTO contain VALUES (102, 99997, 3007, 3007, 194);
INSERT INTO contain VALUES (102, 99982, 3007, 3007, 69);
INSERT INTO contain VALUES (102, 99981, 3007, 3007, 105);
INSERT INTO contain VALUES (102, 99980, 3007, 3007, 72);

INSERT INTO contain VALUES (104, 99982, 3007, 3007, 274);
INSERT INTO contain VALUES (104, 99980, 3007, 3007, 80);

INSERT INTO contain VALUES (117, 99982, 3007, 3007, 155);
INSERT INTO contain VALUES (117, 99981, 3007, 3007, 83);
INSERT INTO contain VALUES (117, 99980, 3007, 3007, 163);

INSERT INTO contain VALUES (119, 99997, 3007, 3007, 167);
INSERT INTO contain VALUES (119, 99982, 3007, 3007, 97);
INSERT INTO contain VALUES (119, 99981, 3007, 3007, 225);

INSERT INTO contain VALUES (108, 99996, 3009, 3009, 67);
INSERT INTO contain VALUES (108, 99994, 3009, 3009, 242);
INSERT INTO contain VALUES (108, 99979, 3009, 3009, 164);
INSERT INTO contain VALUES (108, 99978, 3009, 3009, 106);
INSERT INTO contain VALUES (108, 99977, 3009, 3009, 112);
INSERT INTO contain VALUES (108, 99976, 3009, 3009, 123);
INSERT INTO contain VALUES (108, 99975, 3009, 3009, 81);
INSERT INTO contain VALUES (108, 99974, 3009, 3009, 67);
INSERT INTO contain VALUES (108, 99973, 3009, 3009, 297);
INSERT INTO contain VALUES (108, 99972, 3009, 3009, 49);

INSERT INTO contain VALUES (123, 99996, 3009, 3009, 237);
INSERT INTO contain VALUES (123, 99979, 3009, 3009, 81);
INSERT INTO contain VALUES (123, 99977, 3009, 3009, 118);
INSERT INTO contain VALUES (123, 99976, 3009, 3009, 16);
INSERT INTO contain VALUES (123, 99975, 3009, 3009, 44);
INSERT INTO contain VALUES (123, 99972, 3009, 3009, 252);

INSERT INTO contain VALUES (107, 99995, 3011, 3011, 10);
INSERT INTO contain VALUES (107, 99971, 3011, 3011, 177);
INSERT INTO contain VALUES (107, 99969, 3011, 3011, 51);
INSERT INTO contain VALUES (107, 99968, 3011, 3011, 34);

INSERT INTO contain VALUES (122, 99995, 3011, 3011, 279);
INSERT INTO contain VALUES (122, 99971, 3011, 3011, 55);

INSERT INTO contain VALUES (130, 99995, 3011, 3011, 263);
INSERT INTO contain VALUES (130, 99971, 3011, 3011, 196);
INSERT INTO contain VALUES (130, 99969, 3011, 3011, 210);
INSERT INTO contain VALUES (130, 99968, 3011, 3011, 55);

INSERT INTO contain VALUES (105, 99967, 3013, 3013, 280);
INSERT INTO contain VALUES (105, 99966, 3013, 3013, 167);
INSERT INTO contain VALUES (105, 99965, 3013, 3013, 165);
INSERT INTO contain VALUES (105, 99964, 3013, 3013, 206);
INSERT INTO contain VALUES (105, 99963, 3013, 3013, 173);

INSERT INTO contain VALUES (112, 99967, 3013, 3013, 76);
INSERT INTO contain VALUES (112, 99966, 3013, 3013, 281);
INSERT INTO contain VALUES (112, 99965, 3013, 3013, 144);
INSERT INTO contain VALUES (112, 99964, 3013, 3013, 53);

INSERT INTO contain VALUES (120, 99967, 3013, 3013, 174);
INSERT INTO contain VALUES (120, 99966, 3013, 3013, 272);
INSERT INTO contain VALUES (120, 99965, 3013, 3013, 87);

INSERT INTO contain VALUES (127, 99967, 3013, 3013, 250);
INSERT INTO contain VALUES (127, 99966, 3013, 3013, 38);
INSERT INTO contain VALUES (127, 99964, 3013, 3013, 139);
INSERT INTO contain VALUES (127, 99963, 3013, 3013, 39);

INSERT INTO contain VALUES (103, 99962, 3015, 3015, 236);
INSERT INTO contain VALUES (103, 99961, 3015, 3015, 283);
INSERT INTO contain VALUES (103, 99960, 3015, 3015, 275);
INSERT INTO contain VALUES (103, 99959, 3015, 3015, 286);
INSERT INTO contain VALUES (103, 99958, 3015, 3015, 42);

INSERT INTO contain VALUES (118, 99962, 3015, 3015, 42);
INSERT INTO contain VALUES (118, 99960, 3015, 3015, 213);
INSERT INTO contain VALUES (118, 99958, 3015, 3015, 25);

INSERT INTO contain VALUES (109, 99989, 3017, 3017, 181);
INSERT INTO contain VALUES (109, 99957, 3017, 3017, 142);
INSERT INTO contain VALUES (109, 99956, 3017, 3017, 208);
INSERT INTO contain VALUES (109, 99955, 3017, 3017, 58);
INSERT INTO contain VALUES (109, 99954, 3017, 3017, 112);
INSERT INTO contain VALUES (109, 99953, 3017, 3017, 190);
INSERT INTO contain VALUES (109, 99952, 3017, 3017, 276);

INSERT INTO contain VALUES (111, 99989, 3017, 3017, 57);
INSERT INTO contain VALUES (111, 99956, 3017, 3017, 195);
INSERT INTO contain VALUES (111, 99955, 3017, 3017, 36);
INSERT INTO contain VALUES (111, 99954, 3017, 3017, 249);
INSERT INTO contain VALUES (111, 99952, 3017, 3017, 194);

INSERT INTO contain VALUES (124, 99989, 3017, 3017, 74);
INSERT INTO contain VALUES (124, 99956, 3017, 3017, 140);
INSERT INTO contain VALUES (124, 99952, 3017, 3017, 50);

INSERT INTO contain VALUES (126, 99989, 3017, 3017, 55);
INSERT INTO contain VALUES (126, 99957, 3017, 3017, 290);
INSERT INTO contain VALUES (126, 99953, 3017, 3017, 55);
INSERT INTO contain VALUES (126, 99952, 3017, 3017, 54);

INSERT INTO contain VALUES (110, 99990, 3019, 3019, 223);
INSERT INTO contain VALUES (110, 99951, 3019, 3019, 77);
INSERT INTO contain VALUES (110, 99950, 3019, 3019, 272);
INSERT INTO contain VALUES (110, 99949, 3019, 3019, 97);
INSERT INTO contain VALUES (110, 99948, 3019, 3019, 122);
INSERT INTO contain VALUES (110, 99947, 3019, 3019, 220);

INSERT INTO contain VALUES (125, 99950, 3019, 3019, 141);
INSERT INTO contain VALUES (125, 99949, 3019, 3019, 270);
INSERT INTO contain VALUES (125, 99947, 3019, 3019, 71);

INSERT INTO contain VALUES (106, 99946, 3021, 3021, 198);
INSERT INTO contain VALUES (106, 99945, 3021, 3021, 164);
INSERT INTO contain VALUES (106, 99944, 3021, 3021, 277);
INSERT INTO contain VALUES (106, 99943, 3021, 3021, 282);
INSERT INTO contain VALUES (106, 99942, 3021, 3021, 30);
INSERT INTO contain VALUES (106, 99941, 3021, 3021, 114);
INSERT INTO contain VALUES (106, 99940, 3021, 3021, 73);

INSERT INTO contain VALUES (113, 99945, 3021, 3021, 248);
INSERT INTO contain VALUES (113, 99944, 3021, 3021, 217);
INSERT INTO contain VALUES (113, 99942, 3021, 3021, 14);
INSERT INTO contain VALUES (113, 99941, 3021, 3021, 179);

INSERT INTO contain VALUES (121, 99945, 3021, 3021, 146);
INSERT INTO contain VALUES (121, 99944, 3021, 3021, 99);
INSERT INTO contain VALUES (121, 99943, 3021, 3021, 195);
INSERT INTO contain VALUES (121, 99942, 3021, 3021, 171);
INSERT INTO contain VALUES (121, 99941, 3021, 3021, 193);
INSERT INTO contain VALUES (121, 99940, 3021, 3021, 14);

INSERT INTO contain VALUES (128, 99946, 3021, 3021, 75);
INSERT INTO contain VALUES (128, 99941, 3021, 3021, 300);
INSERT INTO contain VALUES (128, 99940, 3021, 3021, 282);

CREATE VIEW orderCosts AS select temp.oid, SUM(totalPrice) as orderPrice from ( select p.price, c.quantity, (p.price*c.quantity) as totalPrice, o.oid from orders o , product p,contain c where p.pid=c.pid AND o.oid=c.oid) temp, orders b where b.oid=temp.oid group by temp.oid;

update orders set cost=cost+(select t.orderPrice from orderCosts t where t.oid=100) where oid=100;
update orders set cost=cost+(select t.orderPrice from orderCosts t where t.oid=101) where oid=101;
update orders set cost=cost+(select t.orderPrice from orderCosts t where t.oid=102) where oid=102;
update orders set cost=cost+(select t.orderPrice from orderCosts t where t.oid=103) where oid=103;
update orders set cost=cost+(select t.orderPrice from orderCosts t where t.oid=104) where oid=104;
update orders set cost=cost+(select t.orderPrice from orderCosts t where t.oid=105) where oid=105;
update orders set cost=cost+(select t.orderPrice from orderCosts t where t.oid=106) where oid=106;
update orders set cost=cost+(select t.orderPrice from orderCosts t where t.oid=107) where oid=107;
update orders set cost=cost+(select t.orderPrice from orderCosts t where t.oid=108) where oid=108;
update orders set cost=cost+(select t.orderPrice from orderCosts t where t.oid=109) where oid=109;
update orders set cost=cost+(select t.orderPrice from orderCosts t where t.oid=110) where oid=110;
update orders set cost=cost+(select t.orderPrice from orderCosts t where t.oid=111) where oid=111;
update orders set cost=cost+(select t.orderPrice from orderCosts t where t.oid=112) where oid=112;
update orders set cost=cost+(select t.orderPrice from orderCosts t where t.oid=113) where oid=113;
update orders set cost=cost+(select t.orderPrice from orderCosts t where t.oid=114) where oid=114;
update orders set cost=cost+(select t.orderPrice from orderCosts t where t.oid=115) where oid=115;
update orders set cost=cost+(select t.orderPrice from orderCosts t where t.oid=116) where oid=116;
update orders set cost=cost+(select t.orderPrice from orderCosts t where t.oid=117) where oid=117;
update orders set cost=cost+(select t.orderPrice from orderCosts t where t.oid=118) where oid=118;
update orders set cost=cost+(select t.orderPrice from orderCosts t where t.oid=119) where oid=119;
update orders set cost=cost+(select t.orderPrice from orderCosts t where t.oid=120) where oid=120;
update orders set cost=cost+(select t.orderPrice from orderCosts t where t.oid=121) where oid=121;
update orders set cost=cost+(select t.orderPrice from orderCosts t where t.oid=122) where oid=122;
update orders set cost=cost+(select t.orderPrice from orderCosts t where t.oid=123) where oid=123;
update orders set cost=cost+(select t.orderPrice from orderCosts t where t.oid=124) where oid=124;
update orders set cost=cost+(select t.orderPrice from orderCosts t where t.oid=125) where oid=125;
update orders set cost=cost+(select t.orderPrice from orderCosts t where t.oid=126) where oid=126;
update orders set cost=cost+(select t.orderPrice from orderCosts t where t.oid=127) where oid=127;
update orders set cost=cost+(select t.orderPrice from orderCosts t where t.oid=128) where oid=128;
update orders set cost=cost+(select t.orderPrice from orderCosts t where t.oid=129) where oid=129;
update orders set cost=cost+(select t.orderPrice from orderCosts t where t.oid=130) where oid=130;

drop view orderCosts;

--``````````````````````````````````````````````````````````````````````
INSERT INTO stores (
wid, pid, sid, onHand, status) 
VALUES (
	150, 99993, 3003, 110, 'Available');

INSERT INTO stores (
wid, pid, sid, onHand, status) 
VALUES (
	150, 99992, 3003, 123, 'Available');

INSERT INTO stores (
wid, pid, sid, onHand, status) 
VALUES (
	150, 99988, 3003, 321, 'Available');

INSERT INTO stores (
wid, pid, sid, onHand, status) 
VALUES (
	150, 99987, 3003, 234, 'Available');

INSERT INTO stores (
wid, pid, sid, onHand, status) 
VALUES (
	010, 99999, 3005, 110, 'Available'); 

INSERT INTO stores (
wid, pid, sid, onHand, status) 
VALUES (
	010, 99998, 3005, 150, 'Available'); 

INSERT INTO stores (
wid, pid, sid, onHand, status) 
VALUES (
	010, 99986, 3005, 187, 'Available'); 

INSERT INTO stores (
wid, pid, sid, onHand, status) 
VALUES (
	010, 99985, 3005, 153, 'Available'); 

INSERT INTO stores (
wid, pid, sid, onHand, status) 
VALUES (
	010, 99984, 3005, 190, 'Available'); 

INSERT INTO stores (
wid, pid, sid, onHand, status) 
VALUES (
	010, 99983, 3005, 0, 'Unavailable'); 

INSERT INTO stores (
wid, pid, sid, onHand, status) 
VALUES (
	020, 99997, 3007, 200, 'Available');
	
INSERT INTO stores (
wid, pid, sid, onHand, status) 
VALUES (
	020, 99982, 3007, 234, 'Available'); 

INSERT INTO stores (
wid, pid, sid, onHand, status) 
VALUES (
	020, 99981, 3007, 825, 'Available');

INSERT INTO stores (
wid, pid, sid, onHand, status) 
VALUES (
	020, 99980, 3007, 372, 'Available');

INSERT INTO stores (
wid, pid, sid, onHand, status) 
VALUES (
	030, 99996, 3009, 923, 'Available'); 

INSERT INTO stores (
wid, pid, sid, onHand, status) 
VALUES (
	030, 99994, 3009, 374, 'Available'); 

INSERT INTO stores (
wid, pid, sid, onHand, status) 
VALUES (
	030, 99979, 3009, 912, 'Available'); 

INSERT INTO stores (
wid, pid, sid, onHand, status) 
VALUES (
	030, 99978, 3009, 0, 'Unavailable'); 

INSERT INTO stores (
wid, pid, sid, onHand, status) 
VALUES (
	030, 99977, 3009, 362, 'Available'); 

INSERT INTO stores (
wid, pid, sid, onHand, status) 
VALUES (
	030, 99976, 3009, 134, 'Available'); 

INSERT INTO stores (
wid, pid, sid, onHand, status) 
VALUES (
	030, 99975, 3009, 121, 'Available'); 

INSERT INTO stores (
wid, pid, sid, onHand, status) 
VALUES (
	030, 99974, 3009, 461, 'Available'); 

INSERT INTO stores (
wid, pid, sid, onHand, status) 
VALUES (
	030, 99973, 3009, 0, 'Unavailable'); 

INSERT INTO stores (
wid, pid, sid, onHand, status) 
VALUES (
	030, 99972, 3009, 421, 'Available');
	
INSERT INTO stores (
wid, pid, sid, onHand, status) 
VALUES (
	100, 99972, 3009, 539, 'Available'); 

INSERT INTO stores (
wid, pid, sid, onHand, status) 
VALUES (
	100, 99977, 3009, 838, 'Available'); 

INSERT INTO stores (
wid, pid, sid, onHand, status) 
VALUES (
	100, 99976, 3009, 223, 'Available'); 

INSERT INTO stores (
wid, pid, sid, onHand, status) 
VALUES (
	040, 99995, 3011, 0, 'Available');  

INSERT INTO stores (
wid, pid, sid, onHand, status) 
VALUES (
	040, 99971, 3011, 234, 'Available');  

INSERT INTO stores (
wid, pid, sid, onHand, status) 
VALUES (
	040, 99970, 3011, 349, 'Available');  

INSERT INTO stores (
wid, pid, sid, onHand, status) 
VALUES (
	040, 99969, 3011, 983, 'Available');  

INSERT INTO stores (
wid, pid, sid, onHand, status) 
VALUES (
	110, 99970, 3011, 283, 'Available');  

INSERT INTO stores (
wid, pid, sid, onHand, status) 
VALUES (
	110, 99969, 3011, 896, 'Available');  

INSERT INTO stores (
wid, pid, sid, onHand, status) 
VALUES (
	110, 99968, 3011, 456, 'Available');  

INSERT INTO stores (
wid, pid, sid, onHand, status) 
VALUES (
	050, 99967, 3013, 746, 'Available');  

INSERT INTO stores (
wid, pid, sid, onHand, status) 
VALUES (
	050, 99964, 3013, 492, 'Available');

INSERT INTO stores (
wid, pid, sid, onHand, status) 
VALUES (
	050, 99963, 3013, 722, 'Available');

INSERT INTO stores (
wid, pid, sid, onHand, status) 
VALUES (
	120, 99967, 3013, 634, 'Available');

INSERT INTO stores (
wid, pid, sid, onHand, status) 
VALUES (
	120, 99966, 3013, 333, 'Available');

INSERT INTO stores (
wid, pid, sid, onHand, status) 
VALUES (
	120, 99965, 3013, 129, 'Available');

INSERT INTO stores (
wid, pid, sid, onHand, status) 
VALUES (
	120, 99964, 3013, 199, 'Available');

INSERT INTO stores (
wid, pid, sid, onHand, status) 
VALUES (
	120, 99963, 3013, 631, 'Available');

INSERT INTO stores (
wid, pid, sid, onHand, status) 
VALUES (
	060, 99962, 3015, 239, 'Available');

INSERT INTO stores (
wid, pid, sid, onHand, status) 
VALUES (
	060, 99961, 3015, 381, 'Available');

INSERT INTO stores (
wid, pid, sid, onHand, status) 
VALUES (
	060, 99960, 3015, 913, 'Available');

INSERT INTO stores (
wid, pid, sid, onHand, status) 
VALUES (
	130, 99962, 3015, 821, 'Available');

INSERT INTO stores (
wid, pid, sid, onHand, status) 
VALUES (
	130, 99961, 3015, 729, 'Available');

INSERT INTO stores (
wid, pid, sid, onHand, status) 
VALUES (
	130, 99960, 3015, 104, 'Available');

INSERT INTO stores (
wid, pid, sid, onHand, status) 
VALUES (
	130, 99959, 3015, 901, 'Available');

INSERT INTO stores (
wid, pid, sid, onHand, status) 
VALUES (
	140, 99962, 3015, 720, 'Available');

INSERT INTO stores (
wid, pid, sid, onHand, status) 
VALUES (
	140, 99961, 3015, 124, 'Available');

INSERT INTO stores (
wid, pid, sid, onHand, status) 
VALUES (
	140, 99960, 3015, 945, 'Available');

INSERT INTO stores (
wid, pid, sid, onHand, status) 
VALUES (
	140, 99959, 3015, 831, 'Available');

INSERT INTO stores (
wid, pid, sid, onHand, status) 
VALUES (
	140, 99958, 3015, 864, 'Available');

INSERT INTO stores (
wid, pid, sid, onHand, status) 
VALUES (
	070, 99989, 3017, 111, 'Available');

INSERT INTO stores (
wid, pid, sid, onHand, status) 
VALUES (
	070, 99957, 3017, 642, 'Available');

INSERT INTO stores (
wid, pid, sid, onHand, status) 
VALUES (
	070, 99956, 3017, 528, 'Available');

INSERT INTO stores (
wid, pid, sid, onHand, status) 
VALUES (
	070, 99955, 3017, 285, 'Available');

INSERT INTO stores (
wid, pid, sid, onHand, status) 
VALUES (
	070, 99954, 3017, 347, 'Available');

INSERT INTO stores (
wid, pid, sid, onHand, status) 
VALUES (
	070, 99953, 3017, 274, 'Available');

INSERT INTO stores (
wid, pid, sid, onHand, status) 
VALUES (
	070, 99952, 3017, 123, 'Available');

INSERT INTO stores (
wid, pid, sid, onHand, status) 
VALUES (
	080, 99990, 3019, 281, 'Available');

INSERT INTO stores (
wid, pid, sid, onHand, status) 
VALUES (
	080, 99950, 3019, 741, 'Available');

INSERT INTO stores (
wid, pid, sid, onHand, status) 
VALUES (
	080, 99949, 3019, 244, 'Available');

INSERT INTO stores (
wid, pid, sid, onHand, status) 
VALUES (
	080, 99948, 3019, 234, 'Available');

INSERT INTO stores (
wid, pid, sid, onHand, status) 
VALUES (
	080, 99947, 3019, 654, 'Available');

INSERT INTO stores (
wid, pid, sid, onHand, status) 
VALUES (
	090, 99946, 3021, 139, 'Available');

INSERT INTO stores (
wid, pid, sid, onHand, status) 
VALUES (
	090, 99945, 3021, 246, 'Available');    

INSERT INTO stores (
wid, pid, sid, onHand, status) 
VALUES (
	090, 99944, 3021, 693, 'Available');    

INSERT INTO stores (
wid, pid, sid, onHand, status) 
VALUES (
	090, 99943, 3021, 941, 'Available');    

INSERT INTO stores (
wid, pid, sid, onHand, status) 
VALUES (
	090, 99942, 3021, 734, 'Available');    

INSERT INTO stores (
wid, pid, sid, onHand, status) 
VALUES (
	090, 99941, 3021, 632, 'Available');    

INSERT INTO stores (
wid, pid, sid, onHand, status) 
VALUES (
	090, 99940, 3021, 724, 'Available');        