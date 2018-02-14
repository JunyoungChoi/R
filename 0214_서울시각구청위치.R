library(ggmap)
library(grid)
pop<-read.csv("서울시구청위치정보_new.csv",header=T)
pop
lon<-pop$LON
lat<-pop$LAT
data<-pop$name
df<-data.frame(lon,lat,data)
df

kd<-get_map(location=c(lon=126.981302,lat=37.565562),zoom=11,maptype="roadmap") ## 지도 얻어옴  (url형태로)
kd
kor.map<-ggmap(kd) + geom_point(data=pop,aes(x=LON,y=LAT),size=4,alpha=0.7,color='green')
kor.map + geom_text(data=pop,aes(x=LON,y=LAT+0.001,label=name),size=3)
