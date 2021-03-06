# start

## install

1. centos: `yum install java-1.8...` (notice that the version should be "devel" otherwise you will not find "javac")

## environment

1. jenv
2. /usr/libexec/java_home -V: 查看版本

# groovy

## syntax

### comments

- in-line: `//`
- multi-line: `/* */` can be put inside codes (e.g. `a = /* xx */ b`)
- shebang line: `#!/usr/bin/env groovy`
- doc: `/** */`

### identifiers

- normal identifiers: 
    * identifier = [letter|$|_][letter|number]*
    * letter = [a-z,A-Z,'\u00C0'-'\u00D6','\u00D8'-'\u00F6','\u00F8'-'\u00FF','\u0100'-'\uFFFE']
    * should not start with number
- quote identifier:
    * following a dot
    * can contain illegal characters, e.g. `obj."aa bb" = "xx"`

### String

- single/double quote: `'aaa'` == `"aaa"`
- triple quote: multi-line, without interpolation: `'''aaa xxx'''`

## grammar

- default imports are already set, no need to declare `import ...`.
- runtime dispath (multi-methods): method is chosen at runtime by argument types.
- `{}` is used for closures. Arrays use `[]`.
- no field modifier: define a property with getter/setter.
- package private field: annotate with `@PackageScope`.

## command chains

- a b c d == a(b).c(d)
- `,`, `:`, `.` joins parts together to elements, e.g.:
    > a b, c d e: f g h.i == a(b, c).d(e: f).g(h.i)

- closures can be used as arguments, e.g.:
    > a {} b {} c {} == a({}).b({}).c({})

- method with no arguments should use `()`, e.g.:
    > a b() c d() == a(b()).c(d())

- odd elements means the last one is attribute access, e.g.:
    > a b c == a(b).c

# gradle

## cli

- `gradle dependencies --configuration compile`: compile dependencies

    >gradle -q dependencies api:dependencies webapp:dependencies

- `gradle help --task test`: help task
- `gradle -q projects`: show projects info
- `gradle -q tasks`: show **visible** tasks

    **visible**: By default, shows only those tasks which have been assigned to a task group, so-called visible tasks. You can do this by setting the group property for the task. You can also set the description property, to provide a description to be included in the report

    ```groovy
    dists {
        description = 'Builds the distribution'
        group = 'build'
    }
    ```

    `-all`: shows **hidden** tasks

- `gradle dependencyInsight`: give insight of dependencies
    
    >gradle -q webapp:dependencyInsight --dependency groovy --configuration compile

- `gradle properties`: show project properties

- `--profile`     : give reports to build
- `-m`            : dry run, only show tasks which will be run, do not actually run tasks
- `-x`            : skip test
- `--continue`    : continue tasks over failed ones
- `-b`            : choose build file
- `-p`            : choose build root folder
- `--rerun-tasks` : force tasks to rerun regardless of cache

## console

### build output

- After gradle 4.0, outputs are reduced. `--console=plain` can give outputs unreduced.
- outputs are grouped for parallel execution.
- parallel execution may cause output broken up, but each output block will have indication to tasks.

### works in-progress

- workers in parallel executions: number of workers defaults to number of processors on the machine executing the build.
- parallel execute tasks, workers unused are marked `IDLE`

## gradle wrapper

- wrapper should **check** into version control
- `gradle wrapper`: init wrapper to project
- config `wrapper` task:
    
    ```groovy
    task wrapper(type: Wrapper) {
        gradleVersion = '2.0'
    }
    ```

## gradle daemon

- `--status`: check daemon status
- disable daemon: append sentence:

    > org.gradle.daemon=false

    to `${USER_HOME}/.gradle/gradle.properties`

- `--stop`: stop **all** daemons with the **same version** of gradle running the command
    > jps  

- `--daemon`/`--no-daemon`: enable/disable daemon in build
- new daemons may be created if not idle or not compatible (e.g. heap size not satisfied)

## dependency

### configuration

- configuration: a set of dependencies and artifacts (input and output)
- default configurations:
    * implementation: declaring dependencies
    * runtimeClasspath: resloving dependencies
    * apiElement: publish artifacts

### external dependency

```groovy
dependencies {
    compile group: 'org.hibernate', name: 'hibernate-core', version: '3.6.7.Final'
    compile 'org.hibernate:hibernate-core:3.6.7.Final'
}
```

