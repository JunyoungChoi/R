KoNLP in r
v1 <-c("봄이 지나면 여름이고 여름이 지나면 가을입니다.", "그리고 겨울이죠")
v1 <- sapply(v1,extractNoun,USE.NAMES=F)
v1
wordcloud(c(0:9,LETTERS,letters),seq(1,1000,len=62))
library(RColorBrewer)
palete<-brewer.pal(9,"Set10")
wordcloud(c(letters,LETTERS,0:9),seq(1,1000,len=62),colors=palete)
seq(1,1000,len=62)

data1 <-readLines("remake.txt")
data1
data2<-sapply(data1,extractNoun,USE.NAMES=F)
data2
data3<-unlist(data2)
data3<-Filter(function(x) {nchar(x)<=10},data3)
head(unlist(data3),30)
data3 <- gsub("\\d+","",data3)
data3 <-gsub("쌍수","쌍꺼풀",data3)
data3 <-gsub("쌍커풀","쌍꺼풀",data3)
data3 <-gsub("메부리코","매부리코",data3)
data3 <-gsub("\\.","",data3)
data3 <-gsub(" ","",data3)
data3 <-gsub("\\'","",data3)
data3 <-gsub("성형외과","",data3)
data3
head(sort(wordcount,decreasing=T),20)
txt<-readLines("성형gsub.txt")
cnt_txt<-length(txt)
for( i in 1:cnt_txt){
  data3<-gsub((txt[i]),"",data3)
}
write(unlist(data3),"remake_2.txt")
data4<-read.table("remake_2.txt")
data4
nrow(data4)
wordcount<-table(data4)
wordcount
head(sort(wordcount,decreasing=T),20)

data3
data3 <- Filter(function(x) {nchar(x) >=2},data3)
write(unlist(data3),"remake_2.txt")
data4<-read.table("remake_2.txt")
data4
nrow(data4)
wordcount<-table(data4)
wordcount
head(sort(wordcount,decreasing=T),30)
library(RColorBrewer)
palete <- brewer.pal(9,"Set3")
wordcloud(names(wordcount),freq=wordcount,scale=c(5,1),rot.per=0.25,min.freq=2,random.order=F,random.color=T,colors=palete)
legend(0.3,1,"여고생들이 선호하는 성형수술 부위",cex=0.8,fill=NA,border=NA,bg="white",text.col="red",text.font=2,box.col="red")

top10<-head(sort(wordcount,decreasing=T),10)
top10
pie(top10,col=rainbow(10),radius=1,main="성형외과 검색어 TOP 10") ## 원으로 그래프를 그려
pct <-round(top10/sum(top10)*100,1)
names(top10)
lab<-paste(names(top10),"\n",pct,"%")
lab
pie(top10,main="여고생 성형 TOP10",col=rainbow(10),cex=0.8,labels=lab) ## 퍼센테이지까지 표시 

bchart<- head(sort(wordcount,decreasing=T),10)
bchart

bp<- barplot(bchart,main="여고생 성형 TOP10",col=rainbow(10),cex.names=0.7,las = 2, ylim=c(0,25)) ## 세로 바로 된 표 표시
text(x=bp,y=bchart*1.05,labels=paste("(",pct,"%",")"),col="black",cex=0.7)
text(x=bp,y=bchart*0.95,labels=paste(bchart,"건"),col="black",cex=0.7)

barplot(bchart,main="여고생 성형 TOP10",col=rainbow(10),xlim=c(0,25),cex.name=0.7,las=1,horiz=T)  ## 가로바로 된 표 표시
text(y=bp,x=bchart*0.9,labels=paste(bchart,"건"),col="black",cex=0.7)
text(y=bp,x=bchart*1.15,labels=paste("(",pct,"%",")"),col="black",cex=0.7)
