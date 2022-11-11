create table bank_details(
product char(10),
quantity int,
price real,
purchase_cost decimal(6,2),
estimated_sales_price float
);


describe bank_details;
select * from bank_details;
insert into bank_details values('paycard',3,330,8008,9009);
insert into bank_details values('paypoint',4,200,800,6800);

alter table bank_details add column geo_locatiom varchar(20);

select geo_locatiom from bank_details where product='paycard';
select * from bank_details;
select char_length(product) from bank_details where product = 'paycard';

describe bank_details;

alter table bank_details modify product varchar(10);





