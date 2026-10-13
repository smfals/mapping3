import 'dart:convert';
import 'dart:io';

/// 自主实践1：把嵌套回调版程序改写为顺序 async/await 版。
///
/// 【改写前】嵌套回调版：读文件 -> 解析JSON -> 统计，每一步都在 then 回调里
/// 发起下一步，形成回调嵌套，错误处理分散在 catchError 里。
Future<void> runWithCallbacks() {
  return File('data/books.json').readAsString().then((text) {
    final list = jsonDecode(text) as List<dynamic>;
    var total = 0;
    for (final _ in list) {
      total++;
    }
    print('[回调版] 图书总数: $total');
  }).catchError((Object e) {
    print('[回调版] 出错: $e');
  });
}

/// 【改写后】顺序 await 版：线性表达同样的三步，try-catch 统一兜底，可读性更好。
Future<void> runWithAwait() async {
  try {
    final text = await File('data/books.json').readAsString();
    final list = jsonDecode(text) as List<dynamic>;
    var total = 0;
    for (final _ in list) {
      total++;
    }
    print('[await版] 图书总数: $total');
  } catch (e) {
    print('[await版] 出错: $e');
  }
}

Future<void> main() async {
  await runWithCallbacks(); // 先跑回调版（等待其 Future 完成，保证输出顺序）
  await runWithAwait(); // 再跑 await 版
}
