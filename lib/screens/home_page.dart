import 'package:flutter/material.dart';

import '../data/product_data.dart';
import '../widgets/banner_carousel.dart';
import '../widgets/cart_icon_button.dart';
import '../widgets/category_item.dart';
import '../widgets/product_card.dart';
import '../widgets/product_search_delegate.dart';
import 'category_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final popular = products.where((p) => p.rating >= 4.5).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'MyShop',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        actions: [
          IconButton(
            tooltip: 'Search',
            icon: const Icon(Icons.search),
            onPressed: () =>
                showSearch(context: context, delegate: ProductSearchDelegate()),
          ),
          const CartIconButton(),
          const SizedBox(width: 4),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 8, bottom: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const BannerCarousel(),
            const SizedBox(height: 24),
            const _SectionHeader(title: 'What are you shopping for today?'),
            const SizedBox(height: 12),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: categories
                    .map((category) => CategoryItem(category: category))
                    .toList(),
              ),
            ),
            const SizedBox(height: 24),
            _SectionHeader(
              title: 'Popular Products',
              onSeeAll: () => openCategory(context, allProductsCategory),
            ),
            const SizedBox(height: 8),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              gridDelegate: productGridDelegate,
              itemCount: popular.length,
              itemBuilder: (context, index) =>
                  ProductCard(product: popular[index]),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onSeeAll;

  const _SectionHeader({required this.title, this.onSeeAll});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 8, 0),
      child: Row(
        children: [
          Expanded(
            child: Text(title, style: Theme.of(context).textTheme.titleMedium),
          ),
          if (onSeeAll != null)
            TextButton.icon(
              onPressed: onSeeAll,
              icon: const Icon(Icons.arrow_forward, size: 18),
              iconAlignment: IconAlignment.end,
              label: const Text('See All'),
            ),
        ],
      ),
    );
  }
}
