import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shopsmart_users/providers/cart_provider.dart';
import 'package:shopsmart_users/providers/products_provider.dart';
import 'package:shopsmart_users/widgets/subtitle_text.dart';
import 'package:shopsmart_users/widgets/title_text.dart';

class CartNottomSheetWdiget extends StatelessWidget {
  const CartNottomSheetWdiget({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final productsProvider = Provider.of<ProductsProvider>(context);
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: const Border(
          top: BorderSide(width: 1, color: Colors.grey),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SizedBox(
          height: kBottomNavigationBarHeight + 10,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FittedBox(
                      child: TitlesTextWidget(
                          label:
                              "Total (${cartProvider.getCartitems.length} products/${cartProvider.getQty()} items)")),
                  SubtitleTextWidget(
                    label:
                        "${cartProvider.getTotal(productsProvider: productsProvider).toStringAsFixed(2)}\$",
                    color: Colors.blue,
                    fontSize: 15,
                  ),
                ],
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black12,
                ),
                onPressed: () {},
                child: const Text("CheckOut"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
