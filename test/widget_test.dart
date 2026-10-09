import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:my_shop/data/cart.dart';
import 'package:my_shop/data/product_data.dart';
import 'package:my_shop/main.dart';
import 'package:my_shop/screens/cart_page.dart';
import 'package:my_shop/screens/category_page.dart';
import 'package:my_shop/screens/product_details_page.dart';
import 'package:my_shop/widgets/category_item.dart';
import 'package:my_shop/widgets/product_card.dart';

void useSmallPhone(WidgetTester tester) {
  tester.view.physicalSize = const Size(320, 640);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
}

void main() {
  setUp(clearCart);

  testWidgets('Home page shows AppBar, categories and products', (
    tester,
  ) async {
    await tester.pumpWidget(const MyShopApp());

    expect(find.byType(AppBar), findsOneWidget);
    expect(find.text('MyShop'), findsOneWidget);
    expect(find.text('Popular Products'), findsOneWidget);
    expect(find.byType(CategoryItem), findsNWidgets(categories.length));
  });

  testWidgets('Home -> Category -> Details -> Add to Cart', (tester) async {
    useSmallPhone(tester);
    await tester.pumpWidget(const MyShopApp());

    await tester.tap(find.widgetWithText(CategoryItem, 'Shoes'));
    await tester.pumpAndSettle();
    expect(find.text('2 products'), findsOneWidget);

    await tester.tap(find.byType(ProductCard).first);
    await tester.pumpAndSettle();
    expect(find.byType(ProductDetailsPage), findsOneWidget);

    await tester.tap(find.text('Add to Cart'));
    await tester.pump();
    expect(find.textContaining('added to cart'), findsOneWidget);
  });

  testWidgets('Cart shows added items, total and empties on remove', (
    tester,
  ) async {
    useSmallPhone(tester);
    await tester.pumpWidget(const MyShopApp());

    final addButton = find.byTooltip('Add to cart').first;
    await tester.ensureVisible(addButton);
    await tester.tap(addButton);
    await tester.tap(addButton);
    await tester.pump();

    await tester.tap(find.byTooltip('Cart'), warnIfMissed: false);
    await tester.pumpAndSettle();
    expect(find.byType(CartPage), findsOneWidget);

    final product = products.firstWhere((p) => p.rating >= 4.5);
    expect(
      find.text('${formatPrice(product.price)}  |  Qty 2'),
      findsOneWidget,
    );
    expect(find.text(formatPrice(product.price * 2)), findsOneWidget);

    await tester.tap(find.byTooltip('Remove'));
    await tester.pump();
    expect(find.text('Your cart is empty'), findsOneWidget);
  });

  testWidgets('All screens render without overflow on a small phone', (
    tester,
  ) async {
    useSmallPhone(tester);

    await tester.pumpWidget(const MyShopApp());
    await tester.pump();

    await tester.pumpWidget(
      const MaterialApp(home: CategoryPage(categoryName: allProductsCategory)),
    );
    await tester.pump();

    for (final product in products) {
      addToCart(tester.element(find.byType(CategoryPage)), product);
    }
    await tester.pumpWidget(const MaterialApp(home: CartPage()));
    await tester.pump();

    for (final product in products) {
      await tester.pumpWidget(
        MaterialApp(home: ProductDetailsPage(product: product)),
      );
      await tester.pump();
    }
  });
}
