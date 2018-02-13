data <- seq(from=as.Date('2014-01-01'),to=as.Date('2014-02-28'),by='day')  ## day별로 찍어줌
data

objects()  ## 지금까지 만든 변수가 뭐가있는지 알려줌 (숨겨진건 안보여줌)
objects(all.names=T) ##숨겨진 변수까지 전부 알려줌
rm(data)  ## data 변수를 삭제
rm(list=ls())  ## 변수들 전부 삭제

## 벡터개념 (c() 가 벡터개념임)
v=c(1,2,3,4,5) ## 숫자형태로 전부들어감
v
v=c(1,2,3,4,"5") ## 마지막 값이 문자라서 모두 문자로 변환되어 들어감
v
v[1] ## 1번째 값 보여줌
v[-1] ## 1번째 빼고 보여줌
v <- c(v,7) ## 이런식으로 추가해줄수도 있음 for문 사용 가능할듯
v[9] <-9 ## 현재 1,2,3,4,5 가 들어있고 6,7,8 번째 는 NULL값이 아닌 NA 값이 들어가고 9번째에 9가 들어감 그리고 현재 1,2,3,4,5 가 문자로 들어가있기때문에 9도 문자로 들어감
v

## ★★append 는 바꾸는 의미가 아닌 삽입의 의미이기때문에 뒤에 순서가 다 밀림★★
v=append(v,10,after=3) ## 3번 다음 위치에 10을 넣으라는 의미 
v
v=append(v,c(10,11),after=3) ## 3번 다음 위치에 10과 11이 각각 4번째 5번째 자리에 들어감
v
v=append(v,10)  ## after 값을 안써주면 제일 뒤로 들어감
v
v[0]  ## 0의 인덱스값은 변수의 속성값을 알려줌

##벡터 연산하기
c(1,2,3) + c(4,5,6)  ## 각각 요소별로 더해서 값이 나옴
c(1,2,3,4) + c(1,2)  ## 길이가 다르면 짧은쪽이 순환되어서 처음부터 다시 값을 대입해 더함



## 집합관련 함수
v<-c(1,2,3)
v1<-c(3,4,5)
union(v,v1)    ## 합집합의 의미로 중복되는 것은 없어짐  v1와 v는 데이터형은 다르지만 a의 숫자 1과 b의 문자 1은 합집합하면 문자 1로 묶이기때문에 하나만 나옴
setdiff(v,v1) ## v에는 있는데 v1에는 없는 요소 출력 (차집합)
setdiff(v1,v) ## v1에는 있는데 v에는 없는 요소 출력
intersect(v,v1) ## v와 v1의 교집합 출력

v<-c(1,2,3)
length(v) ## 요소가 몇개인지 알려줌
nrow(v) ## 행이 몇개인지

## 딕셔너리 개념
fruits <- c(10,20,30,40)
names(fruits)<-c('apple','banana','peach')  ## 요소의 개수와 맞지 않으면 이름값이 NA로 나옴
fruits['apple']  ## 키 값으로 불러올수 있음
names(fruits)   ## 키값만 나옴
NROW(fruits)  ## nrow(fruits)는 행의 개수를 찾아주기때문에 fruits는 데이터형식이아니라 NULL이 나오지만  NROW는 요소의 개수를 세줌

list1 <- list(name="James Seo",address='Seoul',tel='010-87069-4712',pay=500)
list1$name  ## 키값으로 부름 list1['name'] 랑 동일
list1$birth <- '1975-10-23'  ## 새로운 요소추가
list1
list1$birth <-NULL  ## 요소 제거
list1

list1$name <- c("Seojinsu","James Seo")  ## 벡터형식으로도 집어넣을수있음



v<-c(1,3,5,7,9)
3 %in% v  ## v에서 3이 있는지 없는지 확인해줌  (%in% 는 함수가 아니라 연산자임)


