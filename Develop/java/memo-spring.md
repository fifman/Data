# beans

## wrapper

### cache
1. spring会通过classloader进行bean信息缓存，缓存PropertyDescriptor。
2. 缓存为spring自有的。推荐spring jar包和应用包通过同一个classloader加载。否则，考虑在web.xml声明本地org.springframework.web.util.IntrospectorCleanupListener。

# Context
1. 依赖注入：解耦。

## BeanFactory

## ApplicationContext
1. GenericGroovyApplicationContext, ClassPathXmlApplicationContext
2. GenericApplicationContext: 通过reader读取不同的配置，通用

### bean配置
1. names
    + name="a,b,c": 设置多个alias
    + id="xxx": 设置bean名，唯一
    + `<alias name="xx" alias="yy"></alias>`: 设置alias
2. class
    + 静态子类：com.example.Foo$Bar
    + 静态工厂方法：`<bean id="clientService" class="examples.ClientService" factory-method="createInstance"/>`
3. 依赖注入：
    + 构造器：

    <bean id="foo" class="x.y.Foo">
        <constructor-arg ref="bar"/>
        <constructor-arg ref="baz"/> 
    </bean>
    
    <bean id="exampleBean" class="examples.ExampleBean">
        <constructor-arg type="int" value="7500000"/>
        <constructor-arg type="java.lang.String" value="42"/>
    </bean>

    <bean id="exampleBean" class="examples.ExampleBean"> 
        <constructor-arg index="0" value="7500000"/> 
        <constructor-arg index="1" value="42"/>
    </bean>

    + setter:
    + 通过构造器设置必要依赖，setter设置可选依赖是一个比较好的实现
    + 依赖处理流程：
        - ApplicationContext创建，并初始化，读取bean元数据（没创建bean）
        - 创建bean，并提供依赖
        - 依赖值被转换为bean需要的类型
        - 单例，预实例化（默认）的bean在创建context时创建，否则，只有bean被请求时才创建
4. bean配置细节
    + p-namespace：取代`<property/>`
    + c-namespace  取代`<constructor-arg>`
    + 属性名可以nested：`<property name="x.y.z" value="1"/>`
        - 要让nested属性可用，需要bean创建后，x，x.y都非空，否则抛出错误。
    + 非明显依赖关系，可用depends-on，确保被depend的对象在需要依赖的对象之前创建
    + lazy-init：bean不是一开始就实例化，而是第一次被请求时实例化
    + method-injection
5. bean scopes

    |scope          |说明                                                |举例                                 |  
    |---------------|----------------------------------------------------|-------------------------------------|  
    |singleton      |单例                                                |                                     |  
    |scope          |每次依赖注入，或者getBean()，都生成新实例           |                                     | 
    |request        |仅限web上下文，每次http请求，一个新实例             |Action                               | 
    |session        |仅限web上下文，每个session                          |userPreferrences                     |
    |globalSession  |仅限portlet上下文                                   |                                     |  
    |application    |仅限web上下文，每个ServletContext生命周期一个实例   |不是springcontext，而是servletcontext|
    |websocket      |仅限web上下文，websocket生命周期                    |                                     | 
    |singleton      |单例                                                |                                     |  

    + scoped bean作为依赖：bean A拥有依赖bean B，但是A的scope是单例，B的scope是request，此时就需要代理，否则B在request请求完成后需要销毁，A的依赖就受破坏了。需要代理C，代理类B的public接口，作为A的依赖。可使用`<aop:scoped-proxy/>`
6. lifecycle callbacks
    + InitializingBean接口，afterPropertySet()方法；DisposableBean接口，destroy方法。
    + xml: init-method
    + annotation: @PostConstruct
    + JavaConfig: @Bean.initMethod
    + LifeCycle接口，包含start、stop、isRunning方法
    + SmartLifeCycle：可对auto-startup反应，提供phase，确立启动优先级。
    + ConfigurableApplicationContext.registerShutdownHook()：提供生命钩子和JVM关联，保证退出程序时各个Bean的毁灭方法被调用。web应用已经默认采取，无需调用此方法。

7. inherit
    + 继承scope、构造器参数、属性值、init-method、destroy-method、factory-method
    + 不继承depends on、autowire、dependency check、lazy-init
    + 通过abstract参数，可使父bean纯粹为配置，不指定对象class。

8. container扩展
    + BeanPostProcessor
    + BeanFactoryPostProcessor
    + Ordered接口用于定义顺序
    + PropertyPlaceholderConfigurer: 使用properties文件定义bean属性

### Annotation
    + 通过BeanPostProcessor加载annotated beans
    + Component、Repository、Service、Controller
    + meta-annotations：使annotation能够组合
    + `<context:component-scan base-package="org.example"/>`
    + custom filter扫描组件
    + 扫描可采取策略，自动为组件取名
