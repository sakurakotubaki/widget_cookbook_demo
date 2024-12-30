import 'package:flutter/material.dart';
import 'image_cards.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      home: const CardDemoPage(),
    );
  }
}

class CardDemoPage extends StatelessWidget {
  const CardDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('カードデザインデモ'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            const Text(
              '1. 縦長カード',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 360,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: VerticalImageCard(
                      imageUrl: 'assets/images/couch.jpg',
                      title: 'モダンソファ',
                      subtitle: '快適な座り心地',
                      price: '¥29,800',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: VerticalImageCard(
                      imageUrl: 'assets/images/da.jpg',
                      title: 'ダイニングセット',
                      subtitle: '4人掛けテーブル',
                      price: '¥45,800',
                    ),
                  ),
                  VerticalImageCard(
                    imageUrl: 'assets/images/living.jpg',
                    title: 'リビングセット',
                    subtitle: 'シンプルデザイン',
                    price: '¥89,800',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              '2. 正方形カード',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 0.8,
              children: [
                SquareImageCard(
                  imageUrl: 'assets/images/couch.jpg',
                  title: 'モダンソファ',
                  subtitle: '快適な座り心地',
                  price: '¥29,800',
                ),
                SquareImageCard(
                  imageUrl: 'assets/images/da.jpg',
                  title: 'ダイニングセット',
                  subtitle: '4人掛けテーブル',
                  price: '¥45,800',
                ),
              ],
            ),
            const SizedBox(height: 32),
            const Text(
              '3. 横長カード',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            HorizontalImageCard(
              imageUrl: 'assets/images/couch.jpg',
              title: 'モダンソファ',
              subtitle: '快適な座り心地',
              price: '¥29,800',
            ),
            const SizedBox(height: 16),
            HorizontalImageCard(
              imageUrl: 'assets/images/da.jpg',
              title: 'ダイニングセット',
              subtitle: '4人掛けテーブル',
              price: '¥45,800',
            ),
            const SizedBox(height: 16),
            HorizontalImageCard(
              imageUrl: 'assets/images/living.jpg',
              title: 'リビングセット',
              subtitle: 'シンプルデザイン',
              price: '¥89,800',
            ),
          ],
        ),
      ),
    );
  }
}
