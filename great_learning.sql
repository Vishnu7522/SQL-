use bank;
create table bank_holidays(
holiday date,
start_time datetime,
end_time  timestamp
);
describe bank_holidays;

insert into bank_holidays value(
current_date(),
current_date(),
current_date()
);
select * from bank_holidays;

update bank_holiday_s set holiday = date_add(holiday,interval 10 day);

select * from bank_holidays;