### repository


```groovy
repositories {
    maven {
        // URL can refer to a local directory
        url "../local-repo"
        url "http://repo.mycompany.com/maven2"            
        mavenCentral()            
    }
}
```

### publishing artifacts

```groovy
uploadArchives {
    repositories {
        ivy {
            credentials {
                username "username"
                password "pw"
            }
            url "http://repo.mycompany.com"
        }
    }
}
```

run `gradle uploadArchives`

## multi-project build

### structure

root or master dir:
- settings.gradle: describe how the project and sub-projects are structured
- build.gradle: build config
- child dirs with `*.gradle` file (not necessarily)

set `rootProject.name` 

### run task

To see a list of the tasks of a project, run gradle `<project-path>:tasks`
For example, try running `gradle :api:tasks`

root build.gralde share settings to child configs

run sub-project task: `gradle :services:webservice:build`

run task in a dir will run all tasks in sub-dir. If use wrapper, should use `../../gradlew build`

## build script

### project and task

project: a set of things to be done
task: atomic piece of work





# java environment

## 安装：

brew tap caskroom/versions
brew install java7
brew install java6

# 基础

### String处理

String对象不可修改。因此诸如"aa"+"bb"+"cc"的连续操作时，其实可能是（根据JVM不同实现可能不一样）先生成了"aa"+"bb"的结果的临时对象，然后生成结果。
编译器有可能自动采取聪明的做法，内部使用StringBuilder。
即使如此，显式调用StringBuilder更能保证性能。因为编译器不能保证它能“聪明”地在所有情况下使用StringBuilder。例如在循环时，每次循环都会新生成StringBuilder。

StringBuffer.append()性能比StringBuilder要低，但能保证操作原子性。

预先指定StringBuffer大小可避免多次重新分配缓冲。


# 语法

## 后期绑定

java默认后期绑定，调用方法时，实际调用的代码最后时刻才被确定。编译器确保方法存在并执行类型检查，但此时不知道确切代码。因此可以实现向上转型。
非面向对象编程使用前期绑定，编译器知道具体执行代码绝对地址。
c++默认前期绑定，使用virtual关键字才能实现后期绑定。

## 单根继承

所有java类继承Object。c++则不是。

参数化类型（泛型）

## 对象标识符：

对象的引用。例如：
String s;
这里创建了一个对象标志符s，s为一个引用（没有指定对象，单独存在）。
创建数组对象实际上是创建了一个引用数组，每个引用被自动初始化为null。
也可以创建基本数据类型的数组。

java所有数值类型都有正负号
高精度数值类BigDecimal和BigInteger没有对应的基本类型。高精度支持任意精度。

作用域：
作用域由花括号{}决定。决定了内部定义的变量名（引用）的生命周期。
在作用域内创建的非基本对象的生命周期则不取决于作用域。

import:

java.lang自动导入

操作符：

几乎所有操作符只能操作基本类型。但"="，"=="，"!=" 能操作所有对象。String支持"+"和"+="。

字符串转换：

"+"可以执行字符串转换。当a+b中，a为String类型，b非String时，会将b转成String。注意String类型必须在前面。

=号：

等号左边必须是已命名的变量。a=4, 不能4=a。右边必须能生成一个值。

允许a=b=c=1。实际效果：a=(b=(c=1))

值传递：

基本数值直接传递。传递双方可以继续操作、修改，互不受影响。对象值传递传递的是引用，传递双方会共享一个对象，修改会相互影响。


算数操作：

整数除法/会直接去掉小数位。

一元+号（表示正值）唯一的作用就是将较小类型的操作数提升为int。

对象比较：

"=="、"!="比较的是对象的引用。
Object.equals()默认行为是比较引用！但一些类里面覆盖了此行为（例如Integer）！

逻辑运算符短路：

条件1 && 条件2 && 条件3，如果条件2为false，则条件3不执行。


数值类型描述：

1.1D, 3L, 0.1F
有时候编译器默认类型不对，需要字符显式指定。

三元操作符ifelse

boolean ? v1 : v2

按位操作符：& |  逻辑操作符：&& ||

## 修饰符

private指除了包含此成员的类，其它任何类都无法访问。
protected提供包访问权限。同包类可以访问。
类不可以private或protected，内部类除外。

