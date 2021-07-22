
## 목적

외장 tomcat을 내장tomcat으로 변경하기 위함

 maven → gradle로 변경하기 위함

## 기대효과

전반적인 개발하는데에 있어 긍정적인 영향(개발속도 등)

전반적으로 초기 설정할 필요가 없기에 시간단축.->  .xml 설정 등등.. 

참고 Link

from spring to spring-boot migration

스프링 -> 스프링부트

적용 

Dependency 추가

     → spring-boot-starter-web Dependency에 포함된 tomcat은 jsp를 지원하는 엔진이 빠져있다. 

         그로인해 따로 jsp를 지원하게끔 tomcat-embed-jasper Dependency를 추가해준다.

tomcat-embed-jasper 추가

<dependency> 

<groupId>org.apache.tomcat.embed</groupId> 

<artifactId>tomcat-embed-jasper</artifactId> 

</dependency>

spring-boot-starter-parent 추가(종속성을 관리하게끔 설정(부모))

<parent>

<groupId>org.springframework.boot</groupId>

 <artifactId>spring-boot-starter-parent</artifactId> 

<version>1.5.22.RELEASE</version> 

</parent>

spring-boot-starter-web 추가(web Project)

<dependency> 

<groupId>org.springframework.boot</groupId>

 <artifactId>spring-boot-starter-web</artifactId>

 </dependency>

2. Dependency 삭제

<artifactId>spring-web*</artifactId>기존 artifactId와 같으면 spring-web * 삭제

    → spring-boot-starter-web에 내장

3. Srping-boot Runner class 생성

   pakage에 최상위에 Application.java class 생성

    →  Application을 구동시키게 할 main class

@ImportResource(value = {
        "classpath:applicationContext.xml",    //External-Member
        "classpath:dispatcher-servlet.xml",      //External-API
})
@SpringBootApplication
public class Application {
    public static void main(String[] args){
        SpringApplication.run(Application.class,args);
    }
}


4. @importResources로 .xml 파일을 위치 수정 및 import해줌(main class)

@ImportResource(value = {
        "classpath:applicationContext.xml",    //External-Member
        "classpath:dispatcher-servlet.xml",      //External-API
})

파일 위치 변경 → src/main/webapp/WEB-INF → src/main/resources로 변경

applicatonContext.xml

dispatcher-servlet.xml

   → 공식 문서에는 XML 설정 보다는 어노테이션을 사용하라고 권고하지만, 자바 설정으로 변경하고 싶지 않다면 @ImportResource 어노테이션으로 가져 올 수 있음.

