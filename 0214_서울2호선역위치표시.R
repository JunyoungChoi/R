library(ggmap)
library(grid)
pop<-read.csv("서울지하철2호선위경도정보.csv",header=T)
pop
lon<-pop$LON
lat<-pop$LAT
data<-pop$역명
df<-data.frame(lon,lat,data)
df
pop1<-read.csv("서울지하철3호선역위경도정보.csv",header=T)
lon1<-pop$LON
lat1<-pop$LAT
data1<-pop$역명
df1<-data.frame(lon1,lat1,data1)
df1
kd<-get_map(location=c(lon=126.981302,lat=37.565562),zoom=11,maptype="roadmap") ## 지도 얻어옴  (url형태로)
kd
kor.map<-ggmap(kd)+ geom_point(data=pop,aes(x=LON,y=LAT),size=1,alpha=1,color='black')
kor.map
kor.map + geom_text(data=pop,aes(x=LON,y=LAT+0.001,label=data),size=3)
kor.map<-kor.map + geom_point(data=pop1,aes(x=LON,y=LAT),size=1,alpha=1,color='green')
kor.map + geom_text(data=pop1,aes(x=LON,y=LAT+0.001,label=data1),size=3)

