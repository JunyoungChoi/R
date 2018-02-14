## 보고서1
y<-c(3,4,5,6,7)
plot(y)

y<-c(3,3,4,4)
plot(y)

x<-c(3,3,3)
y<-c(2,3,4)
plot(x,y)

x<-c(seq(10,90,by=10))
y<-c(seq(10,2,by=-1))
plot(x,y)

x<-c(2,4,6,8)
y<-c(16,17,19,18)
plot(x,y,xlim=c(0,10),ylim=c(15,20),ylab="yyy",xlab="xxx")


x<-c(12:18)
y<-c(30,31,33,32,28,27,30)
plot(x,y,xlim=c(10,20),ylim=c(26,34),ylab="최고 기온",xlab="7월의 날짜(일)",main="일주일간 최고 기온변화")

x<-c(1,2,2)
y<-c(99,98,100)
plot(x,y,xlim=c(0,3),ylim=c(95,100))

df1<-data.frame(matrix(c(1,'apple',100,2,'banana',200,3,'peach',300),nrow=3,byrow=T))
names(df1)<-c('NO','NAME','PRICE')
df1

df2<-data.frame(matrix(c(10,'train',1000,20,'car',2000,30,'airplane',3000),nrow=3,byrow=T))
names(df2)<-c('NO','NAME','PRICE')
df2


s<-data.frame(matrix(c('김길동',100,90,80,'강길동',90,95,98,'박길동',85,98,100),nrow=3,byrow=T))
names(s)<-c('name','kor','mat','eng')
names(s)
length(s)
s[,c(1,2)]
s[,c(1,3)]
s$name
subset(s,kor>=90)
subset(s,name=='박길동')
s<-data.frame(matrix(c('김길동',100,90,80,'강길동',90,95,98,'박길동',85,98,100,'최길동',80,90,93),nrow=4,byrow=T))
names(s)<-c('name','kor','mat','eng')
s

t<-data.frame(matrix(c('강길동',100,90,'박길동',90,95,'최길동',92,100),byrow=T,nrow=3))
names(t)<-c('name','kor','mat')
t<-data.frame(matrix(c('강길동',100,90,'박길동',90,95,'최길동',92,100,'sci',88,80,94),byrow=T,nrow=4))
names(t)<-c('name','kor','mat')
t
length(t$names)
