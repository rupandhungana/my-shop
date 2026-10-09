# MyShop - Mini E-Commerce App

| |                                          |
|---|------------------------------------------|
| **Student Name** | Rupan Dhungana                           |
| **Student ID** | 2510412211                                |
| **Course** | Mobile Application Development - Flutter |

## Description

MyShop is a multi-screen shopping app built with Flutter. It shows products grouped by category and lets users go from the home page to a category page and to a product details page. All product data is static and stored locally in `lib/data/product_data.dart`. There is no backend, login or payment.

## Features

- **Home page**: `AppBar` with the MyShop logo, a search icon and a cart icon with an item-count badge
- **Banner carousel**: 3 auto-playing promotional banners built with `carousel_slider`, each with a "Shop Now" button that opens its category
- **Horizontal category list**: 6 categories (Electronics, Fashion, Shoes, Beauty, Accessories, Home) in a `SingleChildScrollView` with `scrollDirection: Axis.horizontal`
- **Popular Products**: a grid of top-rated products with a "See All" button that shows every product
- **Reusable `ProductCard`**: a `Card` with a `Stack` over the image (sale/NEW badge and favourite button), category, name, rating, price and an add-to-cart `IconButton`; tapping the card opens the details page
- **Category page**: the selected category name is passed through `Navigator.push`, and its products are shown in a `GridView.builder`
- **Product details page**: image, name, category, rating, price, description, quantity selector, and an "Add to Cart" button that shows a `SnackBar`
- **Cart page** (bonus): lists added products with quantity, a remove button and the total, plus a Checkout button
- **Other bonus features**: product search (`SearchDelegate`), favourites, cart count badge and a Hero image animation

## Screenshots

| Home | Category | Product Details |
|---|---|---|
| ![Home](screenshots/home.png) | ![Category](screenshots/category.png) | ![Details](screenshots/details.png) |

## Packages Used

- [`carousel_slider`](https://pub.dev/packages/carousel_slider) `^5.1.2` is a carousel widget that supports auto-play, infinite scroll and enlarging the centre page. It powers the promotional banner slider on the home page. I used it because it handles swiping, auto-play timing and page-change callbacks (which drive the dot indicator), so I didn't have to build that with a `PageView` by hand.

## Project Structure

```
lib/
  main.dart
  theme.dart                    # colours and app theme
  models/
    product.dart
    category.dart
  data/
    product_data.dart           # products, categories, banners
    cart.dart                   # in-memory cart and favourites
  screens/
    home_page.dart
    category_page.dart
    product_details_page.dart
    cart_page.dart
  widgets/
    product_card.dart
    category_item.dart
    banner_carousel.dart
    cart_icon_button.dart
    product_image.dart
    product_search_delegate.dart
```

## How to Run

1. Install the [Flutter SDK](https://docs.flutter.dev/get-started/install).
2. Clone the repository:
   ```bash
   git clone https://github.com/rupandhungana/my-shop.git
   cd my-shop
   ```
3. Install dependencies:
   ```bash
   flutter pub get
   ```
4. Start an emulator or connect a device, then run:
   ```bash
   flutter run
   ```

Product images load from Unsplash URLs, so the device needs an internet connection.
