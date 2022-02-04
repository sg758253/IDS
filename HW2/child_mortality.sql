--createtable
create table child_mortality(
	Years int(4),
	Under_ﬁve_mortality_rate double,
	Infant_mortality_rate double,
	Neonatal_mortality_rate double
);

-- describe table
desc child_mortality;

-- projection
select * from child_mortality;	# 27 records


-- get median value 
SET @rowindex := -1;
 
SELECT
   AVG(d.Under_ﬁve_mortality_rate) as Median 
FROM
   (SELECT @rowindex:=@rowindex + 1 AS rowindex,
           child_mortality.Under_ﬁve_mortality_rate AS Under_ﬁve_mortality_rate
    FROM child_mortality
    ORDER BY child_mortality.Under_ﬁve_mortality_rate) AS d
WHERE
d.rowindex IN (FLOOR(@rowindex / 2), CEIL(@rowindex / 2));


-- update Median value in Under_ﬁve_mortality_rate

SET @rowindex := -1;
update child_mortality set Under_ﬁve_mortality_rate=(
	SELECT
	   AVG(d.Under_ﬁve_mortality_rate) as Median 
	FROM
	   (SELECT @rowindex:=@rowindex + 1 AS rowindex,
			   child_mortality.Under_ﬁve_mortality_rate AS Under_ﬁve_mortality_rate
		FROM child_mortality
		ORDER BY child_mortality.Under_ﬁve_mortality_rate) AS d
	WHERE
	d.rowindex IN (FLOOR(@rowindex / 2), CEIL(@rowindex / 2))
) where Under_ﬁve_mortality_rate=0;

-- update Median value in infant_mortality_rate
SET @rowindex := -1;
update child_mortality set infant_mortality_rate=(
	SELECT
	   AVG(d.infant_mortality_rate) as Median 
	FROM
	   (SELECT @rowindex:=@rowindex + 1 AS rowindex,
			   child_mortality.infant_mortality_rate AS infant_mortality_rate
		FROM child_mortality
		ORDER BY child_mortality.infant_mortality_rate) AS d
	WHERE
	d.rowindex IN (FLOOR(@rowindex / 2), CEIL(@rowindex / 2))
) where infant_mortality_rate=0;

-- update Median value in neonatal_mortality_rate

SET @rowindex := -1;
update child_mortality set neonatal_mortality_rate=(
	SELECT
	   AVG(d.neonatal_mortality_rate) as Median 
	FROM
	   (SELECT @rowindex:=@rowindex + 1 AS rowindex,
			   child_mortality.neonatal_mortality_rate AS neonatal_mortality_rate
		FROM child_mortality
		ORDER BY child_mortality.neonatal_mortality_rate) AS d
	WHERE
	d.rowindex IN (FLOOR(@rowindex / 2), CEIL(@rowindex / 2))
) where neonatal_mortality_rate=0;

-- get min, max, avg var
select min(Under_ﬁve_mortality_rate) as UnderFive_min, max(Under_ﬁve_mortality_rate) as UnderFive_max, avg(Under_ﬁve_mortality_rate) as UnderFive_avg, variance(Under_ﬁve_mortality_rate) as UnderFive_var, 
min(Infant_mortality_rate) as Infant_min, max(Infant_mortality_rate) as Infant_max, avg(Infant_mortality_rate) as Infant_avg, variance(Infant_mortality_rate) as Infant_var,
min(Neonatal_mortality_rate) as Neonatal_min, max(Neonatal_mortality_rate) as Neonatal_max, avg(Neonatal_mortality_rate) as Neonatal_avg,variance(Neonatal_mortality_rate)as Neonatal_var from child_mortality;

-- Display the sorted infant mortality rates in descending order.
select * from child_mortality order by Infant_mortality_rate desc;

-- In what years the neonatal mortality rates were above average?
select * from child_mortality where Neonatal_mortality_rate>(select avg(Neonatal_mortality_rate) from child_mortality);

-- Which years have the lowest and highest infant mortality years, respectively?
Sql: select years from child_mortality where Infant_mortality_rate=(select min(Infant_mortality_rate) from child_mortality);
select years from child_mortality where Infant_mortality_rate=(select max(Infant_mortality_rate) from child_mortality);

--Add a new column called Above-Five Mortality Rate
alter table child_mortality add column Above_Five_Mortality_Rate double;

-- Populate Above-Five Mortality Rate with appropriate values.
Sql: update child_mortality set above_five_mortality_rate=format((Under_ﬁve_mortality_rate+Infant_mortality_rate+Neonatal_mortality_rate)/3,2);

