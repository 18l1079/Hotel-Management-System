drop database hotel;
create database hotel;
use hotel;
go

drop table client;
create table client
(
	Client_id int not null,
	Fname varchar(20) not null,
	Lname varchar(20) not null,
	gender char not null,
	guestAddress varchar(50),
	cnic varchar(20) not null,
	phone varchar(20)  not null,
	Email varchar(20)  not null,
	booking_count int  not null,
	[password] varchar(20) not null,
	constraint clientPK primary key (client_id),
	constraint clientGender check (upper(gender) = 'M' or upper(gender) = 'F'),
	constraint clientCnic unique(cnic),
	constraint clientBookingCount check (booking_count >= 0)
);

go
create table hotel
(
	hotel_id int not null,
	hotelName varchar(20) not null,
	city varchar(20) not null,
	hotelAddress varchar(50) not null,
	rating decimal(2,1) not null,
	hotel_owner int not null,
	constraint hotelPK primary key(hotel_id),
	constraint ownerFK foreign key (hotel_owner) references [owner] (owner_id)
);
	insert into hotel values('123','5-Star','Pak-Pattan','Ward no 3 street no 2',5);
go
create table [owner]
(
	owner_id int not null,
	Fname varchar(20) not null,
	Lname varchar(20) not null,
	gender char not null,
	cnic varchar(20) not null,
	owner_address varchar(50),
	phone varchar(20) not null,
	[password] varchar(20) not null,
	email varchar(20) not null,
	constraint ownerPK primary key (owner_id),
	constraint ownerGender check (upper(gender) = 'M' or upper(gender) = 'F'),
	constraint ownerCnic unique(cnic),
);
go
create table room
(
	room_id int not null,
	hotel_id int not null,
	[type] char not null,
	price decimal(5,2) not null,
	constraint roomPK primary key (room_id, hotel_id),
	constraint roomType check(upper([type]) = 'S' or upper([type]) = 'D' or upper([type]) = 'F'),
	foreign key (hotel_id) REFERENCES hotel(hotel_id) 
	on delete cascade on update cascade
);
go

create table booking
(
	client_id int not null,
	room_id int not null,
	hotel_id int not null,
	date_from datetime not null,
	date_to datetime not null,
	constraint bookingPK primary key (client_id, room_id, hotel_id, date_from),
	foreign key (client_id) REFERENCES client(client_id),
	foreign key (room_id, hotel_id) REFERENCES room(room_id, hotel_id)
	on delete cascade on update cascade
);
go

--1.1

create procedure client_SignUp 
@client_id int,
@Fname varchar(20),
@Lname varchar(20),
@gender char,
@guestAddress varchar(50),
@cnic varchar(20),
@phone varchar(20),
@email varchar(20),
@password varchar(20)
as
begin
	if(@client_id is null OR @Fname is null OR
	   @Lname is null OR @gender is null OR 
	   @guestAddress is null OR @cnic is null OR
	   @phone is null OR @email is null OR
	   @password is null)
	begin
		print 'All fields must be provided for sign up'
		return 0 --Bit Status returning
	end
	if(exists(select * from client where client_id = @client_id) OR 
	   exists(select * from client where cnic = @cnic))
	begin
		print 'There is already a client with this id or cnic'
		return 0 
	end
	else
	begin
		insert into client values(@client_id, @Fname, @Lname, @gender,
		 @guestAddress, @cnic, @phone, @email, 0, @password)
		 return 1
	end
end;

Declare @temp int
exec @temp=client_SignUp
@client_id = 12,
@cnic = '164',
@password = 'opooSamsung'; 
select @temp



Declare @temp1 int
exec @temp1=client_SignUp
@client_id=13,
@Fname ='Arfeen',
@Lname ='Yousuf',
@gender ='M',
@guestAddress = '162-B FaisalTown Phase 2 Lahore',
@cnic ='12345678',
@phone ='090078601',
@Email ='arfeen.yousuf@gmail.com',
@password ='Arfeen';

select * from client


