data<-mpg
qplot(data=mpg,x=hwy)
qplot(data=mpg,x=class)
qplot(data=mpg,x=drv,y=hwy)
qplot(data=mpg,x=drv,y=hwy,geom="boxplot")
x<-c(80,60,70,50,90)
mean(x)
y<-mean(x)
y
?qplot  ## ?함수이름 하면 함수에대한 설명 나옴
x<-paste(x,'')
x
cat(1,':','a','\n',2,':','b')
