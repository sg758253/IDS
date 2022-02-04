use mytestdb;
--projection
SELECT * FROM mytestdb.USArrests;
-- disable secure update
SET SQL_SAFE_UPDATES = 0;

--update missing values
update mytestdb.USArrests set Assault=(select avg(Assault) from USArrests) where State='Georgia';

-- selection
SELECT * FROM mytestdb.USArrests;

--min, max, avg, var
select min(Murder) as murder_min, max(Murder) as murder_max, avg(Murder) as murder_avg, variance(Murder) as murder_var, 
min(Assault) as Assault_min, max(Assault) as Assault_max, avg(Assault) as Assault_avg, variance(Assault) as Assault_var,
min(UrbanPop) as UrbanPop_min, max(UrbanPop) as UrbanPop_max, avg(UrbanPop) as UrbanPop_avg,variance(UrbanPop)as UrbanPop_var from USArrests;

--Which state has the maximum murder rate?
select * from USArrests where murder=(select max(murder) from USArrests);

-- List of states in ascending order of urban population percentages.
select state,UrbanPop from USArrests order by UrbanPop asc;

--How many states have higher murder rates than Arizona? List those states.
select state from USArrests where murder>(select murder from USArrests where State='Arizona');

