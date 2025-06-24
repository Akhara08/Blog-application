class Post {
  final int id;
  final String title;
  final String? summary;
  final String? content;
  final String? author;
  final String? createdAt;

  Post({
    required this.id,
    required this.title,
    this.summary,
    this.content,
    this.author,
    this.createdAt,
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json['id'],
        title: json['title'],
        summary: json['summary'],
        content: json['content'],
        author: json['author']?.toString(),
        createdAt: json['created_at'],
      );
}