没有public修饰的类，其static成员如果是public，还是可以被外部访问。


# JVM

## 存储位置

寄存器：java不能直接控制。
堆栈：java对象不存储，对象引用在里面。
堆：所有java对象存储位置。

常量通常直接放在程序代码内部。
基本类型变量不是引用，直接存储值，放在堆栈中。
基本类型包装器类可在堆中创建对象。

# middleware


## tomcat

tomcat install:
1. download
2. dir: /usr/local/tomcat
3. 用户\组创建
4. systemctl 
5. tomcat user setting
6. tomcat manager app META-INF/context.xml setting

## rmi

java.rmi.ConnectException: Connection refused to host: 127.0.0.1;
需要设置-Djava.rmi.server.hostname=myserver.com

## weblogic

### weblogic install

#### linux install

1. add `-Dweblogic.management.allowPasswordEcho=true` to domain creating command
1. add `-Djava.security.egd=file:/dev/./urandom` to  ${DOMAIN_HOME}/bin/startWeblogic.sh, in start command
2. add `USER_MEM_ARGS="-Xms1024m -Xmx1024m -XX:MaxPermSize=512m"` to ${DOMAIN_HOME}/bin/setDomainEnv.sh, before `USER_MEM_ARGS=${USER_MEM_ARGS} ...`


weblogic password change:
1. 删除adminserver下所有文件
2. 新建security文件夹
3. 创建boot.properties文件
4. 写入
    username=xxx
    password=xxx


java文件：编译单元compile unit。每个编译单元内只能有唯一的public类，类名必须和文件名相同。

java解释器根据环境变量classpath找类文件。如果类在一个文件夹下，直接放地址。如果是jar包，地址需要包含jar本身的文件名。classpath中包含"."，解释器就会找当前目录。

打印时，对象toString()方法可以在对象本身为null时调用，输出null。（存疑，需测试）

子类实例包含了一个基类的子实例。初始化时，基类子实例先被初始化，然后才是子类自己的初始化。

类型转换：
窄化转换：父类转为子类
扩展转换：子类转为父类
java允许把任何基本数据类型转为别的基本数据类型，除了bool类型外。
数值类型转换时值会截尾而不是四舍五入。

java所有数据类型的大小是设计好的，在不同环境下相同。

bool值的能执行运算很有限，只能赋值true或false，并测试真假。不能加减乘除或其他运算。

两个大int值乘法可能溢出！

for(init;bool;step)语句中，三个语句init,bool,step都可以为空。第一次迭代前执行一次init，每次迭代前执行bool判断，迭代后执行step。三个语句都可以经由逗号操作符分隔成子语句的串联。注意java中只有for循环能够使用逗号操作符！（逗号操作符和逗号分隔符不同。逗号分隔符可用于多个参数定义。）

foreach:
可用于任何Iterable对象和数组。

标签：
break和continue只跳出最下层循环。但加上标签后，可跳出多级循环。如:
label1: //不能在后面加语句
for(...){
    for(...){
        ...
        break label1;
    }
}

continue会执行step语句。break则不执行。如果是continue上级标签，则底层step语句不执行。

switch:
只能接受整数值或枚举。除了default外，其余case分支要加break，否则会接着执行下面的case语句。

方法重载：同方法名，不同参数。
两个方法参数分别为父子类，则优先子类。

构造器调构造器时，被调用构造器必须放在方法体最前。

finalize():
垃圾回收器准备好释放对象的存储空间时，会先调用finalize()方法，然后执行垃圾回收。
对象不一定被垃圾回收，只有垃圾回收执行了，finalize()方法才被调用。
java创建的对象都会被垃圾回收，所以需要使用finalize()的情况，很多时候是需要调用“本地方法”时。即java调用非java方法时。
绝对不能直接调用finalize()。此方法是为垃圾回收器调用的。

初始化：
类里定义属性为对象引用时，初始值默认为Null。
属性初始化时存在顺序，要注意向前引用。
属性自动初始化在构造器初始化前发生，即使它们的定义位置夹杂在方法之间。
只有访问类时才进行类加载。静态初始化在类加载的时候执行，只执行一次。最先执行。
静态块和静态属性类似，只执行一次。
java中同样可以有非静态块。在构造器前，属性自动初始化后执行。

