class Post {
  final String id;
  final String username;
  final String content;
  final String timestamp;
  final int likes;
  final String avatarUrl;

  Post({
    required this.id,
    required this.username,
    required this.content,
    required this.timestamp,
    required this.likes,
    required this.avatarUrl,
  });
}
