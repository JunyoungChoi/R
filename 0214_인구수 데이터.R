library(ggmap)
library(grid)
pop<-read.csv("지역별인구현황_2014_4월기준.csv",header=T)
pop
lon<-pop$LON
lat<-pop$LAT
data<-pop$총인구수
df<-data.frame(lon,lat,data)
df

## 맵의 여러가지 형태
## 1
map1<-get_map("Jeonju",zoom=7,maptype='roadmap')
map1<-ggmap(map1)
map1+geom_point(aes(x=lon,y=lat,colour=data,size=data),data=df)
ggsave("pop.png",scale=1,width=7,height=4,dpi=1000)

## 2
map2<-get_map("Jeonju",zoom=7,maptype='terrain')
map2<-ggmap(map2)
map2+geom_point(aes(x=lon,y=lat,colour=data,size=data),data=df)
ggsave("pop2.png",scale=1,width=7,height=4,dpi=1000)

## 3
map3<-get_map("Jeonju",zoom=7,maptype='satellite')
map3<-ggmap(map3)
map3+geom_point(aes(x=lon,y=lat,colour=data,size=data),data=df)
ggsave("pop3.png",scale=1,width=7,height=4,dpi=1000)

## 4
map4<-get_map("Jeonju",zoom=7,maptype='hybrid')
map4<-ggmap(map4)
map4+geom_point(aes(x=lon,y=lat,colour=data,size=data),data=df)
ggsave("pop4.png",scale=1,width=7,height=4,dpi=700)
