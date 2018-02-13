library(KoNLP) 
library(wordcloud)
useSejongDic()  ## 사전이용
data1 <-readLines("금연구역 지식인.txt") ## seoul_new.txt 파일을 불러옴  (행단위로 불러옴)
data1
data2<-sapply(data1,extractNoun,USE.NAMES=F) ## data2 에는 각 행에서 단어들만 추출해서 리스트형식으로 담음
data2
head(unlist(data2),30)  ##data2 를 리스트형식을 제외한뒤 30개만 보여줌
data3<-unlist(data2)  ## 리스트형식을 없애고 전부 행단위로 담
data3
data3<-gsub("\\d+","",data3)  ## 정규식으로써 숫자 한번이상 있으면 "" (없는거) 로 바꿔줌
data3<-gsub("뉴스제목","",data3)
data3<-gsub(":","",data3)
data3<-gsub("<b>.*</b>","",data3)
data3<-gsub("뉴스","",data3)
data3<-gsub("내용","",data3)
data3<-gsub("요약","",data3)
data3<-gsub("제목","",data3)
data3<-gsub("에서","",data3)
data3<-gsub("[a-zA-Z0-9]","",data3)
data3<-gsub("으로","",data3)
data3<-gsub("지정","",data3)
data3<-gsub("근데","",data3)
data3<-gsub("이상","",data3)
data3<-gsub("가능","",data3)
data3<-gsub("경우","",data3)
data3<-gsub("전체","",data3)

data3 <- Filter(function(x) {nchar(x) >=2},data3)

data3
write(unlist(data3),"금연구역 지식인_2.txt")
data4 <- read.table("금연구역 지식인_2.txt")
data4
nrow(data4)  ## data4의 행이 몇개인지 알려줌
wordcount<-table(data4)
wordcount
head(sort(wordcount,decreasing=T),30)   ## 빈도순으로 20개만 정렬해서 내림차순으로 보여줌
library(RcolorBrewer)
palete <- brewer.pal(9,"Set3")
wordcloud(names(wordcount),freq=wordcount,scale=c(5,1),rot.per=0.25,min.freq=7,random.order=F,random.color=T,colors=palete)  ## random.order=F 는 그리는순서가 빈도수에 관계없음을 나타냄 
legend(0.3,1,"금연구역 지식인",cex=0.8,fill=NA,border=NA,bg="white",text.col="red",text.font=2,box.col="red")

