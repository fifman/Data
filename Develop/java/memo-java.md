# start

## install

1. centos: `yum install java-1.8...` (notice that the version should be "devel" otherwise you will not find "javac")

## environment

1. jenv
2. /usr/libexec/java_home -V: �鿴�汾

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

## ��װ��

brew tap caskroom/versions
brew install java7
brew install java6

# ����

### String����

String���󲻿��޸ġ��������"aa"+"bb"+"cc"����������ʱ����ʵ�����ǣ�����JVM��ͬʵ�ֿ��ܲ�һ������������"aa"+"bb"�Ľ������ʱ����Ȼ�����ɽ����
�������п����Զ���ȡ�������������ڲ�ʹ��StringBuilder��
��ʹ��ˣ���ʽ����StringBuilder���ܱ�֤���ܡ���Ϊ���������ܱ�֤���ܡ��������������������ʹ��StringBuilder��������ѭ��ʱ��ÿ��ѭ������������StringBuilder��

StringBuffer.append()���ܱ�StringBuilderҪ�ͣ����ܱ�֤����ԭ���ԡ�

Ԥ��ָ��StringBuffer��С�ɱ��������·��仺�塣


# �﷨

## ���ڰ�

javaĬ�Ϻ��ڰ󶨣����÷���ʱ��ʵ�ʵ��õĴ������ʱ�̲ű�ȷ����������ȷ���������ڲ�ִ�����ͼ�飬����ʱ��֪��ȷ�д��롣��˿���ʵ������ת�͡�
�����������ʹ��ǰ�ڰ󶨣�������֪������ִ�д�����Ե�ַ��
c++Ĭ��ǰ�ڰ󶨣�ʹ��virtual�ؼ��ֲ���ʵ�ֺ��ڰ󶨡�

## �����̳�

����java��̳�Object��c++���ǡ�

���������ͣ����ͣ�

## �����ʶ����

��������á����磺
String s;
���ﴴ����һ�������־��s��sΪһ�����ã�û��ָ�����󣬵������ڣ���
�����������ʵ�����Ǵ�����һ���������飬ÿ�����ñ��Զ���ʼ��Ϊnull��
Ҳ���Դ��������������͵����顣

java������ֵ���Ͷ���������
�߾�����ֵ��BigDecimal��BigIntegerû�ж�Ӧ�Ļ������͡��߾���֧�����⾫�ȡ�

������
�������ɻ�����{}�������������ڲ�����ı����������ã����������ڡ�
���������ڴ����ķǻ������������������ȡ����������

import:

java.lang�Զ�����

��������

�������в�����ֻ�ܲ����������͡���"="��"=="��"!=" �ܲ������ж���String֧��"+"��"+="��

�ַ���ת����

"+"����ִ���ַ���ת������a+b�У�aΪString���ͣ�b��Stringʱ���Ὣbת��String��ע��String���ͱ�����ǰ�档

=�ţ�

�Ⱥ���߱������������ı�����a=4, ����4=a���ұ߱���������һ��ֵ��

����a=b=c=1��ʵ��Ч����a=(b=(c=1))

ֵ���ݣ�

������ֱֵ�Ӵ��ݡ�����˫�����Լ����������޸ģ�������Ӱ�졣����ֵ���ݴ��ݵ������ã�����˫���Ṳ��һ�������޸Ļ��໥Ӱ�졣


����������

��������/��ֱ��ȥ��С��λ��

һԪ+�ţ���ʾ��ֵ��Ψһ�����þ��ǽ���С���͵Ĳ���������Ϊint��

����Ƚϣ�

"=="��"!="�Ƚϵ��Ƕ�������á�
Object.equals()Ĭ����Ϊ�ǱȽ����ã���һЩ�����渲���˴���Ϊ������Integer����

�߼��������·��

����1 && ����2 && ����3���������2Ϊfalse��������3��ִ�С�


��ֵ����������

1.1D, 3L, 0.1F
��ʱ�������Ĭ�����Ͳ��ԣ���Ҫ�ַ���ʽָ����

��Ԫ������ifelse

boolean ? v1 : v2

��λ��������& |  �߼���������&& ||

## ���η�

