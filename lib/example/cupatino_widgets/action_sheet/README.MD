## CupertinoActionSheet
`CupertinoActionSheet`は、iOS風のアクションシートを表示するためのWidgetで、以下のような一般的なユースケースがあります：

1. **共有機能**
```dart
CupertinoActionSheet(
  title: const Text('共有'),
  actions: [
    CupertinoActionSheetAction(
      child: const Text('Twitter'),
      onPressed: () => shareToTwitter(),
    ),
    CupertinoActionSheetAction(
      child: const Text('LINE'),
      onPressed: () => shareToLine(),
    ),
    CupertinoActionSheetAction(
      child: const Text('Instagram'),
      onPressed: () => shareToInstagram(),
    ),
  ],
)
```

2. **画像選択オプション**
```dart
CupertinoActionSheet(
  title: const Text('写真を選択'),
  actions: [
    CupertinoActionSheetAction(
      child: const Text('カメラで撮影'),
      onPressed: () => openCamera(),
    ),
    CupertinoActionSheetAction(
      child: const Text('ライブラリから選択'),
      onPressed: () => openPhotoLibrary(),
    ),
  ],
)
```

3. **投稿の操作メニュー**
```dart
CupertinoActionSheet(
  actions: [
    CupertinoActionSheetAction(
      child: const Text('編集'),
      onPressed: () => editPost(),
    ),
    CupertinoActionSheetAction(
      child: const Text('保存'),
      onPressed: () => savePost(),
    ),
    CupertinoActionSheetAction(
      isDestructiveAction: true,
      child: const Text('削除'),
      onPressed: () => deletePost(),
    ),
  ],
)
```

4. **設定オプション**
```dart
CupertinoActionSheet(
  title: const Text('表示設定'),
  actions: [
    CupertinoActionSheetAction(
      child: const Text('ダークモード'),
      onPressed: () => toggleDarkMode(),
    ),
    CupertinoActionSheetAction(
      child: const Text('文字サイズ変更'),
      onPressed: () => changeFontSize(),
    ),
  ],
)
```

5. **ログアウト確認**
```dart
CupertinoActionSheet(
  title: const Text('ログアウト'),
  message: const Text('本当にログアウトしますか？'),
  actions: [
    CupertinoActionSheetAction(
      isDestructiveAction: true,
      child: const Text('ログアウト'),
      onPressed: () => logout(),
    ),
  ],
  cancelButton: CupertinoActionSheetAction(
    child: const Text('キャンセル'),
    onPressed: () => Navigator.pop(context),
  ),
)
```

実際のアプリでの使用例：

1. **Instagram**
- 投稿の共有
- ストーリーの操作
- 投稿のオプションメニュー

2. **LINE**
- メッセージの操作
- 写真/動画の選択
- グループ設定の変更

3. **食事配達アプリ**
- 注文のキャンセル
- 配達オプションの選択
- レストランの並び替え

4. **音楽アプリ**
- プレイリストの操作
- 曲の共有
- 再生オプション

主な特徴：
- iOS風のデザイン
- アニメーションの挙動がiOSネイティブに近い
- キャンセルボタンが独立して表示
- 破壊的なアクション（削除など）を赤色で表示可能
- ボタンのスタイルをカスタマイズ可能

使用時の注意点：
1. Androidでは異なるデザインガイドラインがある
2. Material Designを使用する場合は`BottomSheet`を検討
3. 操作の重要度に応じて適切な表示順序を考慮
4. キャンセルオプションは常に用意する