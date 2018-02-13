library(googleVis)
data<-read.csv("2013년_서울_구별_주요과목별병원현황_구글용.csv",header=T)
data
hos<-gvisColumnChart(data,options=list(title="지역별 병원현황",height=400,weight=500))
plot(hos)
