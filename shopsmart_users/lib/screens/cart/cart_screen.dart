import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_users/providers/cart_provider.dart';
import 'package:shopsmart_users/screens/cart/bottom_checkout.dart';
import 'package:shopsmart_users/screens/cart/cart_widget.dart';
import 'package:shopsmart_users/servies/asserts_manager.dart';
import 'package:shopsmart_users/servies/my_app_function.dart';
import 'package:shopsmart_users/widgets/empty_bag.dart';
import 'package:shopsmart_users/widgets/title_text.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  final bool isEmpty = false;

  @override
  Widget build(BuildContext context) {
    // final productsProvider = Provider.of<ProductsProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    return cartProvider.getCartitems.isEmpty
        ? Scaffold(
            body: EmptyBagWidget(
                imagePath: AssetsManager.shoppingBasket,
                title: "Your cart is empty",
                subtitle:
                    "Locks like your cart is empty add something and make me happy!",
                buttonText: "Shop Now!"),
          )
        : Scaffold(
            bottomSheet: const CartNottomSheetWdiget(),
            appBar: AppBar(
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(AssetsManager.shoppingCart),
              ),
              title: TitlesTextWidget(
                  label: "Cart (${cartProvider.getCartitems.length})"),
              actions: [
                IconButton(
                    onPressed: () {
                      MyAppFunction.showErrorOrWarningDialog(
                        isError: false,
                        context: context,
                        subtitle: "Clear cart?",
                        fct: () async {
                          // cartProvider.clearCartFromFirebase();
                          cartProvider.clearLocalCart();
                        },
                      );
                    },
                    icon: const Icon(Icons.delete_forever_rounded))
              ],
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartProvider.getCartitems.length,
                    itemBuilder: (context, index) {
                      return ChangeNotifierProvider.value(
                        value: cartProvider.getCartitems.values.toList()[index],
                        child: const CartWidget(),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: kBottomNavigationBarHeight + 10,
                )
              ],
            ),
          );
  }
}
