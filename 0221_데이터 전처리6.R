## 종교 유무에 따른 이혼율 - "종교가 있는 사람들이 이혼을 덜 할까?"

## install.packages("foreign")
library(foreign) ## spss 파일로드
library(dplyr)  ## 전처리
library(ggplot2) ## 시각화
library(readxl) ## 엑셀파일 불러오기

raw_welfare<-read.spss(file="Koweps_hpc10_2015_beta1.sav",to.data.frame=T)  ## sav 파일 불러오기
welfare<-raw_welfare  ## 원본파일 복사본을 만들어 복사본으로 작업하는 편이 나중에 틀린거 찾기 좋음
head(welfare) ## 각 행의 첫번째 데이터
tail(welfare) ## 각 행의 마지막 데이터
View(welfare) ## 파일열어서 보기
dim(welfare)  ## 몇행 몇열인지
str(welfare)  
summary(welfare)

welfare <- rename(welfare,   ## 변수이름을 우리마음대로 바꿔줌
                  sex=h10_g3,  ## 성별
                  birth=h10_g4, ## 태어난 연도
                  marriage=h10_g10, ## 혼인상태
                  religion=h10_g11, ## 종교
                  income=p1002_8aq1, ## 월급
                  code_job=h10_eco9, ## 직종코드
                  code_region=h10_reg7) ## 지역코드

## 종교 전처리
class(welfare$religion)  ## 종교가 숫자로 되있음을 알 수 있음
table(welfare$religion)
welfare$religion<-ifelse(welfare$religion==1,"yes","no") ## 종교 유무를 1,2에서 yes,no로 알기쉽게 표현
table(welfare$religion)
qplot(welfare$religion)

## 결혼상태 전처리
class(welfare$marriage) ## 결혼상태가 숫자로 되있음을 알 수 있음
table(welfare$marriage) ## 결혼상태가 0~6으로 이루어져있음을 알 수 있음
welfare$group_marriage<-ifelse(welfare$marriage==1,"marriage",ifelse(welfare$marriage==3,"divorce",NA))  ## 실제 결혼 유무는 1번과 3번만 필요하기 때문에 그것만 결혼과 이혼으로 바꿔주고 나머지 NA처리
table(welfare$group_marriage)
table(is.na(welfare$group_marriage))  ## NA값이 잘 대입됐는지 확인
qplot(welfare$group_marriage)  ## 그래프그리기

religion_marriage<-welfare %>%  ## 종교와 결혼상태의 상관관계
  filter(!is.na(group_marriage))%>%
  group_by(religion,group_marriage)%>%
  summarise(n=n())%>%
  mutate(tot_group=sum(n))%>%
  mutate(pct=round(n/tot_group*100,1))
religion_marriage  

divorce<-religion_marriage%>%
  filter(group_marriage=="divorce")%>%
  select(religion,pct)
divorce
ggplot(data=divorce,aes(x=religion,y=pct))+geom_col()
