## 직업별 월급 차이

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

## 급여 전처리
class(welfare$income)  ## 급여가 숫자임을 알 수 있음
summary(welfare$income) ## summary로 정리해서 봄
qplot(welfare$income)  ## 바 그래프로 급여를 나타냄
qplot(welfare$income) + xlim(0,1000)  ## 1000 이상의 빈도수가 적기때문에 x축의 한계를 1000까지 설정해서 그려줌
welfare$income<-ifelse(welfare$income %in% c(0,9999),NA,welfare$income)  ## 결측치 확인을 위해 0과 9999를 NA로 바꿔줌
table(is.na(welfare$income))

list_job<-read_excel("Koweps_Codebook.xlsx",col_names=T,sheet=2)
head(list_job)
dim(list_job)

welfare<-left_join(welfare,list_job,id="code_job")  ## left_join() 함수안에 제일 앞이 기준이 되는 데이터값이고 두번째가 합칠 데이터값이다.
welfare%>%  ## NA 값이 아닌 code_job 값들을 가져와서 code_job과 job만 표시해줌
  filter(!is.na(code_job))%>%
  select(code_job,job)%>%
  head(10)  ## 10개만 보여줌

job_income<-welfare%>%  ## 직업에따른 수입을 보여줌
  filter(!is.na(job)&!is.na(income))%>%  ## 직업과 수입이 있는 데이터만 가져와서
  group_by(job)%>%  ## 직업별로 묶어서
  summarise(mean_income=mean(income))  ## 평균 급여를 구함
head(job_income)

top10<-job_income%>%  ## 직업의 개수가 너무 많기 때문에 급여가 많은순으로 10개만 뽑아서 새로운 변수를 만듬 
  arrange(desc(mean_income))%>%  ## 정렬
  head(10)
top10

bottom10<-job_income%>%  ## 반대로 급여가 적은순으로 10개를 새로운 변수에 저장
  arrange(mean_income)%>%
  head(10)
bottom10

ggplot(data=top10,aes(x=reorder(job,mean_income),y=mean_income))+geom_col()+coord_filp()
