getwd() ## 현재 폴더위치를 출력
setwd("C:\\Temp")  ## 폴더위치 변경
txt1<-read.csv("factor_test.txt") ## csv 파일 형식으로 불러옴
txt1
txt1$blood  ## txt1의 blood 항목들만 불러옴
txt1$name
factor1<-factor(txt1$blood)  ## factor() : blood 항목의 요소들을 뽑아냄
factor1
summary(factor1)  ## 각각의 데이터 갯수를 알려줌
summary(txt1$sex) ## 바로 사용할수도있음