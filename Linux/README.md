## 찾기 귀찮으니 정리해둔 리눅스(ubuntu) 명령어 정리

- ls -> 리스트    
- cd -> 경로이동   
- pwd -> 현재 디렉토리    
- cp -> 복사   
- mv -> 파일 이동   
- mkdir -> 디렉토리 생성   
- rm -> 파일 삭제 ,    
- rm -r -> 디렉토리 삭제   

- 패키지 인덱스 인덱스 정보를 업데이트 : apt-get은 인덱스를 가지고 있는데 이 인덱스는 /etc/apt/sources.list에 있음.   
  이곳에 저장된 저장소에서 사용할 패키지의 정보를 얻음 
  - sudo apt-get update   
   
- 설치된 패키지 업그래이드 : 설치되어 있는 패키지를 모두 Version Uugrade 합니다.   
  -  sudo apt-get upgrade   
   
- 의존성검사하며 설치하기   
  - sudo apt-get dist-upgrade   
   
- 패키지 설치   
  - sudo apt-get install 패키지이름   
      
-  패키지 재설치   
  - apt-get --reinstall install 패키지이름   
   
- 패키지 삭제 : 설정파일은 지우지 않음   
  - sudo apt-get remove 패키지이름   
   
- 설정파일까지 모두 지움   
  - sudo apt-get --purge remove 패키지이름   
   
- 패키지 소스코드 다운로드   
  - sudo apt-get source 패키지이름   
   
-  위에서 받은 소스코드를 의존성있게 빌드   
  - sudo apt-get build-dep 패키지이름   
   
- 패키지 검색   
  - sudo apt-cache search 패키지이름   
   
- 패키지 정보 보기   
  - sudo apt-cache show 패키지이름  
  
- 파일 내용 출력(로깅)
  - tail -f {파일이름}

- 시스템 상태정보
  - top

