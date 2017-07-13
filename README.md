# RXZipArchive
 
【from open code】https://github.com/ZipArchive/ZipArchive
官方demo是使用`cocoapods` 看起来很方便, 但 我的项目是不使用 `cocoapods`。我就把官方demo编译一下 simulator + iphoneos > ZipArchive.framework ,放入自己的demo中，`apple mach-o linker error` 或者 `SSZipArchive.h  第14行 找不到SSZipCommon.h文件 not found` 错误。 我换成.a静态库，也是不行。后来就是用源码了，为了和支付宝的c文件名不冲突，我修改了原作者的文件名 加了一个前缀 `Zip`。

等有时间我在，好好写UI 展示一下