数组：
int[] a;
int a[];两种格式都可以。
只有初始化时，可以使用表达式{}。如int[] a =
{1,2,3};表达式必须和定义类型int[]一起使用。new int[5]类似。但new
int[]{1,2}能在任何情况下使用。
数组传递是引用传递。
非基本类型对象数组是一个引用数组。
基本类型数组new了后会自动初始化。

可变参数列表：
如果传的本身是数组，则直接使用数组。
如果传的是一组值，则先将值拼装成数组。
可以不传值。此时生成一个长度为0的数组，而不是null。
可变参数可以和一般参数混合使用。但似乎只能放最后。
可变单数重载可能造成问题，需要注意。尤其在参数可为空的现状下。

final:
final对象指引用不变，对象内部可变。
必须在定义处或每个构造器给final属性赋值。
数组也是对象，final表示引用不变。

多态
和“动态绑定”、“后期绑定”、“运行时绑定”同义
多态只作用于方法，域不是多态。

绑定
方法调用和实际方法体的关联。在程序执行前绑定成为前期绑定，C只有前期绑定。java的static方法和final方法（private方法都是final）前期绑定，其它后期绑定。

非private方法才能覆盖。子类同名方法被认为是新成员。

类加载在访问类static成员时发生。构造器其实是隐性的静态成员。（但是构造器可以调用非静态属性和方法。）

复杂对象初始化顺序：
1. 调用基类构造器
2. 按声明顺序初始化属性
3. 调用导出类构造器主体

继承清理方法后，清理方法内记得调用父类的清理方法，否则父类不被清理。

构造器中调用覆盖方法可能会造成错误。基类构造时直接调用了子类的覆盖方法！

协变返回类型
覆盖方法的返回类可以为基方法返回类的子类。

接口中的域是隐性static、final的，方法都是隐性public的，不需要public关键字。



# 并发 #
java没有使用进程，而是使用基于顺序编程的线程来实现并发。这是为了OS透明性。有些OS不支持多进程。

java主线程中不会引用创建的分线程。每个线程“引用”自身，所以不会被垃圾回收，除非线程停止。
Thread中执行的Task中抛出的异常不会传播到main，因此需要每个Task主动catch、处理异常。
sleep()会抛出InterruptedException。在sleep时，scheduler会切换线程。
setPiority()要放在run()里面，否则当前进程不对。

daemon thread:
    只要有一个非daemon线程在运行，daemon threads就不会终止。但只要所有非daemon threads完成，daemon threads就会终止。    线程为daemon时，它创建的新线程也为daemon。
    daemon线程不会执行finally clause！！！

不要在构造器中start()。因为对象构造还未完成，线程可能访问不稳定的对象。

join():
    在一个线程中可以call另一个线程t的t.join()。此时caller线程会suspend，并等待线程t执行完再执行。
    join()里可以传递时间参数，待时间完后不管t是否执行完，都返回。
    t.interrupt()可以打断join()。因此join()需要try-catch块。

主线程中不能catch子线程中抛出的异常，需要用到Thread.UncaughtExceptionHandler。

线程之间不应互相依赖，因为无法保证线程之间的顺序以及线程仍然有效（没有异常抛出或停止）。

++、--等自我递增、递减操作是非原子操作！！！因此可能发生并发问题。

mutex：互斥锁

synchronized：一旦一个object的一个synchronized方法被调用，那么所有其它此object的synchronized方法都不能访问。任何对象都存在一个简单锁。

synchronized static方法对class有一个锁。因此能避免线程冲突。

注意：锁住的对象的非synchronized方法仍然能访问。

显式lock：
lock.unlock()必须在try-catch语句的finally clause中，否则可能无法释放。
方法必须在try块里返回，否则unlock先于return执行，存在暴露资源的风险。
显式lock更灵活，能够多次尝试获取Lock，设置获取lock失败后的处置，等等，这样能缓解synchronized方法带来的阻塞。通过finally clause，能够让程序在方法异常后整理状态。

word-tearing：对于“简单操作”和大部分主类型来说，是原子操作。但是，在读写long和double类型数据时，JVM有可能分两次操作（64bit分成两个32bit）。用volatile关键字定义变量（JSE5前不正确）后可避免这一点，实现原子操作（注意是原子操作，不是线程安全）。

