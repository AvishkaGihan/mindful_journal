/// Represents a single journal entry
/// This class defines the structure of our data
class Entry {
  final int? id; // Unique identifier (null before saving to DB)
  final String title; // Entry title
  final String content; // Journal text
  final DateTime createdAt; // When it was created
  final String? aiInsight; // Optional AI-generated insight

  Entry({
    this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    this.aiInsight,
  });

  /// Convert Entry to Map for database storage
  /// SQLite stores data as key-value pairs
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'createdAt': createdAt.toIso8601String(), // Convert DateTime to String
      'aiInsight': aiInsight,
    };
  }

  /// Create Entry from database Map
  /// This is called a "factory constructor"
  factory Entry.fromMap(Map<String, dynamic> map) {
    return Entry(
      id: map['id'] as int?,
      title: map['title'] as String,
      content: map['content'] as String,
      createdAt: DateTime.parse(map['createdAt'] as String),
      aiInsight: map['aiInsight'] as String?,
    );
  }

  /// Create a copy of this Entry with some fields changed
  /// Useful for updating entries
  Entry copyWith({
    int? id,
    String? title,
    String? content,
    DateTime? createdAt,
    String? aiInsight,
  }) {
    return Entry(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      aiInsight: aiInsight ?? this.aiInsight,
    );
  }
}