privateָ���˰����˳�Ա���࣬�����κ��඼�޷����ʡ�
protected�ṩ������Ȩ�ޡ�ͬ������Է��ʡ�
�಻����private��protected���ڲ�����⡣

û��public���ε��࣬��static��Ա�����public�����ǿ��Ա��ⲿ���ʡ�


# JVM

## �洢λ��

�Ĵ�����java����ֱ�ӿ��ơ�
��ջ��java���󲻴洢���������������档
�ѣ�����java����洢λ�á�

����ͨ��ֱ�ӷ��ڳ�������ڲ���
�������ͱ����������ã�ֱ�Ӵ洢ֵ�����ڶ�ջ�С�
�������Ͱ�װ������ڶ��д�������

# middleware


## tomcat

tomcat install:
1. download
2. dir: /usr/local/tomcat
3. �û�\�鴴��
4. systemctl 
5. tomcat user setting
6. tomcat manager app META-INF/context.xml setting

## rmi

java.rmi.ConnectException: Connection refused to host: 127.0.0.1;
��Ҫ����-Djava.rmi.server.hostname=myserver.com

## weblogic

### weblogic install

#### linux install

1. add `-Dweblogic.management.allowPasswordEcho=true` to domain creating command
1. add `-Djava.security.egd=file:/dev/./urandom` to  ${DOMAIN_HOME}/bin/startWeblogic.sh, in start command
2. add `USER_MEM_ARGS="-Xms1024m -Xmx1024m -XX:MaxPermSize=512m"` to ${DOMAIN_HOME}/bin/setDomainEnv.sh, before `USER_MEM_ARGS=${USER_MEM_ARGS} ...`


weblogic password change:
1. ɾ��adminserver�������ļ�
2. �½�security�ļ���
3. ����boot.properties�ļ�
4. д��
    username=xxx
    password=xxx


java�ļ������뵥Ԫcompile unit��ÿ�����뵥Ԫ��ֻ����Ψһ��public�࣬����������ļ�����ͬ��

java���������ݻ�������classpath�����ļ����������һ���ļ����£�ֱ�ӷŵ�ַ�������jar������ַ��Ҫ����jar�������ļ�����classpath�а���"."���������ͻ��ҵ�ǰĿ¼��

��ӡʱ������toString()���������ڶ�����Ϊnullʱ���ã����null�������ɣ�����ԣ�

����ʵ��������һ���������ʵ������ʼ��ʱ��������ʵ���ȱ���ʼ����Ȼ����������Լ��ĳ�ʼ����

����ת����
խ��ת��������תΪ����
��չת��������תΪ����
java�������κλ�����������תΪ��Ļ����������ͣ�����bool�����⡣
��ֵ����ת��ʱֵ���β�������������롣

java�����������͵Ĵ�С����ƺõģ��ڲ�ͬ��������ͬ��

boolֵ����ִ����������ޣ�ֻ�ܸ�ֵtrue��false����������١����ܼӼ��˳����������㡣

������intֵ�˷����������

for(init;bool;step)����У��������init,bool,step������Ϊ�ա���һ�ε���ǰִ��һ��init��ÿ�ε���ǰִ��bool�жϣ�������ִ��step��������䶼���Ծ��ɶ��Ų������ָ��������Ĵ�����ע��java��ֻ��forѭ���ܹ�ʹ�ö��Ų������������Ų������Ͷ��ŷָ�����ͬ�����ŷָ��������ڶ���������塣��

foreach:
�������κ�Iterable��������顣

��ǩ��
break��continueֻ�������²�ѭ���������ϱ�ǩ�󣬿������༶ѭ������:
label1: //�����ں�������
for(...){
    for(...){
        ...
        break label1;
    }
}

continue��ִ��step��䡣break��ִ�С������continue�ϼ���ǩ����ײ�step��䲻ִ�С�

switch:
ֻ�ܽ�������ֵ��ö�١�����default�⣬����case��֧Ҫ��break����������ִ�������case��䡣

�������أ�ͬ����������ͬ������
�������������ֱ�Ϊ�����࣬���������ࡣ

��������������ʱ�������ù�����������ڷ�������ǰ��

