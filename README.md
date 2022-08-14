# NetflixBigData

The project aims to use primary data processing platforms based on the Hadoop platform to process two interrelated data sets.

A bash script was prepared to launch the project, which consists of two parts.
In the first part, MapReduce processing in the classic variant (Java) is used to process the first data set by filtering and aggregating it.
In the second part, the Hive platform is used to process the result from the first part of the project and the second data set by combining this data, further aggregating, sorting and filtering to get the final results.

The primary source of the data is https://www.kaggle.com/netflix-inc/netflix-prize-data

Two data sets
1. netflix-prize-data.zip – movie ratings
2. movie_titles.csv – movies

MapReduce:

Based on the netflix-prize-data data set, the number of votes and the sum of ratings is determined for each film.
The resulting set includes the following attributes: movie ID, number of votes for the movie, a sum of ratings for the movie.

Hive Script:

Based on the result of the MapReduce job  and the movie_titles.csv data set, for each year of movie production, three best-rated movies (with the highest average rating) are determined. Only movies which have more than 1000 votes are considered.

The final result contains the following attributes: movie title, year of movie production, average rating of the movie.

The project was run in the Google Cloud Platform using Dataproc.
