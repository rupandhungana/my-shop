import 'package:flutter/material.dart';

import '../data/cart.dart';
import '../data/product_data.dart';
import '../models/product.dart';
import '../screens/product_details_page.dart';
import '../theme.dart';
import 'product_image.dart';

/// Reusable product card used on the home page and the category page.
class ProductCard extends StatelessWidget {
  final Product product;

  /// Prefix for the Hero tag, so the same product can appear in more than
  /// one list on a screen without duplicate Hero tags.
  final String heroPrefix;

  const ProductCard({
    super.key,
    required this.product,
    this.heroPrefix = 'grid',
  });

  String get _heroTag => '$heroPrefix-${product.id}';

  void _openDetails(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            ProductDetailsPage(product: product, heroTag: _heroTag),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final discount = product.discountPercent;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => _openDetails(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image area with badge, favourite and rating layered on top.
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Container(
                      color: AppColors.tile,
                      child: Hero(
                        tag: _heroTag,
                        child: ProductImage(url: product.image),
                      ),
                    ),
                  ),
                  if (discount != null || product.isNew)
                    Positioned(
                      top: 10,
                      left: 10,
                      child: _Badge(
                        text: discount != null ? '$discount% OFF' : 'NEW',
                        color: discount != null
                            ? AppColors.sale
                            : AppColors.ink,
                      ),
                    ),
                  Positioned(
                    top: 6,
                    right: 6,
                    child: FavoriteButton(product: product, size: 32),
                  ),
                  Positioned(
                    left: 10,
                    bottom: 10,
                    child: RatingTag(rating: product.rating),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 10, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.category.toUpperCase(),
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: AppColors.muted,
                      fontSize: 10,
                      letterSpacing: 0.8,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    product.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleSmall,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              formatPrice(product.price),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            // Always reserve this line so every card has
                            // the same height, with or without a sale price.
                            Text(
                              product.oldPrice != null
                                  ? formatPrice(product.oldPrice!)
                                  : '',
                              maxLines: 1,
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: AppColors.muted,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 6),
                      IconButton.filled(
                        tooltip: 'Add to cart',
                        style: IconButton.styleFrom(
                          backgroundColor: AppColors.ink,
                          foregroundColor: Colors.white,
                          fixedSize: const Size(34, 34),
                          minimumSize: const Size(34, 34),
                          padding: EdgeInsets.zero,
                        ),
                        iconSize: 20,
                        icon: const Icon(Icons.add),
                        onPressed: () => addToCart(context, product),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Small white pill with a star icon and the rating value.
class RatingTag extends StatelessWidget {
  final double rating;

  const RatingTag({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.star_rounded, size: 13, color: AppColors.star),
          const SizedBox(width: 3),
          Text(
            rating.toStringAsFixed(1),
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppColors.ink,
            ),
          ),
        ],
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  final String text;
  final Color color;

  const _Badge({required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.4,
        ),
      ),
    );
  }
}

/// Round white favourite toggle, used on cards and the details page.
class FavoriteButton extends StatelessWidget {
  final Product product;
  final double size;

  const FavoriteButton({super.key, required this.product, this.size = 40});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Set<String>>(
      valueListenable: favoriteIds,
      builder: (context, ids, _) {
        final isFav = ids.contains(product.id);
        return SizedBox.square(
          dimension: size,
          child: IconButton(
            style: IconButton.styleFrom(
              backgroundColor: Colors.white,
              padding: EdgeInsets.zero,
            ),
            iconSize: size * 0.55,
            tooltip: isFav ? 'Remove from favourites' : 'Add to favourites',
            icon: Icon(
              isFav ? Icons.favorite : Icons.favorite_border,
              color: isFav ? AppColors.sale : AppColors.ink,
            ),
            onPressed: () => toggleFavorite(product),
          ),
        );
      },
    );
  }
}
