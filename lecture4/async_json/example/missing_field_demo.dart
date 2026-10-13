import 'dart:convert';

import 'package:async_json/book.dart';

/// 故意实验：手工删掉 JSON 对象的 borrowCount 字段，
/// 对比「as num 直取（不判 null）」与「Book.fromJson 默认 0」两种行为。
void main() {
  // 该对象被故意删掉了 borrowCount 字段
  const broken = '{"id":"B011","title":"缺字段的书","category":"测试"}';
  final j = jsonDecode(broken) as Map<String, dynamic>;

  // 实验前：严格写法，字段缺失 -> null as num -> TypeError
  try {
    (j['borrowCount'] as num).toInt();
    print('实验前: 未抛错（不符合预期）');
  } on TypeError catch (e) {
    print('实验前 as num 直取: TypeError -> $e');
  }

  // 实验后：Book.fromJson 对缺失字段默认 0，不再抛错
  final book = Book.fromJson(j);
  print('实验后 Book.fromJson 默认0: $book');
}
