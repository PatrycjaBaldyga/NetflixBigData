create database if not exists netflix;
use netflix;

CREATE EXTERNAL TABLE IF NOT EXISTS titles_ext (
id INT,
production_year INT,
title STRING)
COMMENT 'movie titles'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
location '/user/baldygawsb/input/datasource4';

CREATE EXTERNAL TABLE IF NOT EXISTS ratings_ext (
movie_id INT,
sum_ratings INT,
votes INT)
COMMENT 'prize data ratings'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
location '/user/baldygawsb/output_mr3';

CREATE EXTERNAL TABLE IF NOT EXISTS json_table_ext (
production_year INT,
title STRING,
avg_rating DECIMAL(12, 5))
COMMENT 'json output table'
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.JsonSerDe'
STORED AS TEXTFILE
location '/user/baldygawsb/output6';

insert into json_table_ext
select production_year, title, avg_rating
from (select titles_ext.production_year, titles_ext.title, 
(ratings_ext.sum_ratings/ratings_ext.votes) as avg_rating, 
rank() over (partition by titles_ext.production_year 
order by (ratings_ext.sum_ratings/ratings_ext.votes) desc) as rank
from ratings_ext
join titles_ext on titles_ext.id = ratings_ext.movie_id
where ratings_ext.votes > 1000
) rnk
where rank <= 3;