finalize():
����������׼�����ͷŶ���Ĵ洢�ռ�ʱ�����ȵ���finalize()������Ȼ��ִ���������ա�
����һ�����������գ�ֻ����������ִ���ˣ�finalize()�����ű����á�
java�����Ķ��󶼻ᱻ�������գ�������Ҫʹ��finalize()��������ܶ�ʱ������Ҫ���á����ط�����ʱ����java���÷�java����ʱ��
���Բ���ֱ�ӵ���finalize()���˷�����Ϊ�������������õġ�

��ʼ����
���ﶨ������Ϊ��������ʱ����ʼֵĬ��ΪNull��
���Գ�ʼ��ʱ����˳��Ҫע����ǰ���á�
�����Զ���ʼ���ڹ�������ʼ��ǰ��������ʹ���ǵĶ���λ�ü����ڷ���֮�䡣
ֻ�з�����ʱ�Ž�������ء���̬��ʼ��������ص�ʱ��ִ�У�ִֻ��һ�Ρ�����ִ�С�
��̬��;�̬�������ƣ�ִֻ��һ�Ρ�
java��ͬ�������зǾ�̬�顣�ڹ�����ǰ�������Զ���ʼ����ִ�С�

���飺
int[] a;
int a[];���ָ�ʽ�����ԡ�
ֻ�г�ʼ��ʱ������ʹ�ñ���ʽ{}����int[] a =
{1,2,3};����ʽ����Ͷ�������int[]һ��ʹ�á�new int[5]���ơ���new
int[]{1,2}�����κ������ʹ�á�
���鴫�������ô��ݡ�
�ǻ������Ͷ���������һ���������顣
������������new�˺���Զ���ʼ����

�ɱ�����б���
������ı��������飬��ֱ��ʹ�����顣
���������һ��ֵ�����Ƚ�ֵƴװ�����顣
���Բ���ֵ����ʱ����һ������Ϊ0�����飬������null��
�ɱ�������Ժ�һ��������ʹ�á����ƺ�ֻ�ܷ����
�ɱ䵥�����ؿ���������⣬��Ҫע�⡣�����ڲ�����Ϊ�յ���״�¡�

final:
final����ָ���ò��䣬�����ڲ��ɱ䡣
�����ڶ��崦��ÿ����������final���Ը�ֵ��
����Ҳ�Ƕ���final��ʾ���ò��䡣

��̬
�͡���̬�󶨡��������ڰ󶨡���������ʱ�󶨡�ͬ��
��ֻ̬�����ڷ��������Ƕ�̬��

��
�������ú�ʵ�ʷ�����Ĺ������ڳ���ִ��ǰ�󶨳�Ϊǰ�ڰ󶨣�Cֻ��ǰ�ڰ󶨡�java��static������final������private��������final��ǰ�ڰ󶨣��������ڰ󶨡�

��private�������ܸ��ǡ�����ͬ����������Ϊ���³�Ա��

������ڷ�����static��Աʱ��������������ʵ�����Եľ�̬��Ա�������ǹ��������Ե��÷Ǿ�̬���Ժͷ�������

���Ӷ����ʼ��˳��
1. ���û��๹����
2. ������˳���ʼ������
3. ���õ����๹��������

�̳��������������������ڼǵõ��ø�������������������಻��������

�������е��ø��Ƿ������ܻ���ɴ��󡣻��๹��ʱֱ�ӵ���������ĸ��Ƿ�����

Э�䷵������
���Ƿ����ķ��������Ϊ����������������ࡣ

�ӿ��е���������static��final�ģ�������������public�ģ�����Ҫpublic�ؼ��֡�



# ���� #
javaû��ʹ�ý��̣�����ʹ�û���˳���̵��߳���ʵ�ֲ���������Ϊ��OS͸���ԡ���ЩOS��֧�ֶ���̡�

java���߳��в������ô����ķ��̡߳�ÿ���̡߳����á����������Բ��ᱻ�������գ������߳�ֹͣ��
Thread��ִ�е�Task���׳����쳣���ᴫ����main�������Ҫÿ��Task����catch�������쳣��
sleep()���׳�InterruptedException����sleepʱ��scheduler���л��̡߳�
setPiority()Ҫ����run()���棬����ǰ���̲��ԡ�

