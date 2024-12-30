import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

// メインのスライダーウィジェット
class HooksAdvertisementSlider extends HookWidget {
  const HooksAdvertisementSlider({super.key});

  @override
  Widget build(BuildContext context) {
    // Hooks
    final pageController = usePageController();
    final currentPage = useState(0);

    // タイマーの設定
    useEffect(() {
      final timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        final nextPage = currentPage.value < 4 ? currentPage.value + 1 : 0;
        pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeIn,
        );
      });

      return timer.cancel; // cleanup関数
    }, []); // 空の依存配列で一度だけ実行

    // 画面サイズの取得
    final screenWidth = MediaQuery.of(context).size.width;
    final adSize = screenWidth * 0.8;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text('HooksDot Indicator Slider'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 広告スライダー
          SizedBox(
            width: adSize,
            height: adSize,
            child: PageView.builder(
              controller: pageController,
              onPageChanged: (page) => currentPage.value = page,
              itemCount: 5,
              itemBuilder: (context, index) => _AdItem(index: index),
            ),
          ),
          const SizedBox(height: 16),
          // ドットインジケーター
          _DotIndicator(
            currentPage: currentPage.value,
            pageCount: 5,
          ),
        ],
      ),
    );
  }
}

// 広告アイテムコンポーネント
class _AdItem extends StatelessWidget {
  const _AdItem({required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Center(
        child: Text(
          '広告 ${index + 1}',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

// ドットインジケーターコンポーネント
class _DotIndicator extends StatelessWidget {
  const _DotIndicator({
    required this.currentPage,
    required this.pageCount,
  });

  final int currentPage;
  final int pageCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        pageCount,
        (index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: 8,
            width: 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: currentPage == index
                  ? Colors.black.withAlpha(0xFF)
                  : Colors.black.withAlpha(0x40),
            ),
          ),
        ),
      ),
    );
  }
}
