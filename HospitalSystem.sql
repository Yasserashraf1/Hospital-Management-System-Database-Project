create table room(
room_id int primary key,
room_type varchar(250) not null
);

create table doctor(
doctor_id int primary key,
fname varchar(50) not null,
lname varchar(50) not null,
specialization varchar(50) not null
);

create table nurse(
nurse_id int primary key,
fname varchar(50) not null,
lname varchar(50) not null,
supervisor_id int,
foreign key (supervisor_id) references nurse(nurse_id)
);

create table ward_boys(
WB_Id int primary key,
fname varchar(50) not null,
lname varchar(50) not null,
nurse_id int,
foreign key (nurse_id) references nurse(nurse_id)
);

create table  patient(
patient_id int primary key,
fname varchar(50) not null,
lname varchar(50) not null,
age int not null,
phone int not null,
disease varchar(250) not null,
room_num int ,
doctor_ID int,
nurse_id int,
ward_boy_id int,
foreign key (room_num) references room(room_id),
foreign key (doctor_ID) references doctor(doctor_id),
foreign key (nurse_id) references nurse(nurse_id),
foreign key (ward_boy_id) references ward_boys(WB_Id)
);

create table drug(
drug_id int primary key,
drug_name varchar(50) not null
);

create table preciptions(
preciption_id int primary key,
patient_id int ,
doctor_id int,
Drug_id int,
foreign key (patient_id) references patient(patient_id),
foreign key (doctor_id) references doctor(doctor_id),
foreign key (Drug_id) references drug(drug_id)
);

create table bill(
bill_id int primary key, -- assume room cost per day=100
room_day_cost float  default 100,  		-- assume room cost per day=100
ndays int not null,					 	--  number of days patient stays in
total_room_cost float not null,		 	-- total room cost = ndays * room_day_cost
unit_drug_cost float  default 150,	 	-- assume drug cost per unit =150
ndrugs int not null,				 	-- number of drugs 
preciption_cost float not null,		 	-- preciption_cost= ndrugs * unit_drug_cost
npreciptions float not null,		 	-- number of preciptions
total_preciptions_cost float not null, 	-- total_preciptions_cost=preciption_cost * npreciptions
total_Bill_cost float not null,			-- total bill cost= total_preciptions_cost + total room cost
patient_id int,
preciption_id int,
foreign key (patient_id) references patient(patient_id),
foreign key (preciption_id) references preciptions(preciption_id)
);


INSERT INTO room
VALUES (101,'ordinary'), (102,'ICU'), (103,'ordinary');
INSERT INTO room
VALUES (109,'ordinary'), (104,'ICU'), (110,'ordinary'),
		(201,'ordinary'), (202,'ICU'), (206,'ordinary');

-- Insert a Head Nurse (supervisor_id can be null for the head)
INSERT INTO nurse (nurse_id, fname, lname, supervisor_id)
VALUES (2000, 'Maria', 'Garcia', NULL);

-- Insert Nurses under the Head Nurse (referencing supervisor_id)
INSERT INTO nurse (nurse_id, fname, lname, supervisor_id)
VALUES (2002, 'David', 'Miller', 2000),
       (2008, 'Lisa', 'Wilson', 2000),
       (2005, 'David', 'Miller', 2000),
       (2007, 'Lisa', 'Wilson', 2000);

-- Insert Ward Boys under Nurses
INSERT INTO ward_boys (WB_Id, fname, lname, nurse_id)
VALUES (3001, 'Peter', 'Clark', 2000),
       (3002, 'Emily', 'Jones', 2000),
       (3007, 'Peter', 'Clark', 2000),
       (3000, 'Emily', 'Jones', 2000);

INSERT INTO doctor (doctor_id, fname, lname, specialization)
VALUES (22010409, 'John', 'Smith', 'Cardiology'),
       (22010444, 'Jane', 'Doe', 'Dermatology'),
       (22010111, 'Michael', 'Lee', 'Neurology');
INSERT INTO doctor (doctor_id, fname, lname, specialization)
VALUES (22010112, 'John', 'Smith', 'Cardiology'),
       (22010114, 'Jane', 'Doe', 'Dermatology'),
       (22010110, 'Michael', 'Lee', 'Neurology');
       

INSERT INTO patient (patient_id, fname, lname, age, phone, disease, room_num, doctor_ID,nurse_id,ward_boy_id)
VALUES (1001, 'Alice', 'Johnson', 35, 1234567890, 'Flu', 101,22010409,2002,3001 ),
       (1002, 'Bob', 'Williams', 28, 455, 'Sprain', 102, 22010444,2008,3007),
       (1003, 'Charlie', 'Brown', 50, 345, 'Diabetes', 103, 22010111,2005,3002);
