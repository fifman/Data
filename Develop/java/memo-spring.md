# beans

## wrapper

### cache
1. spring会通过classloader进行bean信息缓存，缓存PropertyDescriptor。
2. 缓存为spring自有的。推荐spring jar包和应用包通过同一个classloader加载。否则，考虑在web.xml声明本地org.springframework.web.util.IntrospectorCleanupListener。

