import 'package:flutter/material.dart';

import '../data/product_data.dart';
import '../theme.dart';
import '../widgets/cart_icon_button.dart';
import '../widgets/product_card.dart';

/// Special category name that shows every product (used by "See all").
const String allProductsCategory = 'All Products';

/// Responsive grid: as many columns as fit, each at most 220px wide.
const SliverGridDelegate productGridDelegate =
    SliverGridDelegateWithMaxCrossAxisExtent(
      maxCrossAxisExtent: 220,
      mainAxisExtent: 280,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
    );

void openCategory(BuildContext context, String categoryName) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => CategoryPage(categoryName: categoryName),
    ),
  );
}

class CategoryPage extends StatelessWidget {
  final String categoryName;

  const CategoryPage({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final items = categoryName == allProductsCategory
        ? products
        : productsByCategory(categoryName);

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName),
        actions: const [CartIconButton(), SizedBox(width: 4)],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
            child: Text(
              items.length == 1 ? '1 product' : '${items.length} products',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: AppColors.muted,
              ),
            ),
          ),
          Expanded(
            child: items.isEmpty
                ? const Center(child: Text('No products in this category yet.'))
                : GridView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
                    gridDelegate: productGridDelegate,
                    itemCount: items.length,
                    itemBuilder: (context, index) =>
                        ProductCard(product: items[index]),
                  ),
          ),
        ],
      ),
    );
  }
}
