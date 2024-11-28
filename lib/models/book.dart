// models/book.dart

class Book {
  final String title;
  final String author;
  final String coverUrl;
  final List<Chapter> chapters;

  Book({
    required this.title,
    required this.author,
    required this.coverUrl,
    required this.chapters,
  });

  static Book fromJson(Map<String, dynamic> json) {
    return Book(
      title: json['title'] ?? '',
      author: json['author'] ?? '',
      coverUrl: json['cover_url'] ?? '',
      chapters: (json['chapters'] as List<dynamic>?)?.map((chapter) {
            return Chapter(
              number: chapter['number'] ?? 0,
              title: chapter['title'] ?? '',
              content: chapter['content'] ?? '',
              reads: chapter['reads'] ?? 0,
              votes: chapter['votes'] ?? 0,
            );
          }).toList() ??
          [],
    );
  }
}

class Chapter {
  final int number;
  final String title;
  final String content;
  final int reads;
  final int votes;

  Chapter({
    required this.number,
    required this.title,
    required this.content,
    required this.reads,
    required this.votes,
  });

  get updatedAt => null;
}