daemon thread:
    ֻҪ��һ����daemon�߳������У�daemon threads�Ͳ�����ֹ����ֻҪ���з�daemon threads��ɣ�daemon threads�ͻ���ֹ��    �߳�Ϊdaemonʱ�������������߳�ҲΪdaemon��
    daemon�̲߳���ִ��finally clause������

��Ҫ�ڹ�������start()����Ϊ�����컹δ��ɣ��߳̿��ܷ��ʲ��ȶ��Ķ���

join():
    ��һ���߳��п���call��һ���߳�t��t.join()����ʱcaller�̻߳�suspend�����ȴ��߳�tִ������ִ�С�
    join()����Դ���ʱ���������ʱ����󲻹�t�Ƿ�ִ���꣬�����ء�
    t.interrupt()���Դ��join()�����join()��Ҫtry-catch�顣

���߳��в���catch���߳����׳����쳣����Ҫ�õ�Thread.UncaughtExceptionHandler��

�߳�֮�䲻Ӧ������������Ϊ�޷���֤�߳�֮���˳���Լ��߳���Ȼ��Ч��û���쳣�׳���ֹͣ����

++��--�����ҵ������ݼ������Ƿ�ԭ�Ӳ�����������˿��ܷ����������⡣

mutex��������

synchronized��һ��һ��object��һ��synchronized���������ã���ô����������object��synchronized���������ܷ��ʡ��κζ��󶼴���һ��������

synchronized static������class��һ����������ܱ����̳߳�ͻ��

ע�⣺��ס�Ķ���ķ�synchronized������Ȼ�ܷ��ʡ�

��ʽlock��
lock.unlock()������try-catch����finally clause�У���������޷��ͷš�
����������try���ﷵ�أ�����unlock����returnִ�У����ڱ�¶��Դ�ķ��ա�
��ʽlock�����ܹ���γ��Ի�ȡLock�����û�ȡlockʧ�ܺ�Ĵ��ã��ȵȣ������ܻ���synchronized����������������ͨ��finally clause���ܹ��ó����ڷ����쳣������״̬��

word-tearing�����ڡ��򵥲������ʹ󲿷���������˵����ԭ�Ӳ��������ǣ��ڶ�дlong��double��������ʱ��JVM�п��ܷ����β�����64bit�ֳ�����32bit������volatile�ؼ��ֶ��������JSE5ǰ����ȷ����ɱ�����һ�㣬ʵ��ԭ�Ӳ�����ע����ԭ�Ӳ����������̰߳�ȫ����

ԭ�Ӳ�����һ�����̰߳�ȫ�ġ�

���ϵͳ�У�visibility�ܹؼ���һ�����е�ĳ����Ĳ�������ʹ��ԭ���Եģ�Ҳδ�ر������˿ɼ�����Ϊ�п��ܴ洢�ڵ��˵Ļ����С���ͬ������ǿ�Ʋ��������Ӧ�÷�Χ�ڿɼ���volatile�ؼ���Ҳ�ɱ�֤�����ԣ���ʹ���ڱ���cache����ǿ�����Զ�д��������memory��

����ж�������һ��fieldֱ�ӷ��ʣ���ô��Ҫvolatile�ؼ��ʣ�����ֻ��Ҫsynchronized�������ɡ��������Ĳ����������Ȼ�ɼ����������ֻ��һ������ֱ�ӷ���field����ô����Ҫvolatile�ؼ��ʡ�

volatile��field��ֵȡ����֮ǰ��ֵʱʧЧ������++��--�ȵ������ݼ�����������field��ֵ������fieldԼ��ʱҲʧЧ�����͵�Ӧ��volatile�ؼ��ʵĳ�������ֻ����һ���ɱ�fieldʱ��

volatile��ֹfield�����棬��дֱ�ӷ�������memory��ͬʱ��ֹcompiler�Ż�����˳�򡣵������ܱ�֤ԭ���ԡ���������񣨴˴���������Ȼָ�߳������ܹ�ֱ�ӷ���field����������һ������Ҫдʱ����Ҫ�õ�volatile��

