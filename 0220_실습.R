## install.packages("dplyr")
library(dplyr)

data1<-read.csv("2013년_프로야구선수_성적.csv")
data1
## 1번
data1<-read.csv("2013년_프로야구선수_성적.csv") %>%
  filter(경기>=120)
data1

## 2번
data1<-read.csv("2013년_프로야구선수_성적.csv") %>%
  filter((경기>=120) & (득점 >=80))
data1

## 3번
data1<-read.csv("2013년_프로야구선수_성적.csv") %>%
  filter((포지션=='1루수') | (포지션=='3루수'))
data1

## 4번
data1<-read.csv("2013년_프로야구선수_성적.csv") %>%
  select(선수명,포지션,팀)
data1

## 4번
data1<-read.csv("2013년_프로야구선수_성적.csv") %>%
  select(순위:타수)
data1

## 보고서 문제
library(googleVis)
attach(Fruits)
## 1번
data1 <- Fruits %>%
  filter(Expenses >80)
data1
## 2번
data1 <- Fruits %>%
  filter((Expenses) >90 & (Sales>90))
data1

## 3번
data1 <- Fruits %>%
  filter((Expenses) >90 | (Sales>80))
data1

## 4번
data1 <- Fruits %>%
  filter(Expenses ==79 | Expenses==91)
data1

## 5번
data1 <- Fruits %>%
  select(Fruit:Sales,-Location)
data1

## 6번
data1 <- Fruits %>%
  group_by(Fruit)%>%
  summarise(average = sum(Sales,na.rm=TRUE))
data1

## 7-1번
data1 <- Fruits %>%
  group_by(Fruit)%>%
  select(Fruit,Sales,Profit)%>%
  summarise(Sales= sum(Sales,na.rm=TRUE))
  summarise(Profit=sum(Profit,na.rm=TRUE))

## 7-2번
data1 <- Fruits %>%
  group_by(Fruit)%>%
  select(Fruit,Sales,Profit)%>%
  summarise(Profit=sum(Profit,na.rm=TRUE))
data1