create procedure owner_SignUp 
@owner_id int,
@Fname varchar(20),
@Lname varchar(20),
@gender char,
@cnic varchar(20),
@owner_address varchar(50), 
@phone varchar(20),
@password varchar(20),
@email varchar(20)
as
begin
	if(@owner_id is null OR @Fname is null OR 
	   @Lname is null OR @gender is null OR 
	   @cnic is null OR @owner_address is null OR 
	   @phone is null OR @password is null OR 
	   @email is null)
	begin
		print 'All foelds must be provided for sign up'
		return 0 --Bit Status returning
	end
	if(exists(select * from [owner] where owner_id = @owner_id) OR
	   exists(select * from [owner] where cnic = @cnic))
	begin
		print 'There is already an owner with this id or cnic'
		return 0 
	end
	else
	begin
		insert into [owner] values(@owner_id, @Fname, @Lname, @gender,
		 @cnic, @owner_address, @phone, @password, @email)
		 return 1
	end
end;

Declare @own1 int
exec @own1=owner_SignUp
@owner_id = 1,
@Fname ='Faisal',
@Lname ='Latif',
@gender ='M',
@cnic ='09876512',
@email= 'techhub123@gmail.com',
@owner_address ='Tech Hub wala muhalla galli no 2', 
@phone ='0301214578',
@password ='Youtubechain';


select *from [owner]

--1.2
create procedure client_login
@client_id int,
@password varchar(20)
as 
begin
	if(@client_id is null or @password is null)
	begin
		print 'Both id and password must be provided for login'
		return 0
	end
	else
	begin
		if(exists(
			select * from client 
			where @client_id = client_id and @password = [password] )
		)
		begin
			return 1
		end
		else
		begin
			return 0
		end
	end
end;

Declare @lo1 int
exec @lo1=client_login
@client_id =13,
@password ='Arfeen';

select @lo1

create procedure owner_login
@owner_id int,
@password varchar(20)
as 
begin
	if(@owner_id is null or @password is null)
	begin
		print 'Both id and password must be provided for login'
		return 0
	end
	else
	begin
		if(exists(
			select * from [owner]  
			where @owner_id = owner_id and @password = [password] )
		)
		begin
			return 1
		end
		else
		begin
			return 0
		end
	end
end;

Declare @lc1 int
exec @lc1=owner_login
@owner_id =1,
@password ='Youtubechain';

select @lc1;

