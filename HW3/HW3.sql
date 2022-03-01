CREATE TABLE `Life_Expectancy` (
  `Country` text DEFAULT NULL,
  `Year` int(11) DEFAULT NULL,
  `Life_Expectancy` double DEFAULT NULL,
  `Adult_Mortality` int(11) DEFAULT NULL,
  `Alcohol` double DEFAULT NULL,
  `Percentage_Expenditure` double DEFAULT NULL,
  `BMI` double DEFAULT NULL,
  `Total_Expenditure` double DEFAULT NULL,
  `GDP` double DEFAULT NULL,
  `Population` int(11) DEFAULT NULL,
  `Schooling` double DEFAULT NULL
);

desc Life_Expectancy;
select * from Life_Expectancy;
select count(*) from Life_Expectancy;

delete from Life_Expectancy where population=0;
select count(*) from Life_Expectancy;
--further cleaning
select count(*) from Life_Expectancy where  (alcohol=0 or Percentage_expenditure=0);
delete from Life_Expectancy where (alcohol=0 or Percentage_expenditure=0);	
select count(*) from Life_Expectancy ;

select Country,max(Adult_Mortality),min(Adult_Mortality), avg(Adult_Mortality) from Life_Expectancy
group by Country
order by avg(Adult_Mortality) desc;

-- to check avaiable year.
select distinct(year) from Life_Expectancy;

-- As available year is 2010-2015,so no need to to add where clause for year 

-- List of countries with the highest and lowest average mortality rates (years 2010-2015)
select Country,max(Adult_Mortality),min(Adult_Mortality), avg(Adult_Mortality) from Life_Expectancy
group by Country
order by avg(Adult_Mortality);

select Country,max(Adult_Mortality),min(Adult_Mortality), avg(Adult_Mortality) from Life_Expectancy
group by Country
order by avg(Adult_Mortality);

-- List of countries with the highest and lowest average population (years 2010-2015)
select Country,max(population),min(population), avg(population) from Life_Expectancy
group by Country
order by avg(population) desc;

select Country,max(population),min(population), avg(population) from Life_Expectancy
group by Country
order by avg(population);

-- List of countries with the highest and lowest average GDP (years 2010-2015)
select Country,max(GDP),min(GDP), avg(GDP) from Life_Expectancy
group by Country
order by avg(GDP) desc;

select Country,max(GDP),min(GDP), avg(GDP) from Life_Expectancy
group by Country
order by avg(GDP);


-- List of countries with the highest and lowest average Schooling  (years 2010-2015)
select Country,max(schooling),min(schooling), avg(schooling) from Life_Expectancy
group by Country
order by avg(schooling) desc;

select Country,max(schooling),min(schooling), avg(schooling) from Life_Expectancy
group by Country
order by avg(schooling);

-- Which countries have the highest and lowest average alcohol consumption (years 2010-2015)?
select Country, avg(Alcohol) from Life_Expectancy 
group by Country order by avg(Alcohol) desc limit 1;



-- Do densely populated countries tend to have lower life expectancy?
select Country, Population, Life_Expectancy from Life_Expectancy
order by Population desc;


