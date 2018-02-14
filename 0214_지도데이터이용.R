install.packages("ggmap")
install.packages("stringr")

library(ggmap)
library(stringr)
loc<-read.csv("서울_강동구_공영주차장_위경도.csv",header=T)  ## csv파일 불러옴
loc

## 강동구 주차장 데이터 지도에 표시
kd<-get_map("Amsa-dong",zoom=13,maptype="roadmap") ## 지도 얻어옴  (url형태로)
kd
kor.map<-ggmap(kd) + geom_point(data=loc,aes(x=LON,y=LAT),size=3,alpha=0.7,color="red")  ## geom.point를 이용해 점을 찍어줌 alpha는 점의 투명도 설정
kor.map + geom_text(data=loc,aes(x=LON,y=LAT+0.001,label=주차장명),size=3)  ## geom_text로 지도에 글씨를 써줌
ggsave("kd.png",dpi=500) ## plot에 있는 그림을 저장

## 구는 빨간색, 시는 파란색 점으로 출력하기
loc2<-str_sub(loc$주차장명,start=-2,end=-2)
loc2
colors<-c()
for(i in 1:length(loc2)){
  if(loc2[i]=='구'){
    colors<-c(colors,"red")}
  else{
    colors<-c(colors,"blue")
  }
}
colors
kd<-get_map("Amsa-dong",zoom=13,maptype="roadmap") ## 지도 얻어옴  (url형태로)
kor.map<-ggmap(kd) + geom_point(data=loc,aes(x=LON,y=LAT),size=3,alpha=0.7,color=colors)
kor.map + geom_text(data=loc,aes(x=LON,y=LAT+0.001,label=주차장명),size=3)


## 학교 지도에 표시하기
school<-get_map("kwangwoon University",zoom=13,maptype="roadmap") ## 지도 얻어옴  (url형태로)  앞에는 검색어를 입력 영어로 해야하는듯...
school.map<-ggmap(school)+geom_point(aes(x=127.058911,y=37.619530),size=3,alpha=0.7,color="red")
school.map+geom_text(aes(x=127.058911,y=37.620530,label="광운대학교"),size=3)

