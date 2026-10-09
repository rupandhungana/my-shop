import 'package:flutter/material.dart';

import '../models/product.dart';

/// Simple in-memory cart and favourites (no backend required).
///
/// The cart maps each product id to its quantity.
final ValueNotifier<Map<String, int>> cartItems =
    ValueNotifier<Map<String, int>>({});
final ValueNotifier<Set<String>> favoriteIds = ValueNotifier<Set<String>>({});

int cartCount(Map<String, int> items) =>
    items.values.fold(0, (sum, quantity) => sum + quantity);

/// Adds [product] to the cart and confirms it with a SnackBar.
void addToCart(BuildContext context, Product product, {int quantity = 1}) {
  final items = {...cartItems.value};
  items[product.id] = (items[product.id] ?? 0) + quantity;
  cartItems.value = items;

  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text('${product.name} added to cart')));
}

void removeFromCart(Product product) {
  final items = {...cartItems.value}..remove(product.id);
  cartItems.value = items;
}

void clearCart() => cartItems.value = {};

void toggleFavorite(Product product) {
  final ids = {...favoriteIds.value};
  if (!ids.remove(product.id)) ids.add(product.id);
  favoriteIds.value = ids;
}
