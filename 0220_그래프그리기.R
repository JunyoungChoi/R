ggplot(data = mpg,aes(x=displ,y=hwy))   ## 배경만 그려줌
ggplot(data = mpg,aes(x=displ,y=hwy))+geom_point()  ## 점을 찍어줌
ggplot(data = mpg,aes(x=displ,y=hwy)) + geom_point() + xlim(3,6)  ## x축 y 축 범위를  정해줌
ggplot(data = mpg,aes(x=displ,y=hwy)) + geom_point() + xlim(3,6) + ylim(10,30)

ggplot(data = mpg,aes(x=cty,y=hwy))+geom_point()  ## 교재 188쪽 1번 문제
ggplot(data=midwest,aes(x=poptotal,y=popasian))+geom_point()+xlim(0,500000)+ylim(0,10000)  ## 교재 188쪽 2번 문제


library(dplyr)  ## 막대그래프를 그리기 위해서
df_mpg<-mpg %>%
  group_by(drv) %>%
  summarise(mean_hwy=mean(hwy))
df_mpg
ggplot(data=df_mpg,aes(x=drv,y=mean_hwy))+geom_col()   ## geom_col() 막대그래프를 그려줌
ggplot(data=df_mpg,aes(x=reorder(drv,-mean_hwy),y=mean_hwy))+geom_col()  ## reorder()함수로 내림차순으로 x축을 정렬해서 그려줌

ggplot(data=mpg,aes(x=drv))+geom_bar() ## 값의 개수(빈도)로 막대의 길이를 표현함
ggplot(data=mpg,aes(x=hwy))+geom_bar()  
## geom_col() : 평균 막대 그래프로서 데이터를 요약한 평균표를 먼저 만든 후 평균표를 이용해 그래프 생성
## geom_bar() : 별도로 표를 만든지 않고 원자료를 이용해 바로 그래프 생성


## 193쪽 문제
df_mpg1<-mpg %>%   
  filter(class=="suv")%>%
  group_by(manufacturer) %>%
  summarise(mean_cty=mean(cty)) %>%
  arrange(desc(mean_cty)) %>%
  head(5)
ggplot(data=df_mpg1,aes(x=reorder(manufacturer,-mean_cty),y=mean_cty))+geom_col()
ggplot(data=df_mpg1,aes(x=manufacturer))+geom_bar()

## 시간에 따라 달라지는 데이터 그리기
ggplot(data=economics,aes(x=date,y=unemploy))+geom_line()  ## 시간에 따라 달라지는 데이터의 경우 날짜 데이터도 넣어주는 경우가 많음
       