synchronized�飺
��ʹ��synchronized�顣��ʽ����Ҫһ�������������ʽ��ֱ�ӵ���ReentrantLock����

ʹ��Threadlocal����ʹ��ͬ�̷߳���ͬһ�������Ĳ�ͬ���档ÿ���̶߳�����һ���˱�����local���档

�߳���״̬���½�����ִ�С�������������
����ԭ��
    sleep();
    wait();
    �ȴ�I/Oִ�����
    �̵߳ȴ���ȡ��������ִ��synchronized����������ס��
�����������д�ϣ�����interrupt��������ʱ���׳�InterruptedException��
interrupt����������ʱ������̴߳�������״̬�����׳�InterruptedException�������׳�������̵߳�ʱ��������״̬����������ִ�У�ֱ������ִ�е�������ʱ���ͻ��׳��쳣�����������ִ����ȥ��
Executor�����shutdownNow()��������cancel������ִ�е��̡߳����ֻ��cancelһ���̣߳���Ҫ��submit()����һ��Future���󡣵�Future�����cancel()������cancel��

IO��synchronized�������޷���ϵġ�һ�����취���ڷ��ʹ��ʱͬʱ�ر�IO��Դ�����Ա�����������ʱ��Ҫע����ǣ��̲߳�һ���ᴦ�ڡ���ϡ�״̬�����磬Socket�ᴦ�ڴ��״̬����System.in��ᴦ��ֹͣ��isInterrupted()Ϊfalse��
nio�������ֱ�Ӵ�ϣ�����Ҫ�ر�IO��Դ��

ͬһ���߳̿��Ե���������Ķ����ͬ��ͬ������������Ҫ�����ͷš�

����ReentrantLock����ʱ���Դ�ϡ���JSE5�����ԡ�����Ϻ�ReentrantLock��lockInterruptibly()�������׳�InterruptedException�쳣����Ҫ��lockInterruptibly()������

thread.interrupt()ֻ��thread��������ʱ��Ч��thread��������״̬ʱ��interrupt()��Ч��interrupt()������interrupted״̬��ͨ������interrupted()�����������ܼ��interrupted״̬�����һ������״̬��

���Interrupted״̬��ͨ��������
try{
    while(!Thread.interrupted()){ // Thread.interrupted()�����ж�thread�Ƿ��ڴ��״̬��
        try{
            create object!
        }finally{   //�ڴ˴���Ҫfinally clause��������������ע��û��catch clause��
            cleanup objects!
        }
    }
}catch(InterruptedException ex){
}finally{
}

busy waiting: idleѭ�����״̬������cpu��ת��
sleep()��yield()�����ͷŶ�������wait()�ᡣwait()��notify()����ֻ����synchronized���������ʹ�á���������ʱ�����쳣��
        while (waxOn == false)
            wait();
ͨ����Ҫʹ��while���жϱ�־λ��ʹ��wait()������������ȷ��״̬��Ҳ����˵��ÿ��ͨ��notify()����ʱ������Ӧ������ִ�У�������Ҫ�ж��Ƿ�����ȷ��״̬������ȷ������ִ����һ����������ǣ�����Ҫ����wait()ֱ����ȷ�����ɳ�������ˣ���Ҫwhile����������жϣ��Ƿ����ִ����һ����

���ܳ�����
while(condition){
    //point 1
    synchronized(obj){
        obj.wait();
    }
}
��Ϊwhile���û�б�synchronized��point 1ʱ�߳̿��ܻ��л�����һ���̡߳���ʱ��һ���̷߳���notify()������notify��waitǰ���ͣ������ԡ��Ӷ�����ѭ����ȥ����ȷ������
synchronized(obj){
    while(condition)
        obj.wait();
}

LinkedBlockingQuene�����޶�Ԫ��
ArrayBlockingQuene�����޸�Ԫ��

thread.run()��ֱ���ڱ����߳���ִ�У������ǲ���һ�����̡߳���ʱ��ʵ������ͨ�Ķ��󷽷����á�

PipedReader�ǿɴ�ϵģ���ͬ��ͨ����I/O�ӿڡ�

��������ѭ���������ڵȴ���һ���������������һ�������ֵȴ���������ֱ�����ȴ���һ�����������

