library(ggmap)
library(grid)
par(mfrow=c(1,2))
pop<-read.csv("관광지도만들기.csv",header=T)
pop
lon<-pop$LON
lat<-pop$LAT
data<-pop$name
df<-data.frame(lon,lat,data)
df
kd<-get_map(location=c(lon=126.981302,lat=37.565562),zoom=11,maptype="roadmap") ## 지도 얻어옴  (url형태로)
j_map<-ggmap(kd)+geom_point(data=pop,aes(x=LON,y=LAT),size=3,alpha=0.7,col='black')
j_map+geom_path(data=pop,aes(x=LON,y=LAT),size=1,linetype=1,col='blue')+geom_text(data=pop,aes(x=LON,y=LAT+0.01,label=name),size=3)

pop2<-read.csv("관광지도만들기2.csv",header=T)
pop2
lon2<-pop$LON
lat2<-pop$LAT
data2<-pop$name
df2<-data.frame(lon2,lat2,data2)
df2
j_map2<-ggmap(kd)+geom_point(data=pop2,aes(x=LON,y=LAT),size=3,alpha=0.7,col='black')
j_map2+geom_path(data=pop2,aes(x=LON,y=LAT),size=1,linetype=1,col='blue')+geom_text(data=pop2,aes(x=LON,y=LAT+0.01,label=name),size=3)
