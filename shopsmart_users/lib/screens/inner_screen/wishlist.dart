import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_users/providers/wishlist_provider.dart';
import 'package:shopsmart_users/servies/asserts_manager.dart';
import 'package:shopsmart_users/servies/my_app_function.dart';
import 'package:shopsmart_users/widgets/empty_bag.dart';
import 'package:shopsmart_users/widgets/product/product_widget.dart';
import 'package:shopsmart_users/widgets/title_text.dart';

class WishListScreen extends StatelessWidget {
  static const routName = "/WishListScreen";
  const WishListScreen({super.key});

  final bool isEmpty = true;

  @override
  Widget build(BuildContext context) {
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    return wishlistProvider.getwishlists.isEmpty
        ? Scaffold(
            body: EmptyBagWidget(
                imagePath: AssetsManager.bagWish,
                title: "Nothing in your wishlist yet",
                subtitle:
                    "Locks like your cart is empty add something and make me happy!",
                buttonText: "Shop Now!"),
          )
        : Scaffold(
            appBar: AppBar(
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(AssetsManager.shoppingCart),
              ),
              title: TitlesTextWidget(
                  label: "WishList (${wishlistProvider.getwishlists.length})"),
              actions: [
                IconButton(
                    onPressed: () {
                      MyAppFunction.showErrorOrWarningDialog(
                        isError: false,
                        context: context,
                        subtitle: "Clear Wishlist?",
                        fct: () {
                          // await wishlistProvider.clearWishlistFromFirebase();
                          wishlistProvider.clearLocalWishList();
                        },
                      );
                    },
                    icon: const Icon(Icons.delete_forever_rounded))
              ],
            ),
            body: DynamicHeightGridView(
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              builder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ProductWidget(
                    productId: wishlistProvider.getwishlists.values
                        .toList()[index]
                        .productId,
                  ),
                );
              },
              itemCount: wishlistProvider.getwishlists.length,
              crossAxisCount: 2,
            ),
          );
  }
}
