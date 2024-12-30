import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      debugShowCheckedModeBanner: false,
      theme: CupertinoThemeData(brightness: Brightness.light),
      home: ContextMenuDemo(),
    );
  }
}

class ContextMenuDemo extends StatelessWidget {
  const ContextMenuDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('コンテキストメニューデモ'),
      ),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // テキストのコンテキストメニュー
            const Text(
              'テキストを長押ししてみてください',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            CupertinoContextMenu(
              actions: <CupertinoContextMenuAction>[
                CupertinoContextMenuAction(
                  onPressed: () {
                    Clipboard.setData(const ClipboardData(
                      text: 'これはサンプルテキストです。長押しでコピーできます。',
                    ));
                    Navigator.pop(context);
                  },
                  trailingIcon: CupertinoIcons.doc_on_doc,
                  child: const Text('コピー'),
                ),
                CupertinoContextMenuAction(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  trailingIcon: CupertinoIcons.share,
                  child: const Text('共有'),
                ),
              ],
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: CupertinoColors.systemGrey6,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'これはサンプルテキストです。長押しでコピーできます。',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 32),

            // カスタムカードのコンテキストメニュー
            const Text(
              'カードを長押ししてみてください',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            CupertinoContextMenu(
              actions: <CupertinoContextMenuAction>[
                CupertinoContextMenuAction(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  trailingIcon: CupertinoIcons.pencil,
                  child: const Text('編集'),
                ),
                CupertinoContextMenuAction(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  trailingIcon: CupertinoIcons.bookmark,
                  child: const Text('ブックマーク'),
                ),
                CupertinoContextMenuAction(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  trailingIcon: CupertinoIcons.share,
                  child: const Text('共有'),
                ),
                CupertinoContextMenuAction(
                  isDestructiveAction: true,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  trailingIcon: CupertinoIcons.delete,
                  child: const Text('削除'),
                ),
              ],
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: CupertinoColors.systemGrey6,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: CupertinoColors.systemGrey4,
                    width: 1,
                  ),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'カスタムカード',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'これはカスタムカードのサンプルです。長押しで様々なアクションを実行できます。',
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
