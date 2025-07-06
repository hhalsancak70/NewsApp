/// A model class representing a news article.
class Article {
  final String? id;              // Optional unique identifier
  final String? source;          // Optional name of the source (e.g., BBC News)
  final String? author;          // Optional author name
  final String title;            // Required title of the article
  final String? description;     // Optional short summary of the article
  final String url;              // Required URL to the full article
  final String? urlToImage;      // Optional image URL
  final String publishedAt;      // Required published date as ISO string
  final String? content;         // Optional full content of the article

  /// Constructor to create an [Article] instance
  Article({
    this.id,
    this.source,
    this.author,
    required this.title,
    this.description,
    required this.url,
    this.urlToImage,
    required this.publishedAt,
    this.content,
  });

  /// Factory constructor to create an [Article] from a JSON map.
  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id']?.toString(),                        // Convert ID to string if not null
      source: json['source']?['name'],                   // Extract source name safely
      author: json['author'],                            // Author can be null
      title: json['title'] ?? '',                        // Fallback to empty string if missing
      description: json['description'],                  // Optional description
      url: json['url'] ?? '',                            // Required URL, fallback to empty
      urlToImage: json['urlToImage'],                    // Optional image URL
      publishedAt: json['publishedAt'] ?? DateTime.now().toIso8601String(), // Fallback to now
      content: json['content'],                          // Optional content
    );
  }

  /// Converts the [Article] instance into a JSON-compatible map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'source': {'name': source},  // Source is nested in a map with 'name' key
      'author': author,
      'title': title,
      'description': description,
      'url': url,
      'urlToImage': urlToImage,
      'publishedAt': publishedAt,
      'content': content,
    };
  }
}
