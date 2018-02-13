1e-2 ## 지수표시
as.numeric('1') ## 문자를 숫자로 변경해줌
'First' 
"First"  ## '나 " 둘다 사용가능
class(1) ## 데이터 타입 검사
class('1')
## NA : 잘못된 값이 들어올경우
## NULL : 값이 없을 경우
cat(1,NA,2) ## NA가 그대로 출력 1 NA 2
cat(1,NULL,2) ## NULL 값이 제거되고 출력 1 2
sum(1,NA,2) ## NA를 더해서 NA 출력
sum(1,NULL,2) ## NULL 값은 없는 값이라 NULL 제외하고 더해서 출력
sum(1,NA,2,na.rm=T) ## na.rm이 NA 값을 remove 하고 계산하도록 해줌
seq(1,10,by=2) ## 1부터 10까지 수중에 1부터 2씩 커지는 숫자를 나타

