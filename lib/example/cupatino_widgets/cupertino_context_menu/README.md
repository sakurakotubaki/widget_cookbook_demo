##  Use CupertinoContextMenu
`CupertinoContextMenu`を使用して、iOS風の長押しメニューを実装するデモを作成します。写真や投稿に対するアクションメニューを例として実装してみましょう。


このデモでは以下の3つのコンテキストメニューの例を実装しています：

1. **画像のコンテキストメニュー**
- いいね
- 共有
- 保存
- 削除（破壊的アクション）

2. **テキストのコンテキストメニュー**
- コピー（クリップボードにコピー）
- 共有

3. **カスタムカードのコンテキストメニュー**
- 編集
- ブックマーク
- 共有
- 削除（破壊的アクション）

主な特徴：

1. **アクションの種類**
```dart
CupertinoContextMenuAction(
  onPressed: () { /* アクション */ },
  trailingIcon: CupertinoIcons.heart,  // アイコンの追加
  child: const Text('いいね'),
)
```

2. **破壊的アクション**
```dart
CupertinoContextMenuAction(
  isDestructiveAction: true,  // 赤色で表示
  onPressed: () { /* アクション */ },
  child: const Text('削除'),
)
```

3. **実用的な機能**
```dart
// クリップボードへのコピー
Clipboard.setData(const ClipboardData(text: 'テキスト'));
```

4. **カスタマイズ可能なデザイン**
```dart
Container(
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(8),
    // その他のスタイリング
  ),
  child: /* コンテンツ */,
)
```

使用シーン：

1. **SNSアプリ**
- 投稿の操作
- コメントの操作
- プロフィール情報の操作

2. **メッセージアプリ**
- メッセージの操作
- 添付ファイルの操作
- 連絡先の操作

3. **ドキュメントアプリ**
- テキストの編集操作
- ファイルの操作
- フォルダの操作

注意点：

1. メニューが開いている時は必ず閉じる方法を提供
```dart
onPressed: () {
  Navigator.pop(context);  // メニューを閉じる
}
```

2. 適切なアイコンの選択
3. 破壊的アクションの慎重な使用
4. アクセシビリティへの配慮

このように、`CupertinoContextMenu`はiOSスタイルのアプリで直感的な操作を提供するのに役立ちます。