## 2차원 배열
mat1<-matrix(c(1,2,3,4)) ## 행으로 선언
mat1
mat1<-matrix(c(1,2,3,4),nrow=2)   # 2행으로 선언
mat1
mat1<-matrix(c(1,2,3,4),nrow=2,byrow=T)  # 2행으로 선언하는데 행순으로 값을 대입
mat1
mat1[,1] ## 모든 행의 1열 값을 출력
mat1[1,] ## 1행의 모든 열값을 출력
mat1[1,1] ## 1,1 에 있는 값 출력
mat1 <-matrix(c(1,2,3,4,5,6,7,8,9),nrow=3,byrow=T)
mat1
## bind 함수는 행이나 열을 붙일때 개수가 안맞을때 더 적으면 순환이 발생, 많으면 에러뜸
mat1 <- rbind(mat1,c(11,12,13))  ## mat1이 3x3 배열인데 행을 추가함
mat1
mat1 <- cbind(mat1,c(0,-1,-2,-3))  ## 열추가
mat1

colnames(mat1)<-c('First','Second','Third','Forth')  ##  열별로 이름 붙여줌
mat1
rownames(mat1)<-c('First','Second','Third','Forth')  ##  행별로 이름 붙여줌
mat1
names(mat1)<-c('First','Second','Third','Forth')  ## 2차원배열은 요소개수가 다르면 에러가나넹
mat1

## 3차원배열
array1 <-array(c(1:12),dim=c(4,3))  ## 2차원으로 선언  dim 은 형식을 어떻게 만들것인가 (차원의 개수 행->열 순으로) 
array1
array1 <-array(c(1:12),dim=c(2,2,3))  ## 3차원으로 선언 (행 -> 열 -> 3차원)
array1
array1[1,2,3]
colnames(array1)<-c("a","b")
## names(array1)<-c("a","b","c")  층에는 이름을 붙일수가 없음
array1[1,'a',2] ## 이름 붙여준거로도 부를수있음

## 데이터 프레임 생성하기
english<-c(90,80,60,70)
english
math<-c(50,60,100,20)
math
df_midterm<-data.frame(english,math)
df_midterm
df_midterm1<-data.frame(math,english)
df_midterm1

class<-c(1,1,2,2)
class

df_midterm<-data.frame(english,math,class)
df_midterm
mean(df_midterm$english) ## 평균구하기
mean(df_midterm$math)

제품<-c('사과','딸기','수박')
howmany<-c(24,38,13)
price<-c(1800,1500,3000)
temp<-data.frame('제품',howmany,price)
temp

##  데이터프레임
sales2 <- matrix(c(1,'Apple',500,5,2,'Peach',200,2,3,'Banana',100,4,4,'Grape',50,7),nrow=4,byrow=T)
sales2
df1<-data.frame(sales2)  ## sales2 라는 매트릭스를 데이터프레임화 시켜줌
df1
names(df1)<-c("No",'Name','Price','QTY')
df1
df1$Name
class(df1$Name)  ## factor 형으로서 중복되는 값은 제외하고 나타내줌
df1[c(1,2),]  ## 벡터형태로도 출력을 할 수 있다.
df1[,c(2,3)]

subset(df1,QTY<4)  ## 원하는 조건값으로 찾을 수 있음
subset(df1,No<=4)

## merge  데이터 프레임 합치기
df1 <- data.frame(name=c('apple','banana','cherry'),price=c(300,200,100))
df2<- data.frame(name=c('apple','cherry','berry'),qty=c(10,20,30))
df1
df2
merge(df1,df2)     ## (name이 같은 것은 추가안하고 그 외의 것 추가)
merge(df1,df2,all=T)  ## name이 같은것은 추가안하고 그 외의 name 값이 없는것은 NA로 값을 추가해줌
names(df1)<-c("이름","가격")
df1      
colnames(df1)<-c('n','p')
df1
ncol(df1)
nrow(df1)
rownames(df1)
colnames(df1)
df1[c(2,1),]
