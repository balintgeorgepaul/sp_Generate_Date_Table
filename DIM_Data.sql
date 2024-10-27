  
--	exec sp_DIM_Date  
-- select * from dim_data

  
alter procedure [dbo].[sp_DIM_Date]  
as  
begin  
  

	if exists (select * from sys.tables where name = 'DIM_Data')
	begin
		drop table dbo.DIM_Data;
	end
  
 create table dbo.DIM_Data (  
  id int identity(1,1) primary key,  
  an int,  
  [quarter] nvarchar(5),  
  luna int,  
  saptamana int,  
  zi int,  
  nume_zi nvarchar(15),
  [data] date
  );  
  
	
	set datefirst 1;

    declare @data date = '1998-01-01';  
    declare @final date = '2030-12-31';  
  
    while @data <= @final  
    begin  
        insert into dbo.DIM_Data (an, [quarter], luna, saptamana, zi, nume_zi,[data])  
        values (  
            year(@data),  
            concat('q',datepart(quarter, @data)),  
            month(@data),  
            datepart(week, @data),  
            day(@data),
			format(@data,'dddd', 'ro-ro'),
			@data

        );  
  
        set @data = dateadd(day, 1, @data);  
    end 
end;  
  



  