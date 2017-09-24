# annotation声明 #

## 表现形式 ##

- 无参数：
    - `@Anno`
    - `@Anno()`
- 有参数：
    - `@Anno(value)` 单参数
    - `@Anno(param1=value1, param2=value2)` 多参数
    - `@Anno(param1={value1, value2}, param2=value3)` 数组值
    - 重复注解（jdk8引入）

## 应用场景 ##

- 用于声明（类、fields、方法等）
- 用于类型操怍(jdk8)：
    - Class instance creation expression:
    ```java
    new @Interned MyObject();
    ```

    - Type cast:
    ```java
    myString = (@NonNull String) str;
    ```

    - implements clause:
    ```java
    class UnmodifiableList<T> implements  
        @Readonly List<@Readonly T> { ... }
    ```

    - Thrown exception declaration:
    ```java
    void monitorTemperature() throws  
        @Critical TemperatureException { ... }
    ```

# 定义 #

```
@Documented  
@Interface Anno {  
    String param1() default "value1";  
    String[] param2();  
}  
```

## javadoc ##

如果注解需要生成javadoc文档，需要加@Documented注解。

# 使用 #

## java本身使用 ##

- `@SuppressWarnings({"unchecked", "deprecation"})`
- `@Override`, `@Deprecated`
- `@SafeVarargs`, `@FunctionalInterface`

## 使用在注解上的注解 ##

- `@Retention`
    - `RetentionPolicy.SOURCE` – The marked annotation is retained only in the source level and is ignored by the compiler.
    - `RetentionPolicy.CLASS` – The marked annotation is retained by the compiler at compile time, but is ignored by the Java Virtual Machine (JVM).
    - `RetentionPolicy.RUNTIME` – The marked annotation is retained by the JVM so it can be used by the runtime environment.

- `@Documented`

- `@Target`: 限定注解能够应用的java元素
    - `ElementType.ANNOTATION_TYPE` can be applied to an annotation type.
    - `ElementType.CONSTRUCTOR` can be applied to a constructor.
    - `ElementType.FIELD` can be applied to a field or property.
    - `ElementType.LOCAL_VARIABLE` can be applied to a local variable.
    - `ElementType.METHOD` can be applied to a method-level annotation.
    - `ElementType.PACKAGE` can be applied to a package declaration.
    - `ElementType.PARAMETER` can be applied to the parameters of a method.
    - `ElementType.TYPE` can be applied to any element of a class.

- `@Inherited`: 注解能被继承（子类会继承父类的注解）。此注解只能用于类声明

- `Repeatable`: 注解能够重复（jdk8）


