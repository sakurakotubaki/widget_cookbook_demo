import 'dart:async';
import 'package:flutter/material.dart';

class AdvertisementSlider extends StatefulWidget {
  const AdvertisementSlider({super.key});

  @override
  State<AdvertisementSlider> createState() => _AdvertisementSliderState();
}

class _AdvertisementSliderState extends State<AdvertisementSlider> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (_currentPage < 4) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 画面の幅を取得
    final screenWidth = MediaQuery.of(context).size.width;
    // 広告の正方形サイズを画面幅の80%に設定
    final adSize = screenWidth * 0.8;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 広告スライダー
          SizedBox(
            width: adSize,
            height: adSize,
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              itemCount: 5,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    color: Colors.blue, // 青色の背景
                    borderRadius: BorderRadius.circular(4), // 角を少し丸く
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
              },
            ),
          ),
          // ドットインジケーター
          const SizedBox(height: 16), // 広告とドットの間隔
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: 8,
                  width: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentPage == index
                        ? Colors.black.withAlpha(0xFF)
                        : Colors.black.withAlpha(0x40),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

// 使用例
class AdSliderPage extends StatelessWidget {
  const AdSliderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white, // 背景色を白に
      body: Center(
        child: AdvertisementSlider(),
      ),
    );
  }
}