原子操作不一定是线程安全的。

多核系统中，visibility很关键。一个核中的某任务的操作，即使是原子性的，也未必被其它核可见，因为有可能存储在单核的缓存中。但同步机制强制操作结果在应用范围内可见。volatile关键字也可保证可视性，即使存在本地cache。它强制属性读写发生在主memory。

如果有多个任务对一个field直接访问，那么需要volatile关键词，否则只需要synchronized保护即可。任务本身的操作对任务必然可见，所以如果只有一个任务直接访问field，那么不需要volatile关键词。

volatile在field的值取决于之前的值时失效（例如++，--等递增、递减操作）。当field的值被其它field约束时也失效。典型的应用volatile关键词的场景是类只存在一个可变field时。

volatile禁止field被缓存，读写直接发生在主memory，同时禁止compiler优化访问顺序。但它不能保证原子性。当多个任务（此处的任务自然指线程任务）能够直接访问field，并至少有一个任务要写时，需要用到volatile。

synchronized块：
能使用synchronized块。隐式块需要一个对象的锁，显式块直接调用ReentrantLock对象。

使用Threadlocal可以使不同线程访问同一个变量的不同储存。每个线程都会获得一个此变量的local储存。

线程四状态：新建、可执行、阻塞、死亡。
阻塞原因：
    sleep();
    wait();
    等待I/O执行完毕
    线程等待获取锁。（想执行synchronized方法但被锁住）
在阻塞过程中打断，可用interrupt方法。此时会抛出InterruptedException。
interrupt方法被调用时，如果线程处于阻塞状态，会抛出InterruptedException，否则不抛出。如果线程当时不在阻塞状态，继续往下执行，直到等它执行到阻塞块时，就会抛出异常。否则会正常执行下去。
Executor对象的shutdownNow()方法可以cancel所有它执行的线程。如果只想cancel一个线程，需要用submit()返回一个Future对象。调Future对象的cancel()方法来cancel。

IO和synchronized阻塞是无法打断的。一个本办法是在发送打断时同时关闭IO资源，可以避免阻塞。此时需要注意的是，线程不一定会处于“打断”状态。例如，Socket会处于打断状态，而System.in则会处于停止，isInterrupted()为false。
nio类则可以直接打断，不需要关闭IO资源。

同一个线程可以调用锁对象的多个不同的同步方法，不需要等锁释放。

任务被ReentrantLock阻塞时可以打断。（JSE5新特性。）打断后ReentrantLock的lockInterruptibly()方法会抛出InterruptedException异常。需要用lockInterruptibly()方法。

thread.interrupt()只在thread处于阻塞时有效。thread不在阻塞状态时，interrupt()无效。interrupt()会设置interrupted状态。通过调用interrupted()方法，不仅能检查interrupted状态，而且会清除此状态。

检查Interrupted状态的通常做法：
try{
    while(!Thread.interrupted()){ // Thread.interrupted()方法判断thread是否处于打断状态。
        try{
            create object!
        }finally{   //在此处需要finally clause，用来清理对象。注意没有catch clause！
            cleanup objects!
        }
    }
}catch(InterruptedException ex){
}finally{
}

busy waiting: idle循环检查状态，导致cpu空转。
sleep()和yield()不会释放对象锁。wait()会。wait()、notify()方法只能在synchronized方法或块中使用。否则运行时会抛异常。
        while (waxOn == false)
            wait();
通常需要使用while来判断标志位，使得wait()方法发生在正确的状态。也就是说，每次通过notify()苏醒时，任务不应该马上执行，而是需要判断是否处于正确的状态，有正确的理由执行下一步。如果不是，则需要继续wait()直到正确的理由成立。因此，需要while语句来进行判断，是否可以执行下一步。

可能出错：
while(condition){
    //point 1
    synchronized(obj){
        obj.wait();
    }
}
因为while语句没有被synchronized，point 1时线程可能会切换到另一个线程。此时另一个线程发出notify()，导致notify在wait前发送，被忽略。从而无限循环下去。正确做法：
synchronized(obj){
    while(condition)
        obj.wait();
}

LinkedBlockingQuene：无限多元素
ArrayBlockingQuene：有限个元素

