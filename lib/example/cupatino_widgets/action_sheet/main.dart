import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      theme: CupertinoThemeData(brightness: Brightness.light),
      home: MyWidget(),
    );
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  // カメラで撮影
  Future<void> _openCamera() async {
    Navigator.pop(context); // アクションシートを閉じる
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      setState(() {
        _image = File(photo.path);
      });
    }
  }

  // フォトライブラリから選択
  Future<void> _openPhotoLibrary() async {
    Navigator.pop(context); // アクションシートを閉じる
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  // アクションシートを表示
  void _showActionSheet(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text('写真を選択'),
        message: const Text('写真を追加する方法を選択してください'),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            onPressed: _openCamera,
            child: const Text('カメラで撮影'),
          ),
          CupertinoActionSheetAction(
            onPressed: _openPhotoLibrary,
            child: const Text('ライブラリから選択'),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          isDefaultAction: true,
          onPressed: () => Navigator.pop(context),
          child: const Text('キャンセル'),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('写真選択サンプル'),
      ),
      child: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 選択した画像を表示
              if (_image != null)
                Container(
                  width: 200,
                  height: 200,
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: FileImage(_image!),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                )
              else
                Container(
                  width: 200,
                  height: 200,
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: CupertinoColors.systemGrey5,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Text('写真が選択されていません'),
                  ),
                ),
              // 写真選択ボタン
              CupertinoButton.filled(
                onPressed: () => _showActionSheet(context),
                child: const Text('写真を選択'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
