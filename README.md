## 迁移

- **所有项目现已迁移到 http://git.baijiashilian.com/open-ios/**

- **引入 1.0 以上版本 SDK 需要修改 Podfile 中的 source**

```ruby
source 'https://github.com/CocoaPods/Specs.git'
source 'http://git.baijiashilian.com/open-ios/specs.git'
```

- **引入 1.0 以前版本继续保持原有的 Podfile 中的 source**

```ruby
source 'https://github.com/CocoaPods/Specs.git'
source 'https://github.com/baijia/specs.git'
```