INSERT INTO patient (patient_id, fname, lname, age, phone, disease, room_num, doctor_ID,nurse_id,ward_boy_id)
VALUES (1009, 'Alice', 'Johnson', 35, 1234567890, 'Flu', 109, 22010112,2007,3000),
       (1008, 'Bob', 'Williams', 28, 455, 'Sprain', 202, 22010114,2002,3007),
       (1000, 'Charlie', 'Brown', 50, 345, 'Diabetes', 206, 22010110,2008,3002);
       
INSERT INTO drug (drug_id, drug_name)
VALUES (014, 'Paracetamol'),
       (015, 'Aspirin'),
       (016, 'Insulin'),
       (019, 'Paracetamol'),
       (020, 'Aspirin'),
       (099, 'Insulin');

INSERT INTO preciptions (preciption_id, patient_id, doctor_id, Drug_id)
VALUES (501, 1001,22010409, 099),  
       (502,1009, 22010444, 016),  
       (503,1000, 22010112, 020),
       (510,1003, 22010114, 099),  
       (500,1000, 22010110, 015),  
       (590,1002, 22010409, 014); 
	
insert into bill(bill_id,ndays,total_room_cost,ndrugs,preciption_cost,npreciptions,total_preciptions_cost,total_Bill_cost,patient_id,preciption_id) 
values(1,3,(ndays * room_day_cost),4,(ndrugs * unit_drug_cost),1,(npreciptions * preciption_cost),(total_preciptions_cost + total_room_cost),1001,501);

insert into bill(bill_id,ndays,total_room_cost,ndrugs,preciption_cost,npreciptions,total_preciptions_cost,total_Bill_cost,patient_id,preciption_id) 
values(2,4,(ndays * room_day_cost),2,(ndrugs * unit_drug_cost),3,(npreciptions * preciption_cost),(total_preciptions_cost + total_room_cost),1002,502);

insert into bill(bill_id,ndays,total_room_cost,ndrugs,preciption_cost,npreciptions,total_preciptions_cost,total_Bill_cost,patient_id,preciption_id) 
values(3,2,(ndays * room_day_cost),1,(ndrugs * unit_drug_cost),2,(npreciptions * preciption_cost),(total_preciptions_cost + total_room_cost),1000,500);

insert into bill(bill_id,ndays,total_room_cost,ndrugs,preciption_cost,npreciptions,total_preciptions_cost,total_Bill_cost,patient_id,preciption_id) 
values(8,3,(ndays * room_day_cost),4,(ndrugs * unit_drug_cost),1,(npreciptions * preciption_cost),(total_preciptions_cost + total_room_cost),1009,502);

insert into bill(bill_id,ndays,total_room_cost,ndrugs,preciption_cost,npreciptions,total_preciptions_cost,total_Bill_cost,patient_id,preciption_id) 
values(9,4,(ndays * room_day_cost),2,(ndrugs * unit_drug_cost),3,(npreciptions * preciption_cost),(total_preciptions_cost + total_room_cost),1003,510);

insert into bill(bill_id,ndays,total_room_cost,ndrugs,preciption_cost,npreciptions,total_preciptions_cost,total_Bill_cost,patient_id,preciption_id) 
values(5,2,(ndays * room_day_cost),1,(ndrugs * unit_drug_cost),2,(npreciptions * preciption_cost),(total_preciptions_cost + total_room_cost),1009,500);




select total_Bill_cost from bill where bill_id=1;
select total_Bill_cost from bill where patient_id=1002;
select total_Bill_cost from bill where preciption_id=502;

-- default acsending //DECS
select patient_id , total_Bill_cost  from bill order by total_Bill_cost; 

select min(total_Bill_cost) ,max(total_Bill_cost), sum(total_Bill_cost), count(total_Bill_cost),avg(total_Bill_cost) from bill;

SELECT patient.patient_id, preciptions.Drug_id
FROM patient
inner JOIN preciptions 
ON  patient.doctor_ID = preciptions.doctor_id;

SELECT patient.patient_id, bill.preciption_cost
FROM patient
left JOIN bill 
ON  patient.patient_id=bill.patient_id;

SELECT doctor.doctor_id, doctor.fname,patient.patient_id, patient.fname,patient.lname,patient.disease
FROM doctor
right JOIN  patient
ON  doctor.doctor_ID = patient.doctor_id;

SELECT patient.patient_id, preciptions.Drug_id
FROM patient
cross JOIN preciptions;

select patient_id from patient 
union 
select patient_id from bill;

select patient_id from patient 
union all
select patient_id from bill;
