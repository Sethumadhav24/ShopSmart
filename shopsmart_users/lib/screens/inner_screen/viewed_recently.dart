import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_users/providers/viewed_recently_provider.dart';
import 'package:shopsmart_users/servies/asserts_manager.dart';
import 'package:shopsmart_users/widgets/empty_bag.dart';
import 'package:shopsmart_users/widgets/product/product_widget.dart';
import 'package:shopsmart_users/widgets/title_text.dart';

class ViewedRecentlyScreen extends StatelessWidget {
  static const routName = "/ViewedRecentlyScreen";
  const ViewedRecentlyScreen({super.key});

  final bool isEmpty = false;

  @override
  Widget build(BuildContext context) {
    final viewedProdProvider = Provider.of<ViewedProdProvider>(context);
    return viewedProdProvider.getViewedProds.isEmpty
        ? Scaffold(
            body: EmptyBagWidget(
                imagePath: AssetsManager.orderBag,
                title: "NO viewd products yet",
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
                  label:
                      "Viewed recently (${viewedProdProvider.getViewedProds.length})"),
              actions: [
                IconButton(
                    onPressed: () {},
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
                      productId: viewedProdProvider.getViewedProds.values
                          .toList()[index]
                          .productId),
                );
              },
              itemCount: viewedProdProvider.getViewedProds.length,
              crossAxisCount: 2,
            ),
          );
  }
}
