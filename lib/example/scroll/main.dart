import 'package:flutter/material.dart';
import 'post_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple SNS',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const SNSFeedScreen(),
    );
  }
}

class SNSFeedScreen extends StatefulWidget {
  const SNSFeedScreen({super.key});

  @override
  State<SNSFeedScreen> createState() => _SNSFeedScreenState();
}

class _SNSFeedScreenState extends State<SNSFeedScreen> {
  final ScrollController _scrollController = ScrollController();
  final List<Post> _posts = [];
  bool _isLoading = false;
  int _currentPage = 0;
  static const int _postsPerPage = 5;

  @override
  void initState() {
    super.initState();
    _loadInitialPosts();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    final threshold = maxScroll - 200.0;

    // debugPrint('Scroll Position: $currentScroll / $maxScroll (Threshold: $threshold)');

    if (currentScroll >= threshold && !_isLoading) {
      // debugPrint('Loading more posts... (Page: ${_currentPage + 1})');
      _loadMorePosts();
    }
  }

  Future<void> _loadInitialPosts() async {
    if (_isLoading) return;

    // debugPrint('Loading initial posts...');
    setState(() {
      _isLoading = true;
      _posts.clear();
    });

    await Future.delayed(const Duration(milliseconds: 500));

    if (mounted) {
      setState(() {
        _posts.addAll(_generateDummyPosts(0, _postsPerPage));
        _isLoading = false;
        _currentPage = 0;
      });
      // debugPrint('Initial posts loaded: ${_posts.length} posts');
    }
  }

  Future<void> _loadMorePosts() async {
    if (_isLoading) return;

    debugPrint('Starting to load more posts...');
    setState(() {
      _isLoading = true;
    });

    await Future.delayed(const Duration(milliseconds: 500));

    if (mounted) {
      final newPosts = _generateDummyPosts(
        (_currentPage + 1) * _postsPerPage,
        _postsPerPage,
      );

      setState(() {
        _posts.addAll(newPosts);
        _currentPage++;
        _isLoading = false;
      });

      debugPrint('Loaded more posts. Total: ${_posts.length} posts');
    }
  }

  List<Post> _generateDummyPosts(int startIndex, int count) {
    final List<String> dummyContents = [
      '今日は素晴らしい一日でした！',
      '新しいプロジェクトを始めました！',
      'フラッターの勉強中です。とても楽しい！',
      '週末は友達と旅行に行きます！',
      'おいしいラーメンを食べました！',
      '新しい技術を学ぶのは楽しいですね',
      'コーディング中です！',
      '今日も一日頑張りました！',
    ];

    return List.generate(count, (index) {
      final actualIndex = startIndex + index;
      return Post(
        id: 'post_$actualIndex',
        username: 'ユーザー${(actualIndex % 10) + 1}',
        content:
            '${dummyContents[actualIndex % dummyContents.length]} (Post #${actualIndex + 1})',
        timestamp: '${actualIndex * 5}分前',
        likes: (actualIndex * 7) % 100 + 1,
        avatarUrl: 'https://i.pravatar.cc/150?img=${(actualIndex % 10) + 1}',
      );
    });
  }

  Future<void> _onRefresh() async {
    // debugPrint('Refreshing feed...');
    await _loadInitialPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple SNS'),
        elevation: 1,
      ),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: Scrollbar(
          controller: _scrollController,
          thumbVisibility: true,
          thickness: 8,
          radius: const Radius.circular(4),
          child: ListView.builder(
            controller: _scrollController,
            itemCount: _posts.length + 1,
            itemBuilder: (context, index) {
              if (index == _posts.length) {
                if (_isLoading) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else {
                  return const SizedBox(height: 80);
                }
              }

              final post = _posts[index];
              return Card(
                margin:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(post.avatarUrl),
                            radius: 20,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  post.username,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  post.timestamp,
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(post.content),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.favorite,
                              color: Colors.red[400], size: 20),
                          const SizedBox(width: 4),
                          Text('${post.likes}'),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
