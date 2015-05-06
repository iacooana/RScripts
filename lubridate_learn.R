this_day<-today() #"2015-04-21"
year(this_day)
month(this_day)
day(this_day)
wday(this_day)
wday(this_day, label=TRUE)

this_moment<-now() #"2015-04-21 14:36:11 MSK"
hour(this_moment)
minute(this_moment)
second(this_moment)

my_date<-ymd("1989-05-17")
class(my_date) = "POSIXct" "POSIXt" (from character string)

update(this_moment, hours = 8, minutes = 34, seconds = 55)

nyc<-now("America/New_York")
depart<-nyc + days(2)
arrive <- depart + hours(15) + minutes(50)

arrive<-with_tz(arrive, tzone="Asia/Hong_Kong")

last_time<-mdy("June 17, 2008", tz="Singapore")

how_long <- new_interval(last_time, arrive)
as.period(how_long)





