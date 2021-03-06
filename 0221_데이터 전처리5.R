## 성별 직업 빈도 - "성별로 어떤 직업이 가장 많을까?"

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

## 성별 전처리
welfare$sex <- ifelse(welfare$sex==9,NA,welfare$sex) ## 9는 NA 값으로 바꿔주고 9가 아닌 값의 경우는 원래대로의 값을 유지해준다
table(is.na(welfare$sex)) ## 결측치 변경 후 다른 결측치가 남아있는지 확인

welfare$sex<-ifelse(welfare$sex==1,"male","female") ## 1은 남자로, 2는 여자로 알아보기 쉽게 바꿔줌

## 직업 전처리
#남성
job_male<-welfare%>%
  filter(!is.na(job)&sex=='male')%>%
  group_by(job)%>%
  summarise(n=n())%>%   ## n()함수는 행 갯수를 세서 알려줌
  arrange(desc(n))%>%  ## 내림차순
  head(10)
#여성
job_female<-welfare%>%
  filter(!is.na(job)&sex=='female')%>%
  group_by(job)%>%
  summarise(n=n())%>%   ## n()함수는 행 갯수를 세서 알려줌
  arrange(desc(n))%>%  ## 내림차순
  head(10)

ggplot(data=job_male,aes(x=reorder(job,n),y=n))+geom_col()+coord_flip()  ## coord_flip()은 가로막대로 그려줌


