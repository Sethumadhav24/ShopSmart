import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shopsmart_users/providers/cart_provider.dart';
import 'package:shopsmart_users/providers/products_provider.dart';
import 'package:shopsmart_users/widgets/app_name_text.dart';
import 'package:shopsmart_users/widgets/product/heart_button.dart';
import 'package:shopsmart_users/widgets/subtitle_text.dart';
import 'package:shopsmart_users/widgets/title_text.dart';

class ProductDetailsScreen extends StatefulWidget {
  static const routName = "/ProductDetailsScreen";
  const ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductsProvider>(context);
    String? productId = ModalRoute.of(context)!.settings.arguments as String?;
    final getCurrentProduct = productsProvider.findByProductId(productId!);
    final cartProvider = Provider.of<CartProvider>(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.canPop(context) ? Navigator.pop(context) : null;
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 20,
            )),
        title: const AppNameTextWidget(fontSize: 20),
      ),
      body: getCurrentProduct == null
          ? const SizedBox.shrink()
          : SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  FancyShimmerImage(
                    imageUrl: getCurrentProduct.productImage,
                    height: size.height * 0.350,
                    width: double.infinity,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              child: Text(
                                getCurrentProduct.productTitle,
                                softWrap: true,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            SubtitleTextWidget(
                              label: "${getCurrentProduct.productPrice}\$",
                              fontWeight: FontWeight.w700,
                              color: Colors.blue,
                              fontSize: 20,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              HeartButtonWidget(
                                  bkgColor: Colors.blue.shade500,
                                  productId: getCurrentProduct.productId),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: SizedBox(
                                  height: kBottomNavigationBarHeight - 10,
                                  child: ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color.fromARGB(
                                          255, 231, 12, 12),
                                    ),
                                    onPressed: () {
                                      if (cartProvider.isProdinCart(
                                          productId:
                                              getCurrentProduct.productId)) {
                                        return;
                                      }
                                      cartProvider.addProductToCart(
                                          productId:
                                              getCurrentProduct.productId);
                                    },
                                    icon: Icon(
                                      cartProvider.isProdinCart(
                                              productId:
                                                  getCurrentProduct.productId)
                                          ? Icons.check
                                          : Icons.add_shopping_cart_outlined,
                                    ),
                                    label: Text(cartProvider.isProdinCart(
                                            productId:
                                                getCurrentProduct.productId)
                                        ? "In cart"
                                        : "Add to cart"),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const TitlesTextWidget(label: "About this item"),
                            SubtitleTextWidget(
                                label:
                                    "In ${getCurrentProduct.productCategory}",
                                fontSize: 15)
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        SubtitleTextWidget(
                            label: getCurrentProduct.productDescription,
                            fontSize: 15),
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
