import 'dart:async';
import 'package:flutter/cupertino.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      theme: CupertinoThemeData(brightness: Brightness.light),
      home: MyHomePage(),
    );
  }
}

// ホーム画面
class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('ローディング例'),
      ),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // API通信例
            const APILoadingExample(),
            const SizedBox(height: 20),
            // 画像読み込み例
            const ImageLoadingExample(),
            const SizedBox(height: 20),
            // ページ遷移ボタン
            CupertinoButton.filled(
              onPressed: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => const DetailPage(),
                  ),
                );
              },
              child: const Text('詳細ページへ'),
            ),
            const SizedBox(height: 20),
            // プルトゥリフレッシュ例
            const Text(
              '↓ プルトゥリフレッシュを試してください',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

// API通信のローディング例
class APILoadingExample extends StatefulWidget {
  const APILoadingExample({super.key});

  @override
  State<APILoadingExample> createState() => _APILoadingExampleState();
}

class _APILoadingExampleState extends State<APILoadingExample> {
  bool _isLoading = false;
  String _data = '未取得';

  Future<void> _fetchData() async {
    setState(() {
      _isLoading = true;
    });

    // APIリクエストのシミュレーション
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isLoading = false;
      _data = '更新されたデータ: ${DateTime.now().toString()}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoButton.filled(
      onPressed: _isLoading ? null : _fetchData,
      child: _isLoading
          ? const CupertinoActivityIndicator(color: CupertinoColors.white)
          : Text('データを取得: $_data'),
    );
  }
}

// 画像読み込みのローディング例
class ImageLoadingExample extends StatefulWidget {
  const ImageLoadingExample({super.key});

  @override
  State<ImageLoadingExample> createState() => _ImageLoadingExampleState();
}

class _ImageLoadingExampleState extends State<ImageLoadingExample> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  Future<void> _loadImage() async {
    // 画像読み込みのシミュレーション
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: CupertinoColors.systemGrey6,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: _isLoading
            ? const CupertinoActivityIndicator(radius: 15)
            : const Icon(
                CupertinoIcons.photo,
                size: 50,
                color: CupertinoColors.systemGrey,
              ),
      ),
    );
  }
}

// 詳細ページ（ページ遷移時のローディング例）
class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool _isLoading = true;
  List<String> _items = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    // データ読み込みのシミュレーション
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      setState(() {
        _isLoading = false;
        _items = List.generate(20, (index) => 'アイテム ${index + 1}');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('詳細ページ'),
      ),
      child: SafeArea(
        child: _isLoading
            ? const Center(
                child: CupertinoActivityIndicator(radius: 15),
              )
            : CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  CupertinoSliverRefreshControl(
                    onRefresh: _loadData,
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: CupertinoColors.systemGrey5,
                            ),
                          ),
                        ),
                        child: Text(_items[index]),
                      ),
                      childCount: _items.length,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
