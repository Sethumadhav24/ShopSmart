import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_users/screens/auth/login.dart';
import 'package:shopsmart_users/screens/inner_screen/orders/orders_screen.dart';
import 'package:shopsmart_users/screens/inner_screen/viewed_recently.dart';
import 'package:shopsmart_users/screens/inner_screen/wishlist.dart';
import 'package:shopsmart_users/servies/asserts_manager.dart';

import 'package:shopsmart_users/widgets/subtitle_text.dart';
import 'package:shopsmart_users/widgets/title_text.dart';

import '../providers/theme_provider.dart';
import '../widgets/app_name_text.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(AssetsManager.shoppingCart),
          ),
          title: const AppNameTextWidget(fontSize: 20)),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Visibility(
              visible: false,
              child: Padding(
                padding: EdgeInsets.all(18.0),
                child: TitlesTextWidget(
                    label: "Please login to haev unimited access"),
              ),
            ),
            Visibility(
              visible: true,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).cardColor,
                        border: Border.all(
                            color: Theme.of(context).colorScheme.background,
                            width: 3),
                        image: const DecorationImage(
                          image: NetworkImage(
                              "https://th.bing.com/th/id/OIP.LfUcKCHKBamgN20k7KQWeAHaHT?rs=1&pid=ImgDetMain"),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Column(
                      children: [
                        TitlesTextWidget(label: "Sethu Madhav"),
                        SizedBox(
                          height: 2,
                        ),
                        SubtitleTextWidget(
                          label: "sethumadhav3456@gmail.com",
                          fontSize: 15,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TitlesTextWidget(label: "General"),
                  const SizedBox(
                    height: 5,
                  ),
                  CustomListTile(
                    text: "All orders",
                    imagePath: AssetsManager.orderSvg,
                    function: () {
                      Navigator.of(context)
                          .pushNamed(OrdersScreenFree.routeName);
                    },
                  ),
                  CustomListTile(
                    text: "Wishlist",
                    imagePath: AssetsManager.wishlistSvg,
                    function: () {
                      Navigator.pushNamed(context, WishListScreen.routName);
                    },
                  ),
                  CustomListTile(
                    text: "Viewed recently",
                    imagePath: AssetsManager.recent,
                    function: () {
                      Navigator.pushNamed(
                          context, ViewedRecentlyScreen.routName);
                    },
                  ),
                  CustomListTile(
                    text: "Address",
                    imagePath: AssetsManager.address,
                    function: () {},
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const TitlesTextWidget(label: "Settings"),
                  const SizedBox(
                    height: 10,
                  ),
                  SwitchListTile(
                    secondary: Image.asset(AssetsManager.theme),
                    title: Text(themeProvider.getIsDarkTheme
                        ? "Dark Theme"
                        : "Light Theme"),
                    value: themeProvider.getIsDarkTheme,
                    onChanged: (value) {
                      themeProvider.setDarkTheme(themeValue: value);
                      log("Theme state ${themeProvider.getIsDarkTheme}");
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const TitlesTextWidget(label: "Others"),
                  const SizedBox(
                    height: 5,
                  ),
                  CustomListTile(
                    text: "Privacy & policy",
                    imagePath: AssetsManager.privacy,
                    function: () {},
                  ),
                ],
              ),
            ),
            Center(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                icon: const Icon(
                  Icons.login,
                  color: Colors.white,
                ),
                label: const Text(
                  "Login",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  // await MyAppFunction.showErrorOrWarningDialog(
                  //   context: context,
                  //   subtitle: "Are you sure you want ot signout",
                  //   fct: () {},
                  //   isError: false,
                  // );
                  Navigator.of(context).pushNamed(LoginScreen.routName);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    required this.imagePath,
    required this.text,
    required this.function,
  });
  final String imagePath, text;
  final Function function;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        function();
      },
      title: SubtitleTextWidget(label: text, fontSize: 15),
      leading: Image.asset(
        imagePath,
        height: 34,
      ),
      trailing: const Icon(IconlyLight.arrowRight2),
    );
  }
}
