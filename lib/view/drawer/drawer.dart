import 'package:flutter/material.dart';
import 'package:flutter_restapi/app_store/shared_preference.dart';
import 'package:flutter_restapi/data/models/loginUser_model.dart';
import 'package:flutter_restapi/routes/routes_name.dart';
import 'package:flutter_restapi/utils/app_img.dart';
import 'package:flutter_restapi/utils/toastMessage.dart';
import '../responsive_layout.dart';
import 'drawer_item.dart';

class Drawer_View extends StatelessWidget {
  const Drawer_View({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      padding: const EdgeInsets.only(top: 20),
      color: Theme.of(context).canvasColor,
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Row(
                children: [
                  Flexible(
                    child: Image.network(
                      user!.image.toString(),
                      width: 150,
                    ),
                  ),
                  const Spacer(),
                  if (!ResponsiveLayout.isDesktop(context)) const CloseButton(),
                ],
              ),
              const SizedBox(height: 20 * 2),
              DrawerItem(
                onPressed: () {
                  Navigator.pushNamed(context, RouteName.accountScreen);
                },
                title: "Your Account",
                icon: Icons.person_outline_outlined,
              ),
              DrawerItem(
                onPressed: () {},
                title: "Your Orders",
                icon: Icons.cloud_circle_outlined,
              ),
              DrawerItem(
                onPressed: () {
                  Navigator.pushNamed(context, RouteName.cartScreen);
                },
                title: "Your Cart",
                icon: Icons.shopping_bag_outlined,
                selected: false,
              ),
              DrawerItem(
                onPressed: () {},
                title: "Security",
                icon: Icons.lock_outline_rounded,
              ),
              DrawerItem(
                onPressed: () {},
                title: "Your Payments",
                icon: Icons.payment,
              ),
              DrawerItem(
                onPressed: () {},
                title: "Gift Cards",
                icon: Icons.card_giftcard,
              ),
              DrawerItem(
                onPressed: () {},
                title: "Communication",
                icon: Icons.drafts_outlined,
              ),
              DrawerItem(
                onPressed: () {},
                title: "Messages",
                icon: Icons.message_outlined,
                number: 2,
              ),
              DrawerItem(
                onPressed: () {},
                title: "Notifications",
                icon: Icons.notifications_active_outlined,
              ),
              DrawerItem(
                onPressed: () {},
                title: "Advertising",
                icon: Icons.account_box_outlined,
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