--1.3 return 1 means updated and 0 means password incorrect(
Create procedure updateClient
@client_id int not null,
@Fname varchar(20) = null,
@Lname varchar(20) = null,
@gender char = null,
@guestAddress varchar(50) = null,
@cnic varchar(20) = null,
@phone varchar(20) = null,
@Email varchar(20) = null, 
@password varchar(20) not null,
@new_password varchar(20) = null
AS
Begin
Declare @output bit
exec @output=client_login
@client_id = @client_id,
@password = @password;
if(@output = 0)
Begin
	Return 0
End
Else
Begin
	if(@Fname is not null) 
	Begin
		Update client
		Set Fname = @Fname 
		Where client_id = @client_id
	End
	if(@Lname is not null) 
	Begin
		Update client
		Set Lname = @Lname 
		Where client_id = @client_id
	end
	if(@gender is not null) 
	Begin
		Update client
		Set gender = @gender 
		Where client_id = @client_id
	End
	if(@guestAddress is not null) 
	Begin
		Update client
		Set guestAddress = @guestAddress
		Where client_id = @client_id
	End
if(@cnic is not null) 
	Begin
		Update client
		Set cnic = @cnic
		Where client_id = @client_id
	End
	if(@phone is not null) 
	Begin
		Update client
		Set phone = @phone
		Where client_id = @client_id
	End
	if(@phone is not null) 
	Begin
		Update client
		Set phone = @phone
		Where client_id = @client_id
	End
	if(@email is not null) 
	Begin
		Update client
		Set email = @email
		Where client_id = @client_id
	End
	if(@new_password is not null) 
	Begin
		Update client
		Set password = @new_password
		Where client_id = @client_id
	End

	Return 1 
end
End;


--For Owner
Create procedure updateOwner
@owner_id int not null,
@Fname varchar(20) = null,
@Lname varchar(20) = null,
@gender char = null,
@cnic varchar(20) null,
@owner_address varchar(50) null, 
@phone varchar(20) = null,
@password varchar(20) not null,
@new_password

AS
Begin
Declare @output bit
exec @output= owner_login
@owner_id = @owner_id,
@password = @password;
if(@output = 0)
Begin
	Return 0
End
Else
Begin
	if(@Fname is not null) 
	Begin
		Update table [owner]
		Set Fname = @Fname 
		Where owner_id = @owner_id
	End
	if(@Lname is not null) 
	Begin
		Update table [owner]
		Set Lname = @Lname 
		Where owner_id = @owner_id
	end
	if(@gender is not null) 
	Begin
		Update table [owner]
		Set gender = @gender 
		Where owner_id = @owner_id
	End
	if(@owner_address is not null) 
	Begin
		Update table [owner]
		Set owner_address = @owner_address
		Where owner_id = @owner_id
	End
if(@cnic is not null) 
	Begin
		Update table [owner]
		Set cnic = @cnic
		Where owner_id = @owner_id
	End
	if(@phone is not null) 
	Begin
		Update table [owner]
		Set phone = @phone
		Where owner_id= @owner_id
	End
	if(@phone is not null) 
	Begin
		Update table [owner]
		Set phone = @phone
		Where owner_id= @owner_id
	End
	if(@email is not null) 
	Begin
		Update table [owner]
		Set email = @email
		Where owner_id = @owner_id
	End
	if(@new_password is not null) 
	Begin
		Update table client
		Set password = @new_password
		Where owner_id = @owner_id
	End

	Return 1 
end
end;

--1.4
create procedure Reversation
@client_id int,
@start_date date,
@end_date date,
@city varchar(20)
as
begin
	print 'Available hotels are /n'
	select * from hotel
	where city = @city 
end;

--1.10
create procedure top_rated_hotels 
as
begin
select * from hotel 
order by rating desc
end;

--1.12
create procedure delete_client
@client_id int,
@password varchar(20)
AS 
Begin
	Declare @output bit
	exec @output= client_login
	@client_id = @client_id,
	@password = @password
	if(@output = 1)
	begin
		delete from client where client_id = @client_id
		print'Deleted Successfully'
		return 1
	end
	else
	begin
		print 'Either password or client id is incorrect'
		return 0
	end
End;

create procedure delete_owner
@owner_id int,
@password varchar(20)
AS 
Begin
	Declare @output bit
	exec @output= owner_login
	@owner_id = @owner_id,
	@password = @password
	if(@output = 1)
	begin
		delete from [owner] where owner_id = @owner_id
		print'Deleted Successfully'
		return 1
	end
	else
	begin
		print 'Either password or owner id is incorrect'
		return 0
	end
End;
select * from [owner];

declare @out bit
exec @out = delete_owner 
@owner_id = 1,
@password = 'Youtubechain'
select @out;

--1.9
create table feedback
(
	cust_id int foreign key references client(client_id),
	hotel_id int foreign key references hotel(hotel_id),
	rating decimal(5, 2),
	[text] varchar(100),
	primary key(cust_id, hotel_id) 
);

create procedure giveFeedback
@cust_id int,
@hotel_id int,
@rating decimal(5, 2),
@text varchar(100)
as
begin
	if(not exists(select * from client where Client_id = @cust_id))
	begin
		print 'No such customer exists'
		return 0
	end
	if(not exists(select * from hotel where hotel_id = @hotel_id))
	begin
		print 'No such hotel exists'
		return 0
	end
	if(exists(select * from feedback 
	          where @cust_id = cust_id and @hotel_id = hotel_id))
	begin
		update feedback 
		set rating = @rating, [text] = @text
		where @cust_id = cust_id and @hotel_id = hotel_id
	end
	else
	begin
		insert into feedback values(@cust_id, @hotel_id, @rating, @text)
	end
	return 1
end;

