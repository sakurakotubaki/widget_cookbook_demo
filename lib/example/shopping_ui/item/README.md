## 画像サイズの変更と角丸にする方法

# Flutter Image Handling Guide

## 主要なウィジェットとプロパティ

### 1. ClipRRect
角丸の画像を実現するための主要なウィジェット

```dart
ClipRRect(
  borderRadius: BorderRadius.circular(16),
  child: Image.asset(...),
)
```

**公式ドキュメント**: [ClipRRect class](https://api.flutter.dev/flutter/widgets/ClipRRect-class.html)

### 2. Image.asset
アセット画像を表示するためのウィジェット

```dart
Image.asset(
  'assets/images/example.jpg',
  width: double.infinity,
  height: 240,
  fit: BoxFit.cover,
)
```

**公式ドキュメント**: [Image class](https://api.flutter.dev/flutter/widgets/Image-class.html)

### 3. BoxFit プロパティ
画像のサイズ調整方法を指定する重要なプロパティ

- `BoxFit.cover`: アスペクト比を保ちながら、指定された領域を完全に覆うようにサイズ調整
- `BoxFit.contain`: アスペクト比を保ちながら、指定された領域内に収まるようにサイズ調整
- `BoxFit.fill`: アスペクト比を無視して、指定された領域いっぱいに引き伸ばす

**公式ドキュメント**: [BoxFit enum](https://api.flutter.dev/flutter/painting/BoxFit.html)

## レイアウトパターン

### 1. 縦長カード
```dart
Container(
  width: 180,
  child: ClipRRect(
    borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    child: Image.asset(
      imageUrl,
      height: 240,
      width: double.infinity,
      fit: BoxFit.cover,
    ),
  ),
)
```

### 2. 正方形カード
```dart
Expanded(
  child: ClipRRect(
    borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    child: Image.asset(
      imageUrl,
      width: double.infinity,
      fit: BoxFit.cover,
    ),
  ),
)
```

### 3. 横長カード
```dart
ClipRRect(
  borderRadius: BorderRadius.horizontal(left: Radius.circular(16)),
  child: Image.asset(
    imageUrl,
    width: 120,
    height: 120,
    fit: BoxFit.cover,
  ),
)
```

## ベストプラクティス

1. **画像の最適化**
   - 適切なサイズの画像を使用
   - WebPやPNGなど適切なフォーマットを選択
   - `pubspec.yaml`で画像アセットを正しく設定

2. **パフォーマンス考慮**
   - `ClipRRect`は必要な場合のみ使用（パフォーマンスに影響あり）
   - 大きな画像は必要に応じてキャッシュを検討

3. **レスポンシブ対応**
   - `double.infinity`を使用して親ウィジェットに合わせる
   - `Expanded`や`Flexible`を使用して柔軟なレイアウトを実現

## 関連するFlutterドキュメント

- [Adding assets and images](https://docs.flutter.dev/development/ui/assets-and-images)
- [Flutter cookbook: Images](https://docs.flutter.dev/cookbook/images)
- [Performance best practices](https://docs.flutter.dev/perf/rendering/best-practices)
