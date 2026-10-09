import 'package:flutter/material.dart';

import '../models/category.dart';
import '../models/product.dart';

String _unsplash(String id) =>
    'https://images.unsplash.com/photo-$id?w=600&q=80&auto=format&fit=crop';

class BannerItem {
  final String title;
  final String subtitle;
  final String image;
  final String category;

  const BannerItem({
    required this.title,
    required this.subtitle,
    required this.image,
    required this.category,
  });
}

const List<BannerItem> banners = [
  BannerItem(
    title: 'Summer Sale',
    subtitle: 'Up to 50% off on fashion',
    image:
        'https://images.unsplash.com/photo-1607083206869-4c7672e72a8a?w=1200&q=80&auto=format&fit=crop',
    category: 'Fashion',
  ),
  BannerItem(
    title: 'New Arrivals',
    subtitle: 'Fresh sneakers just dropped',
    image:
        'https://images.unsplash.com/photo-1441986300917-64674bd600d8?w=1200&q=80&auto=format&fit=crop',
    category: 'Shoes',
  ),
  BannerItem(
    title: 'Electronics Discount',
    subtitle: 'Save big on gadgets',
    image:
        'https://images.unsplash.com/photo-1498049794561-7780e7231661?w=1200&q=80&auto=format&fit=crop',
    category: 'Electronics',
  ),
];

const List<Category> categories = [
  Category(name: 'Electronics', icon: Icons.headphones_outlined),
  Category(name: 'Fashion', icon: Icons.checkroom_outlined),
  Category(name: 'Shoes', icon: Icons.directions_walk_outlined),
  Category(name: 'Beauty', icon: Icons.face_retouching_natural_outlined),
  Category(name: 'Accessories', icon: Icons.watch_outlined),
  Category(name: 'Home', icon: Icons.chair_outlined),
];

final List<Product> products = [
  Product(
    id: 'p1',
    name: 'iPhone 15',
    category: 'Electronics',
    image: _unsplash('1592750475338-74b7b21085ab'),
    price: 135000,
    oldPrice: 150000,
    rating: 4.8,
    description:
        'A powerful smartphone with a stunning display, advanced dual-camera system and all-day battery life.',
  ),
  Product(
    id: 'p2',
    name: 'Laptop Pro 14"',
    category: 'Electronics',
    image: _unsplash('1496181133206-80ce9b88a853'),
    price: 165000,
    rating: 4.7,
    description:
        'Thin and light laptop with a fast processor, 16GB RAM and 512GB SSD. Perfect for work and study.',
    isNew: true,
  ),
  Product(
    id: 'p3',
    name: 'Wireless Headphones',
    category: 'Electronics',
    image: _unsplash('1505740420928-5e560c06d30e'),
    price: 3500,
    oldPrice: 5000,
    rating: 4.5,
    description:
        'Wireless headphones with high-quality sound, deep bass and up to 30 hours of playback.',
  ),
  Product(
    id: 'p4',
    name: 'Classic T-Shirt',
    category: 'Fashion',
    image: _unsplash('1521572163474-6864f9cf17ab'),
    price: 1200,
    rating: 4.2,
    description:
        '100% cotton crew-neck t-shirt. Soft, breathable and perfect for everyday wear.',
    isNew: true,
  ),
  Product(
    id: 'p5',
    name: 'Leather Jacket',
    category: 'Fashion',
    image: _unsplash('1551028719-00167b16eac5'),
    price: 8500,
    oldPrice: 11000,
    rating: 4.6,
    description:
        'Premium leather jacket with a slim fit, zip closure and quilted lining for colder days.',
  ),
  Product(
    id: 'p6',
    name: 'Red Sneakers',
    category: 'Shoes',
    image: _unsplash('1542291026-7eec264c27ff'),
    price: 6500,
    oldPrice: 8000,
    rating: 4.7,
    description:
        'Lightweight running sneakers with breathable mesh and a cushioned sole for all-day comfort.',
  ),
  Product(
    id: 'p7',
    name: 'Running Shoes',
    category: 'Shoes',
    image: _unsplash('1608231387042-66d1773070a5'),
    price: 5200,
    rating: 4.4,
    description:
        'Responsive running shoes designed for speed, with a grippy outsole and supportive fit.',
    isNew: true,
  ),
  Product(
    id: 'p8',
    name: 'Eau de Parfum',
    category: 'Beauty',
    image: _unsplash('1541643600914-78b084683601'),
    price: 4800,
    rating: 4.6,
    description:
        'A long-lasting fragrance with floral and woody notes. 100ml glass bottle.',
  ),
  Product(
    id: 'p9',
    name: 'Skincare Set',
    category: 'Beauty',
    image: _unsplash('1556228578-8c89e6adf883'),
    price: 2900,
    oldPrice: 3600,
    rating: 4.3,
    description:
        'Daily skincare routine set including cleanser, toner and moisturiser for healthy skin.',
  ),
  Product(
    id: 'p10',
    name: 'Smart Watch',
    category: 'Accessories',
    image: _unsplash('1523275335684-37898b6baf30'),
    price: 12000,
    oldPrice: 15000,
    rating: 4.5,
    description:
        'Track your fitness, heart rate and notifications with this stylish water-resistant smart watch.',
  ),
  Product(
    id: 'p11',
    name: 'Sunglasses',
    category: 'Accessories',
    image: _unsplash('1572635196237-14b3f281503f'),
    price: 2200,
    rating: 4.1,
    description:
        'UV400 protected sunglasses with a lightweight frame and polarised lenses.',
    isNew: true,
  ),
  Product(
    id: 'p12',
    name: 'Travel Backpack',
    category: 'Accessories',
    image: _unsplash('1553062407-98eeb64c6a62'),
    price: 3800,
    rating: 4.4,
    description:
        'Durable, water-resistant backpack with a padded laptop sleeve and multiple compartments.',
  ),
  Product(
    id: 'p13',
    name: 'Table Lamp',
    category: 'Home',
    image: _unsplash('1507473885765-e6ed057f782c'),
    price: 2600,
    rating: 4.2,
    description:
        'Minimal table lamp with a warm light, ideal for bedside tables and study desks.',
  ),
  Product(
    id: 'p14',
    name: 'Ceramic Mug',
    category: 'Home',
    image: _unsplash('1514228742587-6b1558fcca3d'),
    price: 650,
    oldPrice: 900,
    rating: 4.0,
    description:
        'Handmade ceramic coffee mug, 350ml. Microwave and dishwasher safe.',
  ),
];

List<Product> productsByCategory(String category) =>
    products.where((p) => p.category == category).toList();

String formatPrice(double price) {
  final digits = price.toStringAsFixed(0);
  final buffer = StringBuffer();
  for (var i = 0; i < digits.length; i++) {
    if (i > 0 && (digits.length - i) % 3 == 0) buffer.write(',');
    buffer.write(digits[i]);
  }
  return 'Rs. $buffer';
}
