## 나이와 월급의 관계 - "몇 살 때 월급을 가장 많이 받을까?"


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

## 나이 전처리
class(welfare$birth)  ## 나이가 숫자로 이루어져있음을 알 수 있음
summary(welfare$birth)  ## 나이대 요약
qplot(welfare$birth)
table(is.na(welfare$birth))  ## 결측치를 확인
welfare$birth<-ifelse(welfare$birth==9999,NA,welfare$birth)  ## 무응답인 9999를 NA 값으로 바꿔줌
table(is.na(welfare$birth))  ## 결측치 재확인
welfare$age<-2015-welfare$birth+1  ## 출생년도를 이용해 나이 변수를 새로 생성
summary(welfare$age)
qplot(welfare$age)  ## 나이를 이용해 나이대분포를 확인

## 월급 전처리
class(welfare$income)  ## 급여가 숫자임을 알 수 있음
summary(welfare$income) ## summary로 정리해서 봄
welfare$income<-ifelse(welfare$income %in% c(0,9999),NA,welfare$income)  ## 결측치 확인을 위해 0과 9999를 NA로 바꿔줌
table(is.na(welfare$income))

age_income<-welfare%>%  ## 수입이 있는 데이터를 age 그룹으로 묶어서 급여의 평균을 나타내준다
  filter(!is.na(income))%>%
  group_by(age)%>%
  summarise(mean_income = mean(income))
head(age_income)
ggplot(data = age_income, aes(x=age,y=mean_income))+geom_line()  ## x축을 나이, y축을 나이대별 평균 수입으로 선으로 그래프를 그려준다.


welfare<-welfare%>%
  mutate(ageg=ifelse(age<30,"young",ifelse(age<=59,"middle","old"))) ## 30살 이하는 young 그룹으로, 그 외 중 59 이하는 middle, 나머지는 old 그룹으로 묶어줌
table(welfare$ageg)
qplot(welfare$ageg)

ageg_income<-welfare%>%  ## 나이대별 수입 평균을 알기위해 수입을 가져오고 나이대별로 묶은 후 그에대한 통계를 냄
  filter(!is.na(income))%>%
  group_by(ageg)%>%
  summarise(mean_income=mean(income))
ageg_income
ggplot(data=ageg_income,aes(x=ageg,y=mean_income))+geom_col()
ggplot(data=ageg_income,aes(x=ageg,y=mean_income))+geom_col()+scale_x_discrete(limits=c("young","middle",'old'))  ## scale_x_discrete 함수를 이용해 그래프 x축 순서를 마음대로 변경할 수 있다

