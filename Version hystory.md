- LTechKorea FRU Editor ver 1.0.0  
기능 부분  
1. LOGO추가  
![image](https://user-images.githubusercontent.com/89372983/134866262-834b2aa3-9178-47fb-91df-417d4d52042e.png)

                                                                                                                   
2. 지원 모델 (당사 주력모델 목록)  
2U 12BAY CPU서버,  R281-3C0 > LKG-2212-C  
2U 12BAY CPU서버,  R281-3C1 > LKG-2212-C (테스트 초판모델 익스텐더 백플레인)  
2U 12BAY 2-GPU서버,  R281-3C2 > LKG-2212-G  
2U 24BAY 3-GPU서버,  R281-G30 > LKG-2224-G  
1U 4BAY CPU서버,  R181-340 > LKG-1204-C  
2U 10BAY CPU서버,  R181-N20 > LKG-1210-C  

해당 FRU 정보 변경 기준은 아래 문서에서 확인  
- https://docs.google.com/document/d/1bfCwTgQvqGkqwCF-Db8mfm415kB2QNH-TDnN_EDyDU0/edit#
프로세스바는 아래링크에서 가져옴
- https://answer-id.com/ko/74489640

2. 진행 사항 보기편하게 프로세스 바 추가  
![프로세스 바](https://user-images.githubusercontent.com/89372983/134865368-a258219a-9955-47b4-b2c8-519e74ff3331.png)
4. 해당 스크립트 동일경로에 로그파일 생성  
- 변경전, 변경후, 변경날짜, 버전 정보 기록  
5. BMC 접속 오류 표시  
6. IP 정보가 아닌 다른 문자열 입력시 다시 입력 하도록 만듦  
7. username, password를 입력받아 진행  

- LTechKorea FRU Editor ver 1.0.1(2021.01.06)
1. 주력모델 단일화로 인해 모델명 끝 G가 아닌 C로 통일
2. 수동으로 시리얼 입력 기능추가
    - 입고된 서버들 중 시리얼 번호가 누락되어 있는 서버들로 인해 수동으로 시리얼을 입력해야하는 경우가 생김