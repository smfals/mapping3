/// 图书模型：与统一数据集字段一一对应（id/title/category/borrowCount）。
class Book {
  final String id;
  final String title;
  final String category;
  final int borrowCount;

  Book({
    required this.id,
    required this.title,
    required this.category,
    required this.borrowCount,
  });

  /// JSON -> 模型。JSON 数字可能是 int 或 double，统一 as num 再 toInt 最稳。
  factory Book.fromJson(Map<String, dynamic> j) => Book(
        id: j['id'] as String,
        title: j['title'] as String,
        category: j['category'] as String,
        borrowCount: (j['borrowCount'] as num).toInt(),
      );

  /// 模型 -> JSON，用于 roundtrip 反向验证。
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'category': category,
        'borrowCount': borrowCount,
      };

  @override
  String toString() => 'Book($id, $title, $category, $borrowCount)';
}
