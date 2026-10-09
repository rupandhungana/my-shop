class Product {
  final String id;
  final String name;
  final String category;
  final String image;
  final double price;
  final double? oldPrice;
  final double rating;
  final String description;
  final bool isNew;

  const Product({
    required this.id,
    required this.name,
    required this.category,
    required this.image,
    required this.price,
    this.oldPrice,
    required this.rating,
    required this.description,
    this.isNew = false,
  });

  /// Discount percentage, or null if the product is not on sale.
  int? get discountPercent {
    if (oldPrice == null || oldPrice! <= price) return null;
    return (((oldPrice! - price) / oldPrice!) * 100).round();
  }
}
