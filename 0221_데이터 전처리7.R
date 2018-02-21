## 연령대 및 종교 유무에 따른 이혼율 분석하기

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

## 나이 전처리
class(welfare$birth)  ## 나이가 숫자로 이루어져있음을 알 수 있음
summary(welfare$birth)  ## 나이대 요약
qplot(welfare$birth)
table(is.na(welfare$birth))  ## 결측치를 확인
welfare$birth<-ifelse(welfare$birth==9999,NA,welfare$birth)  ## 무응답인 9999를 NA 값으로 바꿔줌
table(is.na(welfare$birth))  ## 결측치 재확인
welfare$age<-2015-welfare$birth+1  ## 출생년도를 이용해 나이 변수를 새로 생성
summary(welfare$age)

## 나이대 전처리
welfare<-welfare%>%
  mutate(ageg=ifelse(age<30,"young",ifelse(age<=59,"middle","old"))) ## 30살 이하는 young 그룹으로, 그 외 중 59 이하는 middle, 나머지는 old 그룹으로 묶어줌
table(welfare$ageg)


## 결혼상태 전처리
class(welfare$marriage) ## 결혼상태가 숫자로 되있음을 알 수 있음
table(welfare$marriage) ## 결혼상태가 0~6으로 이루어져있음을 알 수 있음
welfare$group_marriage<-ifelse(welfare$marriage==1,"marriage",ifelse(welfare$marriage==3,"divorce",NA))  ## 실제 결혼 유무는 1번과 3번만 필요하기 때문에 그것만 결혼과 이혼으로 바꿔주고 나머지 NA처리
table(welfare$group_marriage)
table(is.na(welfare$group_marriage))  ## NA값이 잘 대입됐는지 확인

ageg_religion_marriage<-welfare%>%  ## 연령대와 종교별 결혼상태
  filter(!is.na(group_marriage)&ageg!="young")%>%  ## young 연령대는 빈도수가 적기때문에 제외
  group_by(ageg,religion,group_marriage)%>%
  summarise(n=n())%>%
  mutate(tot_group=sum(n))%>%
  mutate(pct=round(n/tot_group*100,1))
ageg_religion_marriage

df_divorce<-ageg_religion_marriage%>%  ## 이혼율에대한 정보를 다시 정리
  filter(group_marriage=='divorce')%>%
  select(ageg,religion,pct)  ## 나이대, 종교, 이혼퍼센테이지만 보여줌
df_divorce
ggplot(data=df_divorce,aes(x=ageg,y=pct,fill=religion))+geom_col(position='dodge')  ## 그려준다
