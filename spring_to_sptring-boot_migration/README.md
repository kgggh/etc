
## 목적

- 외장 tomcat을 내장tomcat으로 변경하기 위함

- maven → gradle로 변경하기 위함



## 기대효과

- 전반적인 개발하는데에 있어 긍정적인 영향(개발속도 등)

-  초기 설정할 필요가 없기에 시간단축.->  .xml에 bean 설정 등등.. 



## 참고 Link

- [참고]https://www.baeldung.com/spring-boot-migration
- [참고]https://www.manty.co.kr/bbs/detail/develop?id=8

## 적용 

1. Dependency 추가

   - spring-boot-starter-web Dependency에 포함된 tomcat은 jsp를 지원하는 엔진이 빠져있다. <br>

      그로인해 따로 jsp를 지원하게끔 tomcat-embed-jasper Dependency를 추가해준다.



2. tomcat-embed-jasper 추가
 
```
<dependency> 

  <groupId>org.apache.tomcat.embed</groupId> 

  <artifactId>tomcat-embed-jasper</artifactId> 

</dependency>

```


3.spring-boot-starter-parent 추가(종속성을 관리하게끔 설정(부모))


```
<parent>

  <groupId>org.springframework.boot</groupId>

  <artifactId>spring-boot-starter-parent</artifactId> 

  <version>1.5.22.RELEASE</version> 

</parent>
```


4.spring-boot-starter-web 추가(web Project)

```
<dependency> 

  <groupId>org.springframework.boot</groupId>

  <artifactId>spring-boot-starter-web</artifactId>

</dependency>
 ```


5.jdbc 및 mybtis dependency 추가

 ```
 <dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-jdbc</artifactId>
</dependency>
```
```
<dependency>
    <groupId>org.mybatis.spring.boot</groupId>
    <artifactId>mybatis-spring-boot-starte</artifactId>
    <version>1.2.3</version>
</dependency>
```


6. Dependency 삭제

```
<artifactId>spring.*</artifactId>
```

 - 기존 artifactId와 같으면 spring-web * 삭제

    → spring-boot-starter-web에 내장


7. Srping-boot Runner class 생성

- Application.java class 생성

  - Application을 구동시키게 할 main class

```
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
```


8. @importResources로 .xml 파일을 위치 수정 및 import해줌(main class)
```
@ImportResource(value = {
        "classpath:applicationContext.xml",    //External-Member
        "classpath:dispatcher-servlet.xml",      //External-API
})
```


9. 파일 위치 변경 → src/main/webapp/WEB-INF → src/main/resources로 변경

- applicatonContext.xml

- dispatcher-servlet.xml

   → 공식 문서에는 XML 설정 보다는 어노테이션을 사용하라고 권고하지만, 자바 설정으로 변경하고 싶지 않다면 @ImportResource 어노테이션으로 가져 올 수 있음.
   

## 추가
- .xml으로 bean에 등록된 Database 및 정적리소드 경로, Encoding등 propertie에 정의해서 쓰면 될거 같아 applicatonContext.xml, dispatcher-servlet.xml
- 현재 JPA가 아니라 mybatis를 사용한다는 전제하에 sqlSessionFactoryBean,SqlSessionTemplate를 빈으로 등록 -> config class로 생성
```
@Configuration
public class MyBatisConfig {

    @Bean
    public SqlSessionTemplate sqlSessionTemplate(SqlSessionFactory sqlSessionFactory){
        return new SqlSessionTemplate(sqlSessionFactory);
    }

    @Bean
    public SqlSessionFactory sqlSessionFactory(DataSource dataSource) throws Exception{
        SqlSessionFactoryBean sqlSessionFactoryBean = new SqlSessionFactoryBean();
        sqlSessionFactoryBean.setDataSource(dataSource);
        sqlSessionFactoryBean.setMapperLocations(
                new PathMatchingResourcePatternResolver()
                        .getResources("classpath:mybatis/*.xml")); //mapper 경로 적어줌.
        return sqlSessionFactoryBean.getObject();
    }
}
```


- application.properties 설정(jsp를 유지한다는 전제하에 html이면 필요없다.)
```
spring.mvc.view.prefix=/WEB-INF/jsp/
spring.mvc.view.suffix=.jsp

#jsp reload
server.servlet.jsp.init-parameters.development=true
```

### 후기

삽질을 하다보니 어느순간 정상적으로 돌아가는 모습을 보니 흐뭇...^^ maven 기반으로 정리를 했는데 gradle로 변경까지 완료<br>
- maven -> gradle로 변경하려면 터미널켜서 해당 프로젝트 pom 위치한 디렉토리에서 gradle init type pom 명령어 쓰면 손쉽게 dependency 적용가능
- 회사 프로젝트들 모두 정리해서 전환해야겠다.... 첨해보는 작업이라 삽질 많이했지만 좋은 경험이라 생각함. 


### 만약 프로젝트가 두개이상이라 jsp 경로를 못찾는다?(intelij 기준)

[참고]https://wedul.site/591 







