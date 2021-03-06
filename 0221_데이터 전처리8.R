## 지역별 연령대 비율 - "노년층이 많은 지역은 어디일까?"

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

## 나이대 전처리
welfare<-welfare%>%
  mutate(ageg=ifelse(age<30,"young",ifelse(age<=59,"middle","old"))) ## 30살 이하는 young 그룹으로, 그 외 중 59 이하는 middle, 나머지는 old 그룹으로 묶어줌
table(welfare$ageg)


## 지역 전처리
class(welfare$code_region)  ## 지역이 숫자로 되있음을 확인
table(welfare$code_region) ## 1~7 까지의 데이터가 있음을 확인
list_region<-data.frame(code_region=c(1:7),region=c("서울","수도권(인천/경기)","부산/경남/울산","대구/경북",'대전/충남','강원/충북','광주/전남/전북/제주도'))  ## 각 코드에 사람이 알아보기 쉽게 한글로 변수명 변경
welfare<-left_join(welfare,list_region,id="code_region")  ## welfare의 제일 왼쪽에 code_region으로서 데이터 삽입
welfare%>% 
  select(code_region,region)%>%
  head

## 연령대별 지역 필터링
region_ageg<-welfare%>%
  group_by(region,ageg)%>%
  summarise(n=n())%>%
  mutate(tot_group=sum(n))%>%
  mutate(pct=round(n/tot_group*100,2))
head(region_ageg)

ggplot(data=region_ageg,aes(x=region,y=pct,fill=ageg))+geom_col()+coord_flip()  ## 그래프 그리기


## 막대정렬하기 : 노년층 비율 높은 순
list_order_old<-region_ageg%>%  ## list_order_old 라는 새 변수에 연령대별 지역중 old 부분을 필터링해서 대입
  filter(ageg=="old")%>%
  arrange(pct)
list_order_old
order<-list_order_old$region  ## order 변수에 old의 지역들을 대입
order
ggplot(data=region_ageg,aes(x=region,y=pct,fill=ageg))+geom_col()+coord_flip()+scale_x_discrete(limits=order)  ## scale_x_discrete( )을 이용해 order에 따라서 정렬

class(region_ageg)  ## 형태가 문자열임을 확인
levels(region_ageg$ageg)  ## level의 순서가 안정해져있음을 확인
region_ageg$ageg<-factor(region_ageg$ageg,level=c('old','middle','young')) ## factor()함수와 level()을 이용해 데이터의 순서를 바꿔줌
class(region_ageg$ageg) 
levels(region_ageg$ageg)  ## level이 old, middle, young 순으로 바뀐것을 확인
ggplot(data=region_ageg,aes(x=region,y=pct,fill=ageg))+geom_col()+coord_flip()+scale_x_discrete(limits=order)  
