import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Furniture Shop',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeContent(),
    const FavoritesPage(),
    const CartPage(),
    const SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: _pages[_selectedIndex],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onIndexChanged: (index) => setState(() => _selectedIndex = index),
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> _furnitureItems = [
      {
        'image': 'couch.jpg',
        'title': 'ソファ',
        'subtitle': 'モダンデザイン',
      },
      {
        'image': 'da.jpg',
        'title': 'ダイニング',
        'subtitle': 'ナチュラル',
      },
      {
        'image': 'living.jpg',
        'title': 'リビング',
        'subtitle': 'シンプル',
      },
    ];

    return Column(
      children: [
        const SearchBar(),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.8,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
            ),
            itemCount: _furnitureItems.length,
            itemBuilder: (context, index) {
              final item = _furnitureItems[index];
              return FurnitureCard(
                title: item['title']!,
                subtitle: item['subtitle']!,
                imageUrl: 'assets/images/${item['image']}',
              );
            },
          ),
        ),
      ],
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(0x05),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Center(
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: '検索',
                    hintStyle: const TextStyle(
                      color: Colors.black38,
                      height: 1.1,
                    ),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.black54,
                      size: 20,
                    ),
                    prefixIconConstraints: const BoxConstraints(
                      minWidth: 40,
                      minHeight: 40,
                    ),
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                // 検索ボタンが押された時の処理
                debugPrint('検索ボタンが押されました');
              },
              borderRadius: BorderRadius.circular(12),
              child: Ink(
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 24),
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Text(
                    '検索',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onIndexChanged;

  const CustomBottomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onIndexChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(0x05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CustomBottomNavigationItem(
            icon: Icons.home_outlined,
            activeIcon: Icons.home,
            label: 'ホーム',
            isSelected: selectedIndex == 0,
            onTap: () => onIndexChanged(0),
          ),
          CustomBottomNavigationItem(
            icon: Icons.favorite_outline,
            activeIcon: Icons.favorite,
            label: 'お気に入り',
            isSelected: selectedIndex == 1,
            onTap: () => onIndexChanged(1),
          ),
          CustomBottomNavigationItem(
            icon: Icons.shopping_cart_outlined,
            activeIcon: Icons.shopping_cart,
            label: 'カート',
            isSelected: selectedIndex == 2,
            onTap: () => onIndexChanged(2),
          ),
          CustomBottomNavigationItem(
            icon: Icons.settings_outlined,
            activeIcon: Icons.settings,
            label: '設定',
            isSelected: selectedIndex == 3,
            onTap: () => onIndexChanged(3),
          ),
        ],
      ),
    );
  }
}

class CustomBottomNavigationItem extends StatelessWidget {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const CustomBottomNavigationItem({
    super.key,
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.transparent,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected ? activeIcon : icon,
              color: isSelected ? Colors.white : Colors.grey,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: isSelected ? Colors.white : Colors.grey,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'お気に入りページ',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          '設定',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 24),
        SettingsItem(
          icon: Icons.person_outline,
          title: 'プロフィール',
          onTap: () {},
        ),
        SettingsItem(
          icon: Icons.notifications_none,
          title: '通知',
          onTap: () {},
        ),
        SettingsItem(
          icon: Icons.payment,
          title: '支払い方法',
          onTap: () {},
        ),
        SettingsItem(
          icon: Icons.security,
          title: 'セキュリティ',
          onTap: () {},
        ),
        SettingsItem(
          icon: Icons.help_outline,
          title: 'ヘルプ',
          onTap: () {},
        ),
      ],
    );
  }
}

class SettingsItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const SettingsItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        child: Row(
          children: [
            Icon(icon, size: 24, color: Colors.black87),
            const SizedBox(width: 16),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.black54,
            ),
          ],
        ),
      ),
    );
  }
}

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final List<Map<String, dynamic>> _cartItems = [
    {
      'image': 'couch.jpg',
      'title': 'ソファ',
      'price': 15000,
      'quantity': 1,
    },
    {
      'image': 'da.jpg',
      'title': 'ダイニング',
      'price': 15000,
      'quantity': 1,
    },
    {
      'image': 'living.jpg',
      'title': 'リビング',
      'price': 15000,
      'quantity': 1,
    },
  ];

  int get totalQuantity => _cartItems.fold(0, (sum, item) => sum + item['quantity'] as int);
  int get totalPrice => _cartItems.fold(0, (sum, item) => sum + (item['price'] * item['quantity']) as int);

  void _updateQuantity(int index, int delta) {
    setState(() {
      final newQuantity = _cartItems[index]['quantity'] + delta;
      if (newQuantity >= 1 && newQuantity <= 99) {
        _cartItems[index]['quantity'] = newQuantity;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _cartItems.length,
              itemBuilder: (context, index) {
                final item = _cartItems[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: CartItem(
                    title: item['title']!,
                    price: '¥${item['price']}',
                    quantity: item['quantity'],
                    imageUrl: 'assets/images/${item['image']}',
                    onIncrease: () => _updateQuantity(index, 1),
                    onDecrease: () => _updateQuantity(index, -1),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(32),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(0x05),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      '合計',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '$totalQuantity点',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      '税込合計',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '¥${totalPrice.toString()}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black87,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      '購入へ進む',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CartItem extends StatelessWidget {
  final String title;
  final String price;
  final int quantity;
  final String imageUrl;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;

  const CartItem({
    super.key,
    required this.title,
    required this.price,
    required this.quantity,
    required this.imageUrl,
    required this.onIncrease,
    required this.onDecrease,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(0x05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              imageUrl,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  price,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              _QuantityButton(
                icon: Icons.remove,
                onPressed: onDecrease,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  quantity.toString().padLeft(2, '0'),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              _QuantityButton(
                icon: Icons.add,
                onPressed: onIncrease,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _QuantityButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const _QuantityButton({
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          size: 16,
          color: Colors.grey[700],
        ),
      ),
    );
  }
}

class FurnitureCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageUrl;

  const FurnitureCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(0x05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.asset(
                imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
