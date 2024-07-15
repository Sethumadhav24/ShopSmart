import 'dart:developer';

import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_users/providers/cart_provider.dart';
import 'package:shopsmart_users/providers/products_provider.dart';
import 'package:shopsmart_users/providers/viewed_recently_provider.dart';
import 'package:shopsmart_users/screens/inner_screen/product_details.dart';
import 'package:shopsmart_users/widgets/product/heart_button.dart';
import 'package:shopsmart_users/widgets/subtitle_text.dart';
import 'package:shopsmart_users/widgets/title_text.dart';

class ProductWidget extends StatefulWidget {
  const ProductWidget({super.key, required this.productId});

  final String productId;
  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  @override
  Widget build(BuildContext context) {
    final viewedProdProvider = Provider.of<ViewedProdProvider>(context);
    final productsProvider = Provider.of<ProductsProvider>(context);
    final getCurrentProduct =
        productsProvider.findByProductId(widget.productId);
    // final productModelProvider = Provider.of<ProductModel>(context);
    final cartProvider = Provider.of<CartProvider>(context);

    Size size = MediaQuery.of(context).size;
    return getCurrentProduct == null
        ? const SizedBox.shrink()
        : Padding(
            padding: const EdgeInsets.all(3.0),
            child: GestureDetector(
              onTap: () async {
                viewedProdProvider.addViewedProd(
                    productId: getCurrentProduct.productId);
                await Navigator.pushNamed(
                    context, ProductDetailsScreen.routName,
                    arguments: getCurrentProduct.productId);
              },
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: FancyShimmerImage(
                      imageUrl: getCurrentProduct.productImage,
                      height: size.height * 0.22,
                      width: double.infinity,
                    ),
                  ),
                  const SizedBox(
                    height: 6.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 5,
                          child: TitlesTextWidget(
                            label: getCurrentProduct.productTitle,
                            maxLines: 2,
                          ),
                        ),
                        Flexible(
                          flex: 2,
                          child: HeartButtonWidget(
                              productId: getCurrentProduct.productId),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 6.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 1,
                        child: SubtitleTextWidget(
                          label: "${getCurrentProduct.productPrice}\$",
                          fontWeight: FontWeight.w600,
                          color: Colors.blue,
                          fontSize: 15,
                        ),
                      ),
                      Flexible(
                        child: Material(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.lightBlue,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(10.0),
                            onTap: () {
                              if (cartProvider.isProdinCart(
                                  productId: getCurrentProduct.productId)) {
                                return;
                              }
                              cartProvider.addProductToCart(
                                  productId: getCurrentProduct.productId);
                            },
                            splashColor: Colors.red,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Icon(
                                cartProvider.isProdinCart(
                                        productId: getCurrentProduct.productId)
                                    ? Icons.check
                                    : Icons.add_shopping_cart_outlined,
                                size: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 6.0,
                  ),
                ],
              ),
            ),
          );
  }
}