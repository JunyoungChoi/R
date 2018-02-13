## vector 보고서

## 1번문제
date4 <- seq(from=as.Date('2015-01-01'),to=as.Date('2015-01-31'),by='day')
date4

## 2번문제
vec <- c('사과','배','감','버섯','고구마')
vec[-3]

## 3번 문제
vec1 <-c('봄','여름','가을','겨울')
vec2 <-c('봄','여름','늦여름','초가을')
c(vec1,vec2)
setdiff(vec1,vec2)
union(vec1,vec2)

## 보고서 1
v1=seq(1,10,by=1)
v1[1:5]
v1[3:7]
v1[-1:-5]
v1[-3:-7]
v1[3]=0
v1[6]=0
v1
v1[9]='0'
class(v1)
as.numeric(v1)
v1[0]='numeric'

## 보고서 2
append(v1,0,after=0)
v1<-append(v1,11,after=11)
v1
v1<-append(v1,c(seq(14,20,by=1)))
v1
v1<-append(v1,c(12,13),after=11)
v1
v2<-100
v1+v2
v2<-c(100,200,300)
v1+v2


## 보고서 3
union(v1,v2)
setdiff(v1,v2)
setdiff(v2,v1)
names(v2)<-c('A','B','C')
v2
v3<-seq(5,50,by=5)
v3
v4<-c(5,6,5,6,5,6)
v5<-c(-1,-1,-1,0,0,0,1,1,1)
length(v5)
15 %in% v3
vv<- 55 %in% v3
vv

## matrix 보고서
seasons<-matrix(c('봄','여름','가을','겨울'),nrow=2)
seasons
seasons<-matrix(c('봄','여름','가을','겨울'),nrow=2,byrow=T)
seasons
seasons[,2]
seasons<-rbind(seasons,c('초봄','초가을'))
seasons
seasons<-cbind(seasons,c('초여름','초겨울','한겨울'))
seasons

##보고서 1
m<-matrix(c(1,2,3,4,5,6,7,8),nrow=4)
m
m[,1]
m[2,]
colnames(m)<-c('A','B')
m
mm<-cbind(m,c(9,10,11,12))
mm

##보고서 2
n<-matrix(c(1,2,3,4,5,6,7,8),nrow=2,byrow=T)
n[1,]
n[,4]
nn<-rbind(n,c(9,10,11,12))
nn
colnames(n)<-c('A','B','C','D')
n
matrix(c('J','A','V','A','C','A','F','E'),nrow=2,byrow=T)


## 배열 보고서
## 보고서 1
arr2 <- array(c('O','R','A','C','L','E','S','E','R','V','E','R'),dim=c(2,6))
arr2
arr2[1,3]
arr3 <- array(c(seq(15,90,by=5)),dim=c(2,4,2))
arr3
arr3[,,2]

## list 보고서
##보고서 1
s <-list('ko'=90,'ma'=100,'en'=98)
s$sc<-100
s$en
s[2:3]
s$en<-95
s
mean(c(s$ko,s$ma,s$en,s$sc))
s$sc<-NULL
