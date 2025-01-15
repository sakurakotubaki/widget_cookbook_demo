# Flutter Infinite Scroll SNS Demo

シンプルなSNSフィードを模したFlutterアプリケーションで、無限スクロール機能を実装しています。

## 主な機能

1. **無限スクロール**
   - ScrollControllerを使用してスクロール位置を監視
   - 下端から200ピクセルの位置で新しいデータを読み込み
   - ローディング中の重複読み込みを防止

2. **データ管理**
   - 1ページあたり5件の投稿を表示
   - 投稿データは`Post`モデルクラスで管理
   - ページ番号による投稿の管理

3. **UI機能**
   - スクロールバー表示（常時表示）
   - プルトゥリフレッシュ対応
   - ローディング中はCircularProgressIndicatorを表示
   - カード形式での投稿表示

## 実装の詳細

### スクロール制御
```dart
void _onScroll() {
  final maxScroll = _scrollController.position.maxScrollExtent;
  final currentScroll = _scrollController.position.pixels;
  final threshold = maxScroll - 200.0;

  if (currentScroll >= threshold && !_isLoading) {
    _loadMorePosts();
  }
}
```

### データ読み込み
- 初期データ：`_loadInitialPosts()`で5件読み込み
- 追加データ：`_loadMorePosts()`で5件ずつ追加
- ダミーデータ生成：`_generateDummyPosts()`で投稿データを生成

### 投稿表示
- ユーザーアバター（ダミー画像）
- ユーザー名
- タイムスタンプ
- 投稿内容
- いいね数

### エラー防止機能
- `mounted`チェックによるメモリリーク防止
- ローディング状態管理による重複読み込み防止
- `dispose()`でのリソース解放

## 使用方法

1. アプリ起動時に最初の5件が表示されます
2. 下にスクロールすると自動的に次の5件が読み込まれます
3. 画面を引っ張って更新すると、データがリセットされます
4. 右側のスクロールバーで現在位置を確認できます