## 성별에 따른 월급 차이 분석하기



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

## 변수 이상치 확인하기
class(welfare$sex)  ## numeric 타입이 들어가있음
table(welfare$sex)  ## 1,2 외에 없다는 사실을 알 수 있음 (9가 들어올 수 있음)

## 이상치 결측 처리
welfare$sex <- ifelse(welfare$sex==9,NA,welfare$sex) ## 9는 NA 값으로 바꿔주고 9가 아닌 값의 경우는 원래대로의 값을 유지해준다
table(is.na(welfare$sex)) ## 결측치 변경 후 다른 결측치가 남아있는지 확인

welfare$sex<-ifelse(welfare$sex==1,"male","female") ## 1은 남자로, 2는 여자로 알아보기 쉽게 바꿔줌
qplot(welfare$sex)  ## qplot으로 나타내줌


class(welfare$income)  ## 급여가 숫자임을 알 수 있음
summary(welfare$income) ## summary로 정리해서 봄
qplot(welfare$income)  ## 바 그래프로 급여를 나타냄
qplot(welfare$income) + xlim(0,1000)  ## 1000 이상의 빈도수가 적기때문에 x축의 한계를 1000까지 설정해서 그려줌
welfare$income<-ifelse(welfare$income %in% c(0,9999),NA,welfare$income)  ## 결측치 확인을 위해 0과 9999를 NA로 바꿔줌
table(is.na(welfare$income))

sex_income<-welfare %>%  ## 성별 급여 평균을 알기위해 새로운 변수 선언
  filter(!is.na(income)) %>%  ## 먼저 0과 9999를 제외한 봉급데이터들을 걸러냄
  group_by(sex) %>%  ## 이들을 성별로 구분
  summarise(mean_income=mean(income))  ## 성별로 구분된 급여 평균치를 집계
ggplot(data=sex_income,aes(x=sex,y=mean_income))+geom_col()  ## 그래프 그리기
