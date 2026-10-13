# lecture4 — Dart语言基础三：异步、异常与包管理

第6周课堂作业四仓库目录。

## 内容

- `async_json/`：课堂案例复现——异步读取本地 `data/books.json`，解析为 `Book` 模型并汇总输出（总数、各类目数量、借阅量 Top3），含文件缺失/字段缺失/类型错误三类异常的可读提示。
- `async_json/example/callback_to_await.dart`：自主实践1——嵌套回调版改写为顺序 async/await 版（同文件内对照）。
- `async_json/example/missing_field_demo.dart`：故意实验——严格 `fromJson` 在字段缺失时抛错，对比默认 0 的健壮写法。

## 运行

```powershell
cd async_json
dart pub get
dart run
```

## Git 提交

按实践指南每步一次提交：dataset & deps → parse & stats → robust handling → 自主实践。
