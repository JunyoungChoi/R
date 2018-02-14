library(ggplot2)
library(ggmap)
jeju<-read.csv("力林档咯青内胶_1老瞒.csv",header=T)
jeju
jeju1<-get_map("Hallasan",zoom=10,maptype="hybrid")
jeju.map<-ggmap(jeju1)+geom_point(data=jeju,aes(x=LON,y=LAT),size=3,alpha=0.7,col='red')
jeju.map+geom_path(data=jeju,aes(x=LON,y=LAT),size=1,linetype=3,col='blue')+geom_text(data=jeju,aes(x=LON,y=LAT+0.01,label=厘家),size=3)
ggsave("jeju_1.png",dpi=700)
