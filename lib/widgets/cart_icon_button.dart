import 'package:flutter/material.dart';

import '../data/cart.dart';
import '../screens/cart_page.dart';
import '../theme.dart';

/// Cart icon with a badge showing the number of items. Opens the cart page.
class CartIconButton extends StatelessWidget {
  const CartIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Map<String, int>>(
      valueListenable: cartItems,
      builder: (context, items, _) {
        final count = cartCount(items);
        return IconButton(
          tooltip: 'Cart',
          icon: Badge(
            isLabelVisible: count > 0,
            backgroundColor: AppColors.sale,
            label: Text('$count'),
            child: const Icon(Icons.shopping_cart_outlined),
          ),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CartPage()),
          ),
        );
      },
    );
  }
}
