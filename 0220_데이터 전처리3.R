## 연령대 및 성별 월급 차이


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

## 나이대 전처리
welfare<-welfare%>%
  mutate(ageg=ifelse(age<30,"young",ifelse(age<=59,"middle","old"))) ## 30살 이하는 young 그룹으로, 그 외 중 59 이하는 middle, 나머지는 old 그룹으로 묶어줌
table(welfare$ageg)
qplot(welfare$ageg)

## 성별 전처리
welfare$sex <- ifelse(welfare$sex==9,NA,welfare$sex) ## 9는 NA 값으로 바꿔주고 9가 아닌 값의 경우는 원래대로의 값을 유지해준다
table(is.na(welfare$sex)) ## 결측치 변경 후 다른 결측치가 남아있는지 확인

welfare$sex<-ifelse(welfare$sex==1,"male","female") ## 1은 남자로, 2는 여자로 알아보기 쉽게 바꿔줌

sex_income<-welfare %>%  ## 수입데이터를 가져와서 나이대와 연령으로 묶고 그에대한 수입의 평균을 정리한다
  filter(!is.na(income))%>%
  group_by(ageg,sex)%>%
  summarise(mean_income=mean(income))
ggplot(data=sex_income,aes(x=ageg,y=mean_income,fill=sex))+geom_col()+scale_x_discrete(limits=c('young','middle','old'))  ## 그래프가 두가지 색깔로 따로따로 나오는걸 볼 수 있음
ggplot(data=sex_income,aes(x=ageg,y=mean_income,fill=sex))+geom_col(position='dodge')+scale_x_discrete(limits=c('young','middle','old'))  ## 붙어있던 그래프를 따로따로 나오게 하는 걸 볼 수 있음



sex_age<-welfare%>%  ## 성별과 나이에 따른 급여의 평균을 구함
  filter(!is.na(income))%>%
  group_by(age,sex)%>%
  summarise(mean_income=mean(income))
head(sex_age)
ggplot(data=sex_age,aes(x=age,y=mean_income,col=sex))+geom_line()  ## 나이마다 구해주기때문에 값이 너무 많아 선으로 그래프를 그려준다


