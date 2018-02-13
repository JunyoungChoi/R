useSejongDic()
library(wordcloud)
library(KoNLP)
data1 <-readLines("remake2.txt")
data1
data2<-sapply(data1,extractNoun,USE.NAMES=F)
data2
data3<-unlist(data2)
data3<-Filter(function(x) {nchar(x)>=2},data3)
head(unlist(data3),30)
data3 <- gsub("\\d+","",data3)
data3 <-gsub("쌍수","쌍꺼풀",data3)
data3 <-gsub("쌍커풀","쌍꺼풀",data3)
data3 <-gsub("메부리코","매부리코",data3)
data3 <-gsub("\\.","",data3)
data3 <-gsub("^것$","",data3)
data3 <-gsub("^등$","",data3)
data3 <-gsub("^수$","",data3)
data3 <-gsub("^후$","",data3)
data3 <-gsub("^한$","",data3)
data3 <-gsub("^때문$","",data3)
data3 <-gsub("^이요$","",data3)
data3 <-gsub("부작용","",data3)
data3 <-gsub("필요","",data3)
data3 <-gsub("정확","",data3)
data3 <-gsub("관련","",data3)
data3 <-gsub("입증","",data3)
data3 <-gsub("자가","",data3)
data3 <-gsub("^하$","",data3)
data3 <-gsub("^성$","",data3)
data3 <-gsub("^하게$","",data3)
data3 <-gsub("^인정$","",data3)
data3 <-gsub("^결과$","",data3)
data3 <-gsub("^설명$","",data3)
data3 <-gsub("^성$","",data3)
data3 <-gsub("^시술$","",data3)
data3 <-gsub("^환자$","",data3)
data3 <-gsub("^대부분$","",data3)
data3 <-gsub("^이상$","",data3)
data3 <-gsub("^확인$","",data3)
data3 <-gsub("^하자$","",data3)
data3 <-gsub("^윤인모$","",data3)
data3 <-gsub("^이상$","",data3)
data3 <-gsub("^사용$","",data3)
data3 <-gsub("^걱정$","",data3)
data3 <-gsub("^진행$","",data3)
data3 <-gsub("^청구$","",data3)
data3 <-gsub("^수술$","",data3)
data3 <-gsub("^상법$","",data3)
data3 <-gsub("^부작$","",data3)
data3 <-gsub("^최오규$","",data3)
data3 <-gsub("","",data3)
data3 <-gsub(" ","",data3)
data3 <-gsub("\\'","",data3)
data3 <-gsub("성형외과","",data3)
head(sort(wordcount,decreasing=T),20)
txt<-readLines("성형부작용gsub.txt")
cnt_txt<-length(txt)
for( i in 1:cnt_txt){
  data3<-gsub((txt[i]),"",data3)
}
data3 <- gsub("재수","재수술",data3)
data3
write(unlist(data3),"remake2_2.txt")
data4 <- read.table("remake2_2.txt")

data4
nrow(data4)  ## data4의 행이 몇개인지 알려줌
wordcount<-table(data4)
wordcount
head(sort(wordcount,decreasing=T),30)   ## 빈도순으로 20개만 정렬해서 내림차순으로 보여줌
library(RcolorBrewer)
palete <- brewer.pal(9,"Set3")
wordcloud(names(wordcount),freq=wordcount,scale=c(5,1),rot.per=0.25,min.freq=4,random.order=F,random.color=T,colors=palete)  ## random.order=F 는 그리는순서가 빈도수에 관계없음을 나타냄 


top10<-head(sort(wordcount,decreasing=T),10)
top10
pie(top10,col=rainbow(10),radius=1,main="성형부작용 wordcloud") ## 원으로 그래프를 그려
pct <-round(top10/sum(top10)*100,1)
names(top10)
lab<-paste(names(top10),"\n",pct,"%")
lab
pie(top10,main="성형부작용 wordcloud",col=rainbow(10),cex=0.8,labels=lab) ## 퍼센테이지까지 표시 

bchart<- head(sort(wordcount,decreasing=T),10)
bchart

bp<- barplot(bchart,main="성형부작용 wordcloud",col=rainbow(10),cex.names=0.7,las = 2, ylim=c(0,25)) ## 세로 바로 된 표 표시
text(x=bp,y=bchart*1.05,labels=paste("(",pct,"%",")"),col="black",cex=0.7)
text(x=bp,y=bchart*0.95,labels=paste(bchart,"건"),col="black",cex=0.7)

barplot(bchart,main="성형부작용 wordcloud",col=rainbow(10),xlim=c(0,25),cex.name=0.7,las=1,horiz=T)  ## 가로바로 된 표 표시
text(y=bp,x=bchart*0.9,labels=paste(bchart,"건"),col="black",cex=0.7)
text(y=bp,x=bchart*1.15,labels=paste("(",pct,"%",")"),col="black",cex=0.7)

