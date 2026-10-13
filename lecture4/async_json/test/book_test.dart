import 'dart:convert';

import 'package:async_json/book.dart';
import 'package:test/test.dart';

void main() {
  test('fromJson 缺失 borrowCount 默认 0', () {
    final b = Book.fromJson({'id': 'B1', 'title': 'T', 'category': 'C'});
    expect(b.borrowCount, 0);
  });

  test('JSON 数字为 double 时 as num.toInt 安全转换', () {
    final b = Book.fromJson(
      {'id': 'B1', 'title': 'T', 'category': 'C', 'borrowCount': 3.0},
    );
    expect(b.borrowCount, 3);
  });

  test('toJson 反向验证：roundtrip 一致', () {
    final origin = {'id': 'B1', 'title': 'T', 'category': 'C', 'borrowCount': 7};
    final b = Book.fromJson(origin);
    expect(b.toJson(), origin);
    // 再经 jsonEncode -> jsonDecode 走完整一圈
    final round = jsonDecode(jsonEncode(b.toJson())) as Map<String, dynamic>;
    expect(round, origin);
  });
}