�����������������ʱ�����ܷ���������
1. ��Դ���⣺��Դ��һ����������ʱ�����������ܹ�����
2. ������һ����������һ����Դ��ͬʱ�ڵȴ���һ����Դ��
3. ��Դ�޷���ǿ���ͷš�����ֻ�ܱ����ȴ���Դ�ͷš�
4. ���ܳ���ѭ���ȴ���

java library�ķ����Ƿ��̰߳�ȫ����Ҫ�Լ�ע�⣬case-by-case��

CountDownLatch��countDown()�������Ƶ�0ʱ������await()������
CyclicBarrier��������ƽ�н��У������������await()�����ִ����һ����Ȼ��ѭ��������
DelayQuene: ���ս�ֹ�����Ⱥ�����
PriorityBlockingQueue�����ȼ����С�
Collections.synchronizedList()��List�ķ���synchronized��
Semaphore�����Ʒ��ʵ��������������޺�������
Exchanger����exchange()��ִ��һ��ʱ������ֱ���ڶ���ִ��ʱ���ݽ�����

���ܷ�����Lock��synchronizedһ����˵����Ч���������ܸ��ȶ���synchronized���ܲ��ȶ���
AtomicObjectsһ��ֻ����һ�����ԣ�������ʱ��Ҫʹ�ö����

Lock-free�������޸������Ͷ�������ͬʱ����������ֻ�ܶ�ȡ������ˡ����޸ġ����ڷ������޸��ǲ��ᱻ��ȡ�ģ�
CopyOnWriteArrayList
CopyOnWriteArraySet
ConcurrentHashMap
ConcurrentLinkedQueue

ReadWriteLock��д�������٣��������ܶ�ʱ�����Գ��ԡ�


= I/O =

InputStream\OutputStream��Ҫ��FilterInputStream��FilterOutputStreamװ�κ�����γɿ���IO�ӿ�:
DataInputStream��BufferedInputStream������FilterInputStream
DataInputStream���ڶ�ȡ���������ݡ�

FilterOutputStream��
DataOutputStream��PrintStream��BufferedOutputStream
PrintStream���γɸ�ʽ�������������һЩ���⣬�����쳣���������ʻ�����ƽ̨�ĸ�ʽ���ȡ�PrintWriter���á�

InputStream��OutputStream����byte��Reader��Writer�����ַ���
InputStreamReader��InputStreamת����Reader��OutputStreamWriter��OutputStreamת����Writer��

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

RandomAccessFile������һϵ�й̶���С�ļ�¼����˿��Բ��ҡ�������¼��nio��ȡ�������Ĺ��ܡ�

new BufferedReader(new FileReader(new File("path"))).readline();
DataInputStream.available()������ʾ����û����ʱ�ܱ���ȡ��bytes����˲�һ����������Stream��ĩβ�����ļ�ʱ����ĩβ����������Դʱδ����ˡ�
PrintWriter��Ҫ��close()����֤flush��

DataOutputStream��DataInputStream�ܱ�֤java��ƽ̨���ݻ�ԭ��������дStringʱΨһ�Ŀɿ���ʽ����UTF-8���룬������readUTF()��writeUTF()�ӿڡ�ע�⣬�������ӿ�ʹ�õ���UTF-8���֣�����ֻ����java�ڲ�ʹ�á�������ⲿ������Ҫ�õ��ӿڵ��������Ҫд������롣

System.out��System.err�Ѿ�wrapped������ֱ���á�System.in�����wrap������á�������wrap InputStream��
System.out��OutputStream����ͨ��new PrintWriter(out, true)ת��Writer��true��ʾ�Զ�flushing��
System.setIn()��setOut()��setErr()����redirect��׼���������

ProcessBuilder����ִ��console���Process.getInputStream()��getErrorStream()�ɶ�ȡ�����

