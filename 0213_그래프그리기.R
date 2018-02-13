var1 <- c(10,13,14,15,16)
plot(var1)


plot.new()  ## 지금까지 있던 plot 정리해줌
dev.new() ## zoom 창을 띄워줌


x<-1:3
y<-3:1
plot(x,y,xlim=c(1,10),ylim=c(-1,10))

plot(x,y,xlim=c(1,10),ylim=c(1,5),xlab="X축 값",ylab="Y축 값",main="Plot Test")

v1<-c(100,130,120,160,150)
plot(v1,type='o',col='red',ylim=c(0,200),axes=FALSE,ann=FALSE) ## 축값들 그리지 않고 그래프만 그리기  ## type으로 그래프모양 선택
axis(1,at=1:5,lab=c("Mon","Tue",'Wed','Thu','Fri'))   ## 첫번째 1은 x축을 의미함
axis(2,ylim=c(0,200))  ## 2는 y축을 의미, y축을 0~200까지만 설정

title(main="FRUIT",col.main="red",font.main=4)  ## 메인 제목 삽입
title(xlab="DAY",col.lab="black")  ## x축 제목 삽임
title(ylab="PRICE",col.lab="blue")  ## y축 제목 삽입


## 그래프 배치 조정하기 (mfrow)
## par(mfrow=c(nr,nc))  nr은 행의 갯수, nc는 열의갯수

## 서로 다른 모양의 그래프
v1
par(mfrow=c(1,3))  ## 한페이지에 그래프 몇개넣을지
plot(v1,type="o")
plot(v1,type="s")
plot(v1,type="l")


## 서로 다른 유형의 그래프
v1
par(mfrow=c(1,3))
pie(v1)
plot(v1,type='o')
barplot(v1)

data1<-read.csv("2013년_서울_주요구별_병원현황.csv",header=T) ## header=T가 첫번째 줄을 데이터가 아닌 제목으로 읽게해줌
data1

barplot(as.matrix(data1[1:9,2:11]),main=paste("서울시 주요 구별 과목별 병원현황-2013년","\n","출처[국민건강보험공단]"),ylab="병원수",beside=T,col=rainbow(8),ylim=c(0,350))
abline(h=seq(0,350,10),lty=3,lwd=0.2)
name<-data1$표시과목
name
legend(75,350,name,cex=0.8,fill=rainbow(8),bg="white")
savePlot("hospital.png",type="png") ## 이미지저장을 시켜줌

## 분할해서 그래프 출력하기
v1<-data1[1:9,2]*0.1
v2<-data1[1:9,3]*0.1
v3<-data1[1:9,4]*0.1
v4<-data1[1:9,5]*0.1
v5<-data1[1:9,6]*0.1
v6<-data1[1:9,7]*0.1
v7<-data1[1:9,8]*0.1
v8<-data1[1:9,9]*0.1
v9<-data1[1:9,10]*0.1
v10<-data1[1:9,11]*0.1

par(mfrow=c(2,5))
name<-data1$표시과목
name

barplot(as.matrix(v1))
gangnam<-barplot(as.matrix(v1),main="강남구 병원현황",beside=T,axes=F,ylab="병원수(단위:10개)",xlab="",cex.names=0.85,las=2,ylim=c(0,40),col=rainbow(8),border="white",names.arg=name)
axis(2,ylim=seq(0,35,10))
abline(h=seq(0,35,5),lty=2)
gangdong<-barplot(as.matrix(v2),main="강동구 병원현황",beside=T,axes=F,ylab="병원수(단위:10개)",xlab="",cex.names=0.85,las=2,ylim=c(0,40),col=rainbow(8),border="white",names.arg=name)
axis(2,ylim=seq(0,35,10))
abline(h=seq(0,35,5),lty=2)
gangseo<-barplot(as.matrix(v3),main="강서구 병원현황",beside=T,axes=F,ylab="병원수(단위:10개)",xlab="",cex.names=0.85,las=2,ylim=c(0,40),col=rainbow(8),border="white",names.arg=name)
axis(2,ylim=seq(0,35,10))
abline(h=seq(0,35,5),lty=2)
gwanak<-barplot(as.matrix(v4),main="관악구 병원현황",beside=T,axes=F,ylab="병원수(단위:10개)",xlab="",cex.names=0.85,las=2,ylim=c(0,40),col=rainbow(8),border="white",names.arg=name)
axis(2,ylim=seq(0,35,10))
abline(h=seq(0,35,5),lty=2)
guro<-barplot(as.matrix(v5),main="구로구 병원현황",beside=T,axes=F,ylab="병원수(단위:10개)",xlab="",cex.names=0.85,las=2,ylim=c(0,40),col=rainbow(8),border="white",names.arg=name)
axis(2,ylim=seq(0,35,10))
abline(h=seq(0,35,5),lty=2)
dobong<-barplot(as.matrix(v6),main="도봉구 병원현황",beside=T,axes=F,ylab="병원수(단위:10개)",xlab="",cex.names=0.85,las=2,ylim=c(0,40),col=rainbow(8),border="white",names.arg=name)
axis(2,ylim=seq(0,35,10))
abline(h=seq(0,35,5),lty=2)
dongdaemun<-barplot(as.matrix(v7),main="동대문구 병원현황",beside=T,axes=F,ylab="병원수(단위:10개)",xlab="",cex.names=0.85,las=2,ylim=c(0,40),col=rainbow(8),border="white",names.arg=name)
axis(2,ylim=seq(0,35,10))
abline(h=seq(0,35,5),lty=2)
dongjak<-barplot(as.matrix(v8),main="동작구 병원현황",beside=T,axes=F,ylab="병원수(단위:10개)",xlab="",cex.names=0.85,las=2,ylim=c(0,40),col=rainbow(8),border="white",names.arg=name)
axis(2,ylim=seq(0,35,10))
abline(h=seq(0,35,5),lty=2)
mapo<-barplot(as.matrix(v9),main="마포구 병원현황",beside=T,axes=F,ylab="병원수(단위:10개)",xlab="",cex.names=0.85,las=2,ylim=c(0,40),col=rainbow(8),border="white",names.arg=name)
axis(2,ylim=seq(0,35,10))
abline(h=seq(0,35,5),lty=2)
seodaemun<-barplot(as.matrix(v10),main="서대문구 병원현황",beside=T,axes=F,ylab="병원수(단위:10개)",xlab="",cex.names=0.85,las=2,ylim=c(0,40),col=rainbow(8),border="white",names.arg=name)
axis(2,ylim=seq(0,35,10))
abline(h=seq(0,35,5),lty=2)
dev.new()
