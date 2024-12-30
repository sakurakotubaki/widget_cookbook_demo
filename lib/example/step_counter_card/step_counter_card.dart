import 'package:flutter/material.dart';

class StepCounterCard extends StatelessWidget {
  const StepCounterCard({
    super.key,
    required this.currentSteps,
    required this.goalSteps,
    required this.message,
  });

  final int currentSteps;
  final int goalSteps;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // ヘッダー部分
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '今日の歩数',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.info_outline),
                  onPressed: () {}, // 情報ボタンの処理
                ),
              ],
            ),

            // 歩数表示
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  '$currentSteps',
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  ' 歩',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // プログレスバー
            LinearProgressIndicator(
              value: currentSteps / goalSteps,
              backgroundColor: Colors.grey[200],
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
              minHeight: 8,
            ),

            // 目標値表示
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('0 歩'),
                  Text('${goalSteps ~/ 2} 歩'),
                  Text('$goalSteps 歩'),
                ],
              ),
            ),

            // メッセージ
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text(
                message,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
