# NetworkRequest
基于AFN网络请求简单封装
简单的封装，使用代理的方式进行回调

升级为iOS9后，默认请求类型为https，如何使用http进行请求会报错

最简单的解决方案： 
1，在info.plist文件中添加App Transport Security Settings 类型是一个Dictionary 
2，在App Transport Security Settings下添加Allow Arbitrary Loads 类型Boolean,值设为YES
