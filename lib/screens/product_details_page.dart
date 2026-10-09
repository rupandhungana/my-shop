import 'package:flutter/material.dart';

import '../data/cart.dart';
import '../data/product_data.dart';
import '../models/product.dart';
import '../theme.dart';
import '../widgets/cart_icon_button.dart';
import '../widgets/product_card.dart';
import '../widgets/product_image.dart';

class ProductDetailsPage extends StatefulWidget {
  final Product product;
  final String? heroTag;

  const ProductDetailsPage({super.key, required this.product, this.heroTag});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final theme = Theme.of(context);
    final screenHeight = MediaQuery.sizeOf(context).height;
    final image = ProductImage(url: product.image);
    final related = productsByCategory(
      product.category,
    ).where((p) => p.id != product.id).toList();

    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        title: const Text('Product Details'),
        actions: [
          FavoriteButton(product: product),
          const CartIconButton(),
          const SizedBox(width: 4),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: screenHeight * 0.4,
              width: double.infinity,
              color: AppColors.tile,
              child: widget.heroTag == null
                  ? image
                  : Hero(tag: widget.heroTag!, child: image),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.background,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          product.category,
                          style: theme.textTheme.labelMedium,
                        ),
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.star_rounded,
                        color: AppColors.star,
                        size: 20,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        product.rating.toStringAsFixed(1),
                        style: theme.textTheme.titleSmall,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    product.name,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 10,
                    runSpacing: 4,
                    children: [
                      Text(
                        formatPrice(product.price),
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      if (product.oldPrice != null) ...[
                        Text(
                          formatPrice(product.oldPrice!),
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: AppColors.muted,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        Text(
                          '${product.discountPercent}% OFF',
                          style: theme.textTheme.labelMedium?.copyWith(
                            color: AppColors.sale,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Row(
                    children: [
                      Expanded(
                        child: _Highlight(
                          icon: Icons.local_shipping_outlined,
                          label: 'Free delivery',
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: _Highlight(
                          icon: Icons.autorenew,
                          label: '7-day returns',
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: _Highlight(
                          icon: Icons.verified_outlined,
                          label: 'Genuine',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text('Description', style: theme.textTheme.titleMedium),
                  const SizedBox(height: 8),
                  Text(
                    product.description,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: AppColors.muted,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Quantity',
                          style: theme.textTheme.titleMedium,
                        ),
                      ),
                      _QuantitySelector(
                        quantity: _quantity,
                        onChanged: (value) => setState(() => _quantity = value),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (related.isNotEmpty) ...[
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
                child: Text(
                  'You may also like',
                  style: theme.textTheme.titleMedium,
                ),
              ),
              SizedBox(
                height: 270,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                  itemCount: related.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 12),
                  itemBuilder: (context, index) => SizedBox(
                    width: 170,
                    child: ProductCard(
                      product: related[index],
                      heroPrefix: 'related',
                    ),
                  ),
                ),
              ),
            ] else
              const SizedBox(height: 24),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: AppColors.surface,
          border: Border(top: BorderSide(color: AppColors.border)),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
            child: Row(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: AppColors.muted,
                      ),
                    ),
                    Text(
                      formatPrice(product.price * _quantity),
                      style: theme.textTheme.titleMedium,
                    ),
                  ],
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: SizedBox(
                    height: 52,
                    child: ElevatedButton.icon(
                      onPressed: () =>
                          addToCart(context, product, quantity: _quantity),
                      icon: const Icon(Icons.add_shopping_cart_outlined),
                      label: const Text('Add to Cart'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _QuantitySelector extends StatelessWidget {
  final int quantity;
  final ValueChanged<int> onChanged;

  const _QuantitySelector({required this.quantity, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            tooltip: 'Decrease',
            icon: const Icon(Icons.remove),
            onPressed: quantity > 1 ? () => onChanged(quantity - 1) : null,
          ),
          SizedBox(
            width: 28,
            child: Text(
              '$quantity',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          IconButton(
            tooltip: 'Increase',
            icon: const Icon(Icons.add),
            onPressed: () => onChanged(quantity + 1),
          ),
        ],
      ),
    );
  }
}

class _Highlight extends StatelessWidget {
  final IconData icon;
  final String label;

  const _Highlight({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, size: 22, color: AppColors.ink),
          const SizedBox(height: 6),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ],
      ),
    );
  }
}
