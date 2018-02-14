list.files()  ## 파일 보여줌
list.files(recursive=T)  ## 하위 폴더에 존재하는 파일까지 보여줌
list.files(all.files=T)  ## 숨김파일까지 보여줌
library(googleVis)

## scan
scan1<-scan('scan_1.txt')  ## 파일에 있는 데이터를 배열형으로 가져옴  
scan1[1]

scan2<-scan("scan_2.txt",what="") ## 문자로 가져옴  what이 없으면 기본적으로 숫자로 가져옴

input<-scan()  ## scanf와 동일함 숫자입력받기
input<-scan(what="")  ## scanf와 동일 문자입력받기
input<-readline()  ## 문자열로 받을 수 있음
input<-readline("Are you OK? : ") ## 파이썬 input()과 동일 질문을 할 수 있음

## read.table 
## 데이터 테이블형식으로 불려들어옴
fruits<-read.table('fruits.txt')  ## 주석 자동 제외 
fruits
fruits<-read.table('fruits.txt',header=T)  ## 첫줄은 제목으로 들어감
fruits
fruits<-read.table('fruits_2.txt',skip=2) ## 건너뛸 줄 수를 지정 ( 2줄 이후부터 불러옴 (주석포함))
fruits
fruits<-read.table('fruits_2.txt',nrows=2)  ## 2줄만 가져옴 ( 주석제외)
fruits

fruits<-read.csv('fruits_3.csv')  ## csv 형식파일 불러오기 제일 위는 알아서 헤더가 된다
fruits
fruits<-read.csv('fruits_4.csv')  ## 헤더가 안만들어져있기 때문에 데이터가 헤더로 들어가서 오류가난다.
fruits
fruits<-read.csv('fruits_4.csv',header=F) ## 헤더가 없다고 표시해줘서 데이터가 헤더로 들어가지 않도록 해줌
fruits

label<-c("NO","NAME","PRICE","QTY")
fruits<-read.csv('fruits_4.csv',header=F,col.names=label)  ## 헤더를 없는 형식으로 불러오면서 헤더를 대입해줄 수 있다.
fruits
fruits<-read.csv("fruits_4.csv",header=F,col.names=label,stringsAsFactors=F) ## 불러올 때 factor 형식이 아닌 char형으로 불러와줌
class(fruits$NAME)

## write
library(sqldf)
write.csv(fruits,file='f.csv') ## csv 형식으로 파일을 저장해줌
write.csv(Fruits,"Fruits_sql.csv",quote=F,row.names=F)
fruits_2<-read.csv.sql("Fruits_sql.csv",sql="SELECT * FROM file WHERE Location = 'West'") ## SELECT 뒤에 보고싶은 라벨이름을 넣음(*은 전부다 , 여러개 보고 싶을때는 , 로 이어줌) 그리고 WHERE 뒤에는 원하는 조건값을 넣음
fruits_2

library(readxl)
df_exam<-read_excel("excel_exam.xlsx")
df_exam

mean(df_exam$english)
mean(df_exam$science)

## read excel

df_exam_novar<-read_excel("excel_exam_novar.xlsx",col_names=F) ## 데이터 프레임 불러오는것과 마찬가지로 기본적으로 제일 위에 데이터를 헤더로 불러오기 때문에 데이터가 있다면 col_names 체크해야함
df_exam_novar
df_exam_sheet<-read_excel("excel_exam_sheet.xlsx",sheet=3) ## 여러시트중 원하는 시트값 불러
df_exam_sheet

fruits6<-read.delim("clipboard",header=T) ## 엑셀파일에서 복사를 하면 클립보드에 들어가게 되고 그 클립보드에서 파일을 불러올 수도 있다. 
fruits6


## write excel

write.table(fruits6,'fruits6.txt')
fruits6_2<-read.table('fruits6.txt',header=T)
fruits6_2

library(WriteXLS)
name<-c("Apple","Banana","Peach")
price<-c(300,200,100)
item<-data.frame(NAME=name,PRICE=price)
item
WriteXLS("item","item.xls")

## RData
## R 전용 데이터 파일로서 용량이 작고 빠름
save(item,file="df midterm.rda") ## 변수는 데이터프레임 형식을 넣어줘야함  ## 변수 이름 자체를 파일로 저장함
rm(item)
load("df midterm.rda") ## 따라서 load 를 쓰면 변수를 아예 삭제해도 다시 변수가 복구되어 데이터값까지 돌아옴
item


## 그래프
## 여백조정하기
a<-c(1,2,3)
plot(a,xlab="aaa")
par(mgp=c(0,1,0))  ## mgp = c(제목위치,(x,y좌표값),(x,y 좌표값이 있는곳에 튀어나온곳))  위치값만큼 여백을 가지고 만듬  
plot(a,xlab="aaa")
par(mgp=c(3,1,0))
plot(a,xlab="aaa")   ## 해본결과 mgp에서 제일 앞에 제목위치만 바꿀것같음 나머지는 바꿀 필요가 없어보임

par(oma=c(0,2,0,0))  ## 마지막 그래프 전체여백조정하기 ( 밑 왼 위 오 순으로)
plot(a,xlab="aaa")

## 아래와 같이 그리면 y축의 이름이 겹치게된다.
v1<-c(1,2,3,4,5)
v2<-c(5,4,3,2,1)
v3<-c(3,4,5,6,7)
plot(v1,type="s",col="red",ylim=c(1,5))
par(new=T)  ## 중복허용
plot(v2,type="o",col="blue",ylim=c(1,5))
par(new=T)  ## 중복허용
plot(v3,type="l",col="green")

## 따라서 아래와 같이 lines() 함수를 이용하여 한 그래프위에 데이터값만 그려준다.
plot(v1,type="s",col="red",ylim=c(1,10))
lines(v2,type="o",col="blue",ylim=c(1,5))
lines(v3,type="l",col="green",ylim=c(1,15))
legend(4,9,c("v1","v2",'v3'),cex=0.9,col=c("red",'blue','green'),lty=1)  ## 범례붙이기 (cex는 글자크기를 나타냄, pch는 범례의 크기, lty는 선모양)