nioʵ��˼·��channel�������壬buffer��Ϊ�桢ȡ���ݹ��������������ݡ�����byte��FileInputStream��FileOutputStream����дʵ�ִ˻��ơ�Reader��Writer�����ַ������Բ���ʹ�ô˻��ơ�java.nio.channels.Channels�ṩ�˹��ߴ�channels�л�ȡReader��Writer��
getChannel()������ȡFileChannel��ByteBuffer���ڶ�дFileChannel��ByteBuffer.allocate(size)��ȡByteBuffer��wrap()ʹ��bytearray��Ϊ���档�ڶ�ȡ����ʱ��ByteBuffer.flip()���뱻���á�д����ʱ��clear()���뱻���á�
transferTo()��transferFrom()��ֱ����������channels��

ByteBuffer.asCharBuffer()��ʹ��ϵͳĬ�ϱ��롣ViewBuffer�ɶ�ȡByteBuffer�����������͵�ģʽ�������������Ҫռ������bytes�Ļ�����Ҫע�������ֽڵ�����BIG_ENDIAN��LITTLE_ENDIAN��

Buffer����
capacity()          Returns the buffer��s capacity.
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
�ܽ����ļ�ӳ�䵽�ڴ棬���ڴ�ʵ����ֻ�в����ļ����ݣ�
ʹ��mapʱ�����Ҫд������ʹ��RandomAccessFile��

Java���ļ���ֱ��ʹ��OSϵͳ�������ƣ���˶���������������JVM���������Կɼ���
FileChannel.tryLock()�ǲ������ģ�lock()�������ġ�tryLock()ȡ��������ֱ�ӷ���null��lock()��������ȡ����Ϊֹ��FileLock.release()�ͷ�����
FileChannel.close()���̴߳���ܹ�ֹͣlock()��������
Ҳ����ס�ļ�һ���֡�tryLock/lock(long position, long size, boolean shared);

�������л�
ObjectOutputStream.writeObject()
�Զ���ϵ�л���
Externalizable������������
writeExternal
readExternal
transient��������������л�

��ͬһ��ObjectOutputStream�����л���ζ��󣬴˶��󲻻ᱻ�ظ��ָ�������ͬStream����ظ���

Class�����ǿ����л��ģ����Ǿ�̬���Ա���д������룡serializeStaticState();

Preferences API�����л����־û��������ͺ��ַ������ַ������Ȳ��ܳ���8K��

Array����������Զ���ʼ����ÿ��Ԫ���Զ���ֵnull����0��'0'��false��

HashMap: Ϊ�˿��ٲ�ѯ��ʹ����ɢ��������Ľṹ����keyת��hash��ֵ��ͬ��hash����������������indexλ�ã�index��ΪHash��ֵ����
HashMap�ڷ����ṹ�Ըı�ʱ��key���ӻ���٣�������key��value�ı䲻�ǽṹ�Ըı䣩��ֻ�����ⲿ��֤ͬ���ԡ�
Iterator��"fail-fast"�ģ����Iterator������Map�����ṹ�Ըı䣬�ᾡ�������׳��쳣����������ֻ��"best-effort"�ģ�����֤��Ȼ�׳�����˲����ô��쳣��Ϊ�����߼��жϡ�
Hashmap.keySet()�������ص�set����map����ͬ�����ı�set�ж����ͬʱ�ı�map�ж��󣬷�֮��Ȼ��collectionҲһ����

LinkedHashMap:
    iteration������key�������˳��Ϊ׼��key�����²���ʱ������ı�˳��
    LinkedHashMap�ı������Ӷ�ȡ����size����HashMapȡ����capacity��
    ����LinkedHashMap��˵���ṹ�Ըı䲻ֻ��key����������Ӱ�����˳���Ҳ�ǽṹ�Ըı䡣



Bridge method:
    �����ŽӸ����ͷ�������ʵ�ʷ�������ָ�����ͣ��ķ�����ֻ�����ڱ����ļ��С�


JVM:
�����

�����
    �ֽ������ʽ
        ��L<classname>;����ʾ�������ʵ����
        ��V����ʾû�з���ֵ��Void��
        ���÷�����
            invokeinterface : ����һ���ӿڷ���
            invokespecial  : ����һ����ʼ��������˽�з������߸���ķ���
            invokestatic   : ���þ�̬����
            invokevirtual  : ����ʵ������
        ����ǰ�����֣��ֽ�ƫ��
        ���ͱ��
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
    �������ͣ�
        �����������ͣ�
            �ࡢ���顢�ӿ�

