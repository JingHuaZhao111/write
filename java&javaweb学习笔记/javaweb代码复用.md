# SpringBoot

## pom.xml复制

### 父pom

```xml
<packaging>pom</packaging>
    <build>
        <plugins>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-compiler-plugin</artifactId>
                <version>3.1</version>
                <configuration>
                    <source>${java.version}</source>
                    <target>${java.version}</target>
                    <encoding>${project.build.sourceEncoding}</encoding>
                </configuration>
            </plugin>
        </plugins>
    </build>

    <properties>
        <maven.compiler.source>8</maven.compiler.source>
        <maven.compiler.target>8</maven.compiler.target>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
        <java.version>1.8</java.version>
    </properties>

    <dependencyManagement>
        <dependencies>
            <!--            SpringBoot的配置依赖-->
            <dependency>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-dependencies</artifactId>
                <version>2.5.0</version>
                <type>pom</type>
                <scope>import</scope>
            </dependency>
            <!--            fastjson-->
<!--            <dependency>
                <groupId>com.alibaba</groupId>
                <artifactId>fastjson</artifactId>
                <version>1.2.33</version>
            </dependency>-->
            <!--            jwt依赖-->
            <dependency>
                <groupId>io.jsonwebtoken</groupId>
                <artifactId>jjwt</artifactId>
                <version>0.9.0</version>
            </dependency>
            <!--            mybatisPlus依赖-->
            <dependency>
                <groupId>com.baomidou</groupId>
                <artifactId>mybatis-plus-boot-starter</artifactId>
                <version>3.4.3</version>
            </dependency>
            <!--            阿里云oss-->
            <dependency>
                <groupId>com.aliyun.oss</groupId>
                <artifactId>aliyun-sdk-oss</artifactId>
                <version>3.10.2</version>
            </dependency>

            <dependency>
                <groupId>com.alibaba</groupId>
                <artifactId>easyexcel</artifactId>
                <version>3.0.5</version>
            </dependency>
            <dependency>
                <groupId>io.springfox</groupId>
                <artifactId>springfox-swagger-ui</artifactId>
                <version>2.9.2</version>
            </dependency>
            <dependency>
                <groupId>io.springfox</groupId>
                <artifactId>springfox-swagger2</artifactId>
                <version>2.9.2</version>
            </dependency>

        </dependencies>
    </dependencyManagement>
```

### 框架pom

```xml
    <dependencies>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </dependency>
<!--        druid连接池-->
        <dependency>
            <groupId>com.alibaba</groupId>
            <artifactId>druid-spring-boot-starter</artifactId>
            <version>1.2.6</version>
        </dependency>
        <!--    lombk-->
        <dependency>
            <groupId>org.projectlombok</groupId>
            <artifactId>lombok</artifactId>
        </dependency>
        <!--    junit-->
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-test</artifactId>
            <scope>test</scope>
        </dependency>
        <!--    springSecurity启动器-->
<!--        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-security</artifactId>
        </dependency>-->
        <!--    redis依赖-->
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-data-redis</artifactId>
        </dependency>
        <!--    fastjson依赖-->
<!--        <dependency>
            <groupId>com.alibaba</groupId>
            <artifactId>fastjson</artifactId>
        </dependency>-->
        <!--    jwt依赖-->
        <dependency>
            <groupId>io.jsonwebtoken</groupId>
            <artifactId>jjwt</artifactId>
        </dependency>
        <!--    mybatisPlus依赖-->
        <dependency>
            <groupId>com.baomidou</groupId>
            <artifactId>mybatis-plus-boot-starter</artifactId>
        </dependency>
        <!--    mysql驱动-->
        <dependency>
            <groupId>mysql</groupId>
            <artifactId>mysql-connector-java</artifactId>
        </dependency>
        <!--    阿里云OSS-->
        <dependency>
            <groupId>com.aliyun.oss</groupId>
            <artifactId>aliyun-sdk-oss</artifactId>
        </dependency>
        <!--    AOP-->
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-aop</artifactId>
        </dependency>

        <dependency>
            <groupId>com.alibaba</groupId>
            <artifactId>easyexcel</artifactId>
        </dependency>

        <dependency>
            <groupId>io.springfox</groupId>
            <artifactId>springfox-swagger2</artifactId>
        </dependency>
    </dependencies>
```

### 配置提示

```xml
<!--        配置提示-->
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-configuration-processor</artifactId>
            <optional>true</optional>
        </dependency>
```

运行一次才有提示

## 接口统一相应格式

```java
@Data
@JsonInclude(JsonInclude.Include.NON_NULL)
public class ResponseResult<T> implements Serializable {
    private Integer code;
    private String msg;
    private T data;

    public ResponseResult(){
        this.code= AppHttpCodeEnum.SUCCESS.getCode();
        this.msg=AppHttpCodeEnum.SUCCESS.getMsg();
    }

    public ResponseResult(Integer code,T data){
        this.code=code;
        this.data=data;
    }

    public ResponseResult(Integer code,String msg,T data){
        this.code=code;
        this.msg=msg;
        this.data=data;
    }

    public static ResponseResult errorResult(int code, String msg) {
        ResponseResult result = new ResponseResult();
        return result.error(code, msg);
    }
    public static ResponseResult okResult() {
        ResponseResult result = new ResponseResult();
        return result;
    }
    public static ResponseResult okResult(int code, String msg) {
        ResponseResult result = new ResponseResult();
        return result.ok(code, null, msg);
    }

    public static ResponseResult okResult(Object data) {
        ResponseResult result = setAppHttpCodeEnum(AppHttpCodeEnum.SUCCESS, AppHttpCodeEnum.SUCCESS.getMsg());
        if(data!=null) {
            result.setData(data);
        }
        return result;
    }

    public static ResponseResult errorResult(AppHttpCodeEnum enums){
        return setAppHttpCodeEnum(enums,enums.getMsg());
    }

    public static ResponseResult errorResult(AppHttpCodeEnum enums, String msg){
        return setAppHttpCodeEnum(enums,msg);
    }

    public static ResponseResult setAppHttpCodeEnum(AppHttpCodeEnum enums){
        return okResult(enums.getCode(),enums.getMsg());
    }

    private static ResponseResult setAppHttpCodeEnum(AppHttpCodeEnum enums, String msg){
        return okResult(enums.getCode(),msg);
    }

    public ResponseResult<?> error(Integer code, String msg) {
        this.code = code;
        this.msg = msg;
        return this;
    }

    public ResponseResult<?> ok(Integer code, T data) {
        this.code = code;
        this.data = data;
        return this;
    }

    public ResponseResult<?> ok(Integer code, T data, String msg) {
        this.code = code;
        this.data = data;
        this.msg = msg;
        return this;
    }

    public ResponseResult<?> ok(T data) {
        this.data = data;
        return this;
    }

}
```

```java
public enum AppHttpCodeEnum {

    //成功
    SUCCESS (200,"操作成功"),

    //登录
    NEED_LOGIN(401,"需要身份认证"),
    NO_OPERATOR_AUTH(403,"无权限操作"),
    SYSTEM_ERROR(500,"服务器错误"),
    USERNAME_EXIST(602,"用户名存在"),EMAIL_EXIST(603,"邮箱存在"),
    REQUIRE_USERNAME(601,"未填写用户名"),
    REQUIRE_Email(604,"未填写邮箱"),
    REQUIRE_PASSWORD(605,"未填写密码"),
    WRONG_PARAMETER(606,"用户名或密码或邮箱错误");
    AppHttpCodeEnum(int code,String errorMessage){
        this.code=code;
        this.msg=errorMessage;
    }
    private int code;
    private String msg;
    public int getCode() {
        return code;
    }

    public String getMsg() {
        return msg;
    }
}
```

## 跨域请求

写在相关配置类中

```java
@Configuration
public class CorsConfig implements WebMvcConfigurer {

    @Override
    public void addCorsMappings(CorsRegistry registry) {
        //设置允许跨域的路径
        registry.addMapping("/**")
                //设置允许跨域请求的域名
                .allowedOrigins("*")
                //是否允许携带cookie
                .allowCredentials(true)
                //设置允许的请求方式
                .allowedMethods("GET","POST","DELETE","PUT")
                //设置允许的header属性
                .allowedHeaders("*")
                //跨域允许的时间
                .maxAge(3600);

    }
}
```

## Token相关

### 工具类

```java
public class TokenUtil {
    public static String createToken(String id, String subject, Long registrationTime) {
        if(registrationTime==null){
            registrationTime=USER_REGISTRATION_TIME;
        }
        SecretKey secretKey = generalKey();
        //唯一ID  主题可以是json数据 签发时间 签发人 签发密钥 过期时间
        JwtBuilder jwtBuilder = Jwts.builder()
                .setId(id)
                .setSubject(subject)
                .setIssuedAt(new Date())
                .setIssuer(SIGN_PERSON)
                .signWith(SIGNATURE_ALGORITHM,secretKey)
                .setExpiration(new Date(System.currentTimeMillis()+registrationTime));
        return jwtBuilder.compact();
    }

    /*
    * 生成加密后的密钥secretKey
    * */
    public static SecretKey generalKey(){
        byte[] encodedKey = Base64.getDecoder().decode(SECRET_KEY);
        SecretKey key = new SecretKeySpec(encodedKey,0,encodedKey.length,"AES");
        System.out.println(key.getEncoded());
        return key;
    }

    /*
    * 解析
    * */
    public static Claims parseToken(String token) throws Exception{
        SecretKey secretKey = generalKey();
        return Jwts.parser()
                .setSigningKey(secretKey)
                .parseClaimsJws(token)
                .getBody();
    }
    /*    public static void main(String[] args) {
        String token = TokenUtil.createToken(UUID.randomUUID().toString().replace("-", ""), "aaa", null);
        System.out.println(token);
//        解析token
        try {
            Claims claims = TokenUtil.parseToken(token);
            String subject = claims.getSubject();
            System.out.println(subject);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }*/
}
```

### 拦截器

```java
@Configuration
public class LoginConfig implements WebMvcConfigurer {
    @Autowired
    private LoginInterceptor loginInterceptor;

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        //添加拦截器
        //配置拦截路径
        registry.addInterceptor(loginInterceptor)
                .addPathPatterns(PATH_PATTERNS)
                .excludePathPatterns(EXCLUDE_PATH_PATTERNS);
    }
}
```

## 异常处理

```java
//LoginIntercepter
@Component
public class LoginInterceptor implements HandlerInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        //获取请求头中的token
        String token = request.getHeader("token");
        //判断token是否为空,如果为空也代表未登录
        if(!StringUtils.hasText(token)){
            //ResponseResult responseResult = ResponseResult.errorResult(NEED_LOGIN);
            //response.sendError(HttpServletResponse.SC_UNAUTHORIZED);
            throw new RuntimeException(NO_OPERATOR_AUTH.getMsg());
        }
        //解析token是否成功
        try {
            //如果解析无异常说明登录状态
            Claims claims = TokenUtil.parseToken(token);
            String id = claims.getId();
            System.out.println(id);
        } catch (Exception e) {
            //如果出现异常说明未登录提示重新登陆NEED_LOGIN
            e.printStackTrace();
            throw new RuntimeException(NO_OPERATOR_AUTH.getMsg());
        }
        return true;
    }
}
```

```java
@ControllerAdvice
public class MyControllerAdvice {

    @ExceptionHandler(RuntimeException.class)
    @ResponseBody
    public ResponseResult handlerException(Exception e){
    //获取异常信息,存放msg属性
        String message=e.getMessage();
        if(NO_OPERATOR_AUTH.getMsg().equals(message)){
            ResponseResult result = ResponseResult.errorResult(NO_OPERATOR_AUTH);
            //把ResponseResult作为返回值返回,要求到时候转成json存入响应体中
            return result;
        }
return null;
    }
}
```