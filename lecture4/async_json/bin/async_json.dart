import 'dart:convert';
import 'dart:io';

import 'package:async_json/book.dart';
import 'package:path/path.dart' as p;

/// 课堂案例：异步读取 data/books.json，解析为 Book 列表并汇总输出。
/// 异常兜底：文件缺失 / JSON格式错误 / 字段类型错误均给出可读提示，finally 负责收尾。
Future<void> main() async {
  final path = p.join('data', 'books.json');
  try {
    // await 等待文件读取完成，但不阻塞事件循环
    final text = await File(path).readAsString();
    final list = jsonDecode(text) as List<dynamic>;
    final books = list
        .map((e) => Book.fromJson(e as Map<String, dynamic>))
        .toList();

    print('图书总数: ${books.length}');

    // Map 统计各类目数量
    final byCategory = <String, int>{};
    for (final b in books) {
      byCategory[b.category] = (byCategory[b.category] ?? 0) + 1;
    }
    print('各类目数量:');
    byCategory.forEach((category, count) {
      print('  $category: $count 本');
    });

    // 借阅量 Top3
    final top = [...books]
      ..sort((a, b) => b.borrowCount.compareTo(a.borrowCount));
    print('借阅量 Top3:');
    for (var i = 0; i < 3 && i < top.length; i++) {
      print('  第${i + 1}名: ${top[i].title}(${top[i].borrowCount}次)');
    }
  } on FileSystemException {
    // 精确捕获：文件缺失
    print('数据文件缺失，请检查data/books.json');
  } on FormatException catch (e) {
    // JSON 语法错误
    print('JSON格式错误: ${e.message}');
  } on TypeError catch (e) {
    // 字段类型与模型断言不符（如 borrowCount 写成字符串）
    print('字段类型错误，请检查JSON字段类型: $e');
  } finally {
    // 无论成败都执行
    print('[async_json] 运行结束');
  }
}
