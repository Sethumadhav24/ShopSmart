import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_users/consts/app_contants.dart';
import 'package:shopsmart_users/providers/products_provider.dart';
import 'package:shopsmart_users/servies/asserts_manager.dart';
import 'package:shopsmart_users/widgets/app_name_text.dart';
import 'package:shopsmart_users/widgets/product/ctg_rounded_widget.dart';
import 'package:shopsmart_users/widgets/product/latest_arrival.dart';
import 'package:shopsmart_users/widgets/title_text.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final productsProvider = Provider.of<ProductsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(AssetsManager.shoppingCart),
        ),
        title: const AppNameTextWidget(fontSize: 20),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height * 0.25,
                child: Swiper(
                  autoplay: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Image.asset(
                      AppConstants.bannersImages[index],
                      fit: BoxFit.fill,
                    );
                  },
                  itemCount: AppConstants.bannersImages.length,
                  pagination: const SwiperPagination(
                    // alignment: Alignment.bottomCenter,
                    builder: DotSwiperPaginationBuilder(
                        activeColor: Colors.red, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const TitlesTextWidget(label: "Latest Arrivals"),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: size.height * 0.175,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return ChangeNotifierProvider.value(
                        value: productsProvider.getProducts[index],
                        child: const LatestArrivalProductswidget());
                  },
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              const TitlesTextWidget(label: " Categories"),
              const SizedBox(
                height: 10,
              ),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 4,
                children: List.generate(
                  AppConstants.catagoriestList.length,
                  (index) {
                    return CategoryRoundedWidget(
                        image: AppConstants.catagoriestList[index].image,
                        name: AppConstants.catagoriestList[index].name);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