thread.run()会直接在本地线程中执行，而不是产生一个新线程。此时其实就是普通的对象方法调用。

PipedReader是可打断的，不同于通常的I/O接口。

死锁：死循环。任务在等待下一个任务解锁，而下一个任务又等待其它任务，直到最后等待第一个任务解锁。

当以下四种情况出现时，可能发生死锁：
1. 资源互斥：资源被一个任务消费时，其它任务不能共享。
2. 至少有一个任务，掌握一个资源，同时在等待另一个资源。
3. 资源无法被强制释放。任务只能被动等待资源释放。
4. 可能出现循环等待。

java library的方法是否线程安全？需要自己注意，case-by-case。

CountDownLatch：countDown()计数，计到0时解锁，await()结束。
CyclicBarrier：多任务平行进行，所有任务调用await()后才能执行下一步。然后循环往复。
DelayQuene: 按照截止日期先后排序
PriorityBlockingQueue：优先级队列。
Collections.synchronizedList()将List的方法synchronized。
Semaphore：限制访问的任务数。到上限后阻塞。
Exchanger：当exchange()被执行一次时阻塞，直到第二次执行时数据交换。

性能分析：Lock比synchronized一般来说更有效，而且性能更稳定。synchronized性能不稳定。
AtomicObjects一般只用于一个属性，多属性时不要使用多个。

Lock-free容器：修改容器和读容器可同时发生，但读只能读取“完成了”的修改。正在发生的修改是不会被读取的：
CopyOnWriteArrayList
CopyOnWriteArraySet
ConcurrentHashMap
ConcurrentLinkedQueue

ReadWriteLock：写发生很少，读发生很多时，可以尝试。


= I/O =

InputStream\OutputStream需要被FilterInputStream、FilterOutputStream装饰后才能形成可用IO接口:
DataInputStream，BufferedInputStream：两种FilterInputStream
DataInputStream用于读取主类型数据。

FilterOutputStream：
DataOutputStream、PrintStream、BufferedOutputStream
PrintStream：形成格式化输出。但存在一些问题，例如异常处理、国际化、跨平台的格式化等。PrintWriter更好。

InputStream、OutputStream基于byte，Reader、Writer基于字符。
InputStreamReader将InputStream转换成Reader，OutputStreamWriter将OutputStream转换成Writer。

Sources & sinks: Java 1.0 class:
Corresponding Java 1.1 class
InputStream
Reader
adapter:
InputStreamReader
OutputStream
Writer
adapter:
OutputStreamWriter
FilelnputStream
FileReader
FileOutputStream
FileWriter
StringBufferlnputStream
(deprecated)
StringReader
(no corresponding class)
StringWriter
ByteArrayInputStream
CharArrayReader
ByteArrayOutputStream
CharArrayWriter
PipedInputStream
PipedReader
PipedOutputStream
PipedWriter

RandomAccessFile：保存一系列固定大小的记录，因此可以查找、操作记录。nio类取代了它的功能。

new BufferedReader(new FileReader(new File("path"))).readline();
DataInputStream.available()方法表示的是没阻塞时能被读取的bytes。因此不一定代表的是Stream的末尾。读文件时代表末尾，但读其它源时未必如此。
PrintWriter需要调close()来保证flush。

DataOutputStream和DataInputStream能保证java跨平台数据还原。用它们写String时唯一的可靠方式是用UTF-8编码，并调用readUTF()、writeUTF()接口。注意，这两个接口使用的是UTF-8变种，所以只能在java内部使用。如果在外部程序需要用到接口的输出，需要写特殊代码。

System.out和System.err已经wrapped，可以直接用。System.in则必须wrap后才能用。类似于wrap InputStream。
System.out是OutputStream，可通过new PrintWriter(out, true)转成Writer。true表示自动flushing。
System.setIn()、setOut()、setErr()用来redirect标准输入输出。

ProcessBuilder用于执行console命令。Process.getInputStream()、getErrorStream()可读取输出。

nio实现思路：channel数据载体，buffer作为存、取数据工具来回运载数据。基于byte。FileInputStream，FileOutputStream被重写实现此机制。Reader、Writer基于字符，所以不能使用此机制。java.nio.channels.Channels提供了工具从channels中获取Reader、Writer。
getChannel()方法获取FileChannel。ByteBuffer用于读写FileChannel。ByteBuffer.allocate(size)获取ByteBuffer。wrap()使用bytearray作为储存。在读取数据时，ByteBuffer.flip()必须被调用。写数据时，clear()必须被调用。
transferTo()、transferFrom()能直接连接两个channels。

ByteBuffer.asCharBuffer()会使用系统默认编码。ViewBuffer可读取ByteBuffer，按照主类型的模式。如果主类型需要占用两个bytes的话，需要注意两个字节的排序。BIG_ENDIAN或LITTLE_ENDIAN。

Buffer操作
capacity()          Returns the buffer’s capacity.
clear()             Clears the buffer, sets the position to zero, and limit to capacity. You call this method to 
                    overwrite an existing buffer.
flip()              Sets limit to position and position to zero. This method is used to prepare the buffer for a 
                    read after data has been written into it.
limit()             Returns the value of limit.
limit(int lim)      Sets the value of limit.
mark()              Sets mark at position.
position()          Returns the value of position.
position(int pos)   Sets the value of position.
remaining()         Returns (limit - position).
hasRemaining()      Returns true if there are any elements between position and limit.

Memory-mapped Files
FileChannel.map(FileChannel.MapMode.READ_WRITE, 0, length);
能将大文件映射到内存，（内存实际上只有部分文件内容）
使用map时，如果要写，必须使用RandomAccessFile。

Java的文件锁直接使用OS系统的锁机制，因此对其它操作、其它JVM、其它语言可见。
FileChannel.tryLock()是不阻塞的，lock()是阻塞的。tryLock()取不到锁会直接返回null，lock()会阻塞到取到锁为止。FileLock.release()释放锁。
FileChannel.close()或线程打断能够停止lock()的阻塞。
也能锁住文件一部分。tryLock/lock(long position, long size, boolean shared);

对象序列化
ObjectOutputStream.writeObject()
自定义系列化：
Externalizable，两个方法：
writeExternal
readExternal
transient：避免此属性序列化

在同一个ObjectOutputStream里序列化多次对象，此对象不会被重复恢复。但不同Stream则会重复。

Class对象是可序列化的，但是静态属性必须写特殊代码！serializeStaticState();

Preferences API：序列化（持久化）主类型和字符串。字符串长度不能超过8K。

Array被创建后会自动初始化，每个元素自动赋值null或者0，'0'，false。

HashMap: 为了快速查询，使用了散列链数组的结构。将key转成hash，值相同的hash组成链，存在数组的index位置（index就为Hash的值）。
HashMap在发生结构性改变时（key增加或减少，对已有key的value改变不是结构性改变），只能在外部保证同步性。
Iterator是"fail-fast"的，如果Iterator过程中Map发生结构性改变，会尽量立即抛出异常。但此特性只是"best-effort"的，不保证必然抛出。因此不能用此异常作为程序逻辑判断。
Hashmap.keySet()方法返回的set，和map保持同步。改变set中对象会同时改变map中对象，反之亦然。collection也一样。

LinkedHashMap:
    iteration排序以key被插入的顺序为准。key被重新插入时，不会改变顺序。
    LinkedHashMap的遍历复杂度取决于size，而HashMap取决于capacity。
    对于LinkedHashMap来说，结构性改变不只是key增减，而且影响遍历顺序的也是结构性改变。



Bridge method:
    用于桥接父泛型方法和子实际方法（已指定泛型）的方法，只存在于编译文件中。


JVM:
类加载

类编译
    字节码表达式
        ”L<classname>;”表示的是类的实例。
        “V”表示没有返回值（Void）
        调用方法：
            invokeinterface : 调用一个接口方法
            invokespecial  : 调用一个初始化方法，私有方法或者父类的方法
            invokestatic   : 调用静态方法
            invokevirtual  : 调用实例方法
        代码前的数字：字节偏移
        类型表达：
            Java Bytecode      Type           Description
            B                  byte           signed byte
            C                  char           Unicode character
            D                  double         double-precision floating-point value
            F                  float          single-precision floating-point value
            I                  int            integer
            J                  long           long integer
            L<classname>       reference      an instance of class <classname>
            S                  short          signed short
            Z                  boolean        true or false
            [                  reference      one array dimension
    数据类型：
        三种引用类型：
            类、数组、接口


