import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // プラットフォームに応じてテーマを変更
    return Platform.isIOS
        ? CupertinoApp(
            title: 'Platform UI Demo',
            theme: const CupertinoThemeData(brightness: Brightness.light),
            home: const PlatformUIExample(),
          )
        : MaterialApp(
            title: 'Platform UI Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              useMaterial3: true,
            ),
            home: const PlatformUIExample(),
          );
  }
}

class PlatformUIExample extends StatefulWidget {
  const PlatformUIExample({super.key});

  @override
  State<PlatformUIExample> createState() => _PlatformUIExampleState();
}

class _PlatformUIExampleState extends State<PlatformUIExample> {
  DateTime _selectedDate = DateTime.now();
  final String _platformName = Platform.isIOS ? 'iOS' : 'Android';

  // 日付ピッカーを表示
  void _showDatePicker() {
    if (Platform.isIOS) {
      // iOS風のピッカー
      showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => Container(
          height: 216,
          padding: const EdgeInsets.only(top: 6.0),
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          color: CupertinoColors.systemBackground.resolveFrom(context),
          child: SafeArea(
            top: false,
            child: CupertinoDatePicker(
              initialDateTime: _selectedDate,
              mode: CupertinoDatePickerMode.date,
              use24hFormat: true,
              onDateTimeChanged: (DateTime newDate) {
                setState(() => _selectedDate = newDate);
              },
            ),
          ),
        ),
      );
    } else {
      // Android風のピッカー
      showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(2025),
      ).then((date) {
        if (date != null) {
          setState(() => _selectedDate = date);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // iOS用のウィジェット
    if (Platform.isIOS) {
      return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text('$_platformName Style UI'),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '選択された日付: ${_selectedDate.toString().split(' ')[0]}',
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 20),
                CupertinoButton(
                  onPressed: _showDatePicker,
                  color: CupertinoColors.activeBlue,
                  child: const Text('日付を選択'),
                ),
                const SizedBox(height: 20),
                // iOS風のアクションシート表示ボタン
                CupertinoButton(
                  onPressed: () {
                    showCupertinoModalPopup<void>(
                      context: context,
                      builder: (BuildContext context) => CupertinoActionSheet(
                        title: const Text('アクション'),
                        actions: <CupertinoActionSheetAction>[
                          CupertinoActionSheetAction(
                            child: const Text('オプション 1'),
                            onPressed: () => Navigator.pop(context),
                          ),
                          CupertinoActionSheetAction(
                            child: const Text('オプション 2'),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                        cancelButton: CupertinoActionSheetAction(
                          isDefaultAction: true,
                          onPressed: () => Navigator.pop(context),
                          child: const Text('キャンセル'),
                        ),
                      ),
                    );
                  },
                  child: const Text('アクションシートを表示'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    // Android用のウィジェット
    return Scaffold(
      appBar: AppBar(
        title: Text('$_platformName Style UI'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '選択された日付: ${_selectedDate.toString().split(' ')[0]}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _showDatePicker,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
              ),
              child: const Text('日付を選択', style: TextStyle(fontSize: 18)),
            ),
            const SizedBox(height: 20),
            // Android風のボトムシート表示ボタン
            ElevatedButton(
              onPressed: () {
                showModalBottomSheet<void>(
                  context: context,
                  builder: (BuildContext context) => Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        leading: const Icon(Icons.photo),
                        title: const Text('オプション 1'),
                        onTap: () => Navigator.pop(context),
                      ),
                      ListTile(
                        leading: const Icon(Icons.music_note),
                        title: const Text('オプション 2'),
                        onTap: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
              ),
              child: const Text('ボトムシートを表示